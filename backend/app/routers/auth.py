from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, status, Request
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from pydantic import BaseModel, EmailStr, Field
from slowapi import Limiter
from slowapi.util import get_remote_address
import httpx

from ..core.database import get_db
from ..core.security import (
    hash_password,
    verify_password,
    needs_rehash,
    create_access_token,
    create_refresh_token,
    decode_token,
)
from ..core.config import settings
from ..core.deps import DB
from ..models.user import User

router = APIRouter(prefix="/auth", tags=["auth"])
limiter = Limiter(key_func=get_remote_address)


# --- Schemas ---
class EmailLoginRequest(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8, max_length=128)


class RegisterRequest(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8, max_length=128)
    name: str = Field(min_length=2, max_length=100)
    role: str = Field(pattern="^(personal_trainer|aluno)$", default="aluno")


class GoogleLoginRequest(BaseModel):
    token: str = Field(max_length=4096)


class AuthResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user: dict


class RefreshRequest(BaseModel):
    refresh_token: str = Field(max_length=4096)


# --- Helpers ---
def _build_response(user: User) -> AuthResponse:
    return AuthResponse(
        access_token=create_access_token(user.id, user.role),
        refresh_token=create_refresh_token(user.id),
        user={
            "id": user.id,
            "email": user.email,
            "name": user.name,
            "role": user.role,
            "photo_url": user.photo_url,
        },
    )


def _generic_error():
    """Mensagem genérica — não revelar se e-mail existe ou não."""
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Credenciais inválidas.",
    )


# --- Endpoints ---
@router.post("/register", response_model=AuthResponse, status_code=201)
@limiter.limit("3/minute")
async def register(
    request: Request,
    body: RegisterRequest,
    db: DB,
):
    """Cria conta com email + senha. Mensagem genérica se email já existe."""
    result = await db.execute(
        select(User).where(User.email == body.email.lower())
    )
    if result.scalar_one_or_none() is not None:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Não foi possível criar a conta.",
        )

    user = User(
        email=body.email.lower(),
        hashed_password=hash_password(body.password),
        name=body.name.strip(),
        role=body.role,
    )
    db.add(user)
    await db.flush()
    return _build_response(user)


@router.post("/email", response_model=AuthResponse, status_code=200)
@limiter.limit("5/minute")
async def login_email(
    request: Request,
    body: EmailLoginRequest,
    db: DB,
):
    result = await db.execute(
        select(User).where(User.email == body.email.lower())
    )
    user = result.scalar_one_or_none()

    # Timing consistente — dificulta timing attacks
    if user is None or user.hashed_password is None:
        # Roda hash de qualquer forma para tempo constante
        hash_password("dummy_timing_password_xk9")
        _generic_error()

    if not verify_password(body.password, user.hashed_password):
        _generic_error()

    if not user.is_active:
        _generic_error()

    # Rehash transparente se necessário (parâmetros mudaram)
    if needs_rehash(user.hashed_password):
        user.hashed_password = hash_password(body.password)
        await db.commit()

    return _build_response(user)


@router.post("/google", response_model=AuthResponse, status_code=200)
@limiter.limit("10/minute")
async def login_google(
    request: Request,
    body: GoogleLoginRequest,
    db: DB,
):
    # Verifica o token com a API do Google
    async with httpx.AsyncClient() as client:
        resp = await client.get(
            "https://oauth2.googleapis.com/tokeninfo",
            params={"id_token": body.token},
        )

    if resp.status_code != 200:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token Google inválido.",
        )

    google_data = resp.json()

    # Valida audience para evitar token de outro app
    if google_data.get("aud") != settings.GOOGLE_CLIENT_ID:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token Google inválido.",
        )

    google_id = google_data.get("sub")
    email = google_data.get("email", "").lower()
    name = google_data.get("name", "")
    photo = google_data.get("picture")

    # Upsert: cria ou retorna usuário existente
    result = await db.execute(
        select(User).where(User.google_id == google_id)
    )
    user = result.scalar_one_or_none()

    if user is None:
        # Tenta vincular por e-mail caso já exista conta local
        result = await db.execute(
            select(User).where(User.email == email)
        )
        user = result.scalar_one_or_none()

        if user is None:
            # Novo usuário via Google — role padrão = aluno
            user = User(
                email=email,
                google_id=google_id,
                name=name,
                photo_url=photo,
                role="aluno",
            )
            db.add(user)
            await db.flush()
        else:
            user.google_id = google_id
            if photo and not user.photo_url:
                user.photo_url = photo

    return _build_response(user)


@router.post("/refresh", response_model=AuthResponse)
async def refresh_token(body: RefreshRequest, db: DB):
    from jose import JWTError
    try:
        payload = decode_token(body.refresh_token)
        if payload.get("type") != "refresh":
            raise HTTPException(status_code=401, detail="Token inválido.")
        user_id = payload.get("sub")
    except JWTError:
        raise HTTPException(status_code=401, detail="Token inválido.")

    result = await db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    if user is None or not user.is_active:
        raise HTTPException(status_code=401, detail="Token inválido.")

    return _build_response(user)


@router.post("/logout", status_code=204)
async def logout():
    # JWT stateless — o cliente apaga o token local
    # Para revogação real, seria necessário uma blocklist (Redis)
    return
