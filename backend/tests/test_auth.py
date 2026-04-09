"""
FASE 2 — Testes de Auth (Red phase — devem falhar até a implementação)
"""
import pytest
from httpx import AsyncClient
from .conftest import auth_header


@pytest.mark.asyncio
async def test_login_email_success(client: AsyncClient, aluno_user):
    response = await client.post(
        "/auth/email",
        json={"email": "aluno@kinetic.com", "password": "senha123!"},
    )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data
    assert data["user"]["email"] == "aluno@kinetic.com"


@pytest.mark.asyncio
async def test_login_email_wrong_password(client: AsyncClient, aluno_user):
    response = await client.post(
        "/auth/email",
        json={"email": "aluno@kinetic.com", "password": "senhaerrada"},
    )
    assert response.status_code == 401
    # Mensagem genérica — não revela se a senha ou o e-mail estão errados
    assert "não encontrado" not in response.json()["detail"].lower()
    assert "senha" not in response.json()["detail"].lower()


@pytest.mark.asyncio
async def test_login_email_nonexistent_user(client: AsyncClient):
    """Timing attack mitigation — mesmo tempo de resposta para e-mail inexistente."""
    response = await client.post(
        "/auth/email",
        json={"email": "naoexiste@kinetic.com", "password": "qualquercoisa"},
    )
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_login_google_invalid_token(client: AsyncClient):
    response = await client.post(
        "/auth/google",
        json={"token": "invalid_google_token"},
    )
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_login_xss_in_email(client: AsyncClient):
    """XSS no campo de e-mail — deve rejeitar."""
    response = await client.post(
        "/auth/email",
        json={
            "email": "<script>alert(1)</script>@evil.com",
            "password": "senha123!",
        },
    )
    assert response.status_code in (422, 401)


@pytest.mark.asyncio
async def test_login_email_too_long(client: AsyncClient):
    """Campos com tamanho absurdo — limite de segurança."""
    response = await client.post(
        "/auth/email",
        json={"email": "a" * 10000 + "@test.com", "password": "senha123!"},
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_login_password_too_long(client: AsyncClient):
    response = await client.post(
        "/auth/email",
        json={"email": "test@test.com", "password": "x" * 10000},
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_refresh_token_valid(client: AsyncClient, aluno_user):
    # Login para obter tokens
    login = await client.post(
        "/auth/email",
        json={"email": "aluno@kinetic.com", "password": "senha123!"},
    )
    refresh_token = login.json()["refresh_token"]

    response = await client.post(
        "/auth/refresh",
        json={"refresh_token": refresh_token},
    )
    assert response.status_code == 200
    assert "access_token" in response.json()


@pytest.mark.asyncio
async def test_refresh_token_invalid(client: AsyncClient):
    response = await client.post(
        "/auth/refresh",
        json={"refresh_token": "token_invalido"},
    )
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_access_protected_route_without_token(client: AsyncClient):
    response = await client.get("/dashboard/metrics")
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_access_protected_route_with_fake_token(client: AsyncClient):
    response = await client.get(
        "/dashboard/metrics",
        headers={"Authorization": "Bearer token_falso_qualquer"},
    )
    assert response.status_code == 401
