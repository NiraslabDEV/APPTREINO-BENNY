"""Testes do dashboard do Personal Trainer."""
import pytest
from httpx import AsyncClient
from .conftest import auth_header


@pytest.mark.asyncio
async def test_dashboard_metrics_trainer_only(
    client: AsyncClient,
    trainer_user,
    trainer_token,
):
    response = await client.get(
        "/dashboard/metrics",
        headers=auth_header(trainer_token),
    )
    assert response.status_code == 200
    data = response.json()
    assert "active_students" in data
    assert "trained_today" in data
    assert "inactive_students" in data
    # Valores inicialmente zero (trainer sem alunos)
    assert data["active_students"] == 0
    assert data["trained_today"] == 0


@pytest.mark.asyncio
async def test_dashboard_aluno_nao_acessa(
    client: AsyncClient,
    aluno_token,
):
    response = await client.get(
        "/dashboard/metrics",
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 403


@pytest.mark.asyncio
async def test_dashboard_sem_autenticacao(client: AsyncClient):
    response = await client.get("/dashboard/metrics")
    assert response.status_code == 401
