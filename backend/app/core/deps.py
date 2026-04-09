from typing import Annotated
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from jose import JWTError
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from .database import get_db
from .security import decode_token
from ..models.user import User

bearer = HTTPBearer(auto_error=False)


async def get_current_user(
    credentials: Annotated[
        HTTPAuthorizationCredentials | None, Depends(bearer)
    ],
    db: Annotated[AsyncSession, Depends(get_db)],
) -> User:
    """
    Extrai e valida o JWT.
    Retorna 401 com mensagem genérica — nunca revela o motivo exato.
    """
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Não autenticado.",
        headers={"WWW-Authenticate": "Bearer"},
    )

    if credentials is None:
        raise credentials_exception

    try:
        payload = decode_token(credentials.credentials)
        user_id: str = payload.get("sub")
        token_type: str = payload.get("type")
        if user_id is None or token_type != "access":
            raise credentials_exception
    except JWTError:
        raise credentials_exception

    result = await db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    if user is None:
        raise credentials_exception

    return user


async def require_trainer(
    current_user: Annotated[User, Depends(get_current_user)],
) -> User:
    """Deny by default — só personal_trainer passa."""
    if current_user.role != "personal_trainer":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Acesso negado.",
        )
    return current_user


async def require_aluno(
    current_user: Annotated[User, Depends(get_current_user)],
) -> User:
    """Deny by default — só aluno passa."""
    if current_user.role != "aluno":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Acesso negado.",
        )
    return current_user


# Type aliases convenientes
CurrentUser = Annotated[User, Depends(get_current_user)]
TrainerUser = Annotated[User, Depends(require_trainer)]
AlunoUser = Annotated[User, Depends(require_aluno)]
DB = Annotated[AsyncSession, Depends(get_db)]
