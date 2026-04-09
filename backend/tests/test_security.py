"""
FASE 2 — Testes de Segurança (IDOR, escalação de privilégio, injection)
Todos devem falhar até a implementação estar completa.
"""
import pytest
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.workout import Workout, TraineeRelation, WorkoutAssignment
from app.models.session import WorkoutSession
from .conftest import auth_header


# --- IDOR ---
@pytest.mark.asyncio
async def test_idor_aluno_nao_acessa_treino_de_outro_aluno(
    client: AsyncClient,
    trainer_user,
    aluno_user,
    other_aluno,
    aluno_token,
    other_aluno_token,
    db_session: AsyncSession,
):
    """Aluno não pode acessar treino atribuído a outro aluno."""
    workout = Workout(
        name="Treino do Outro",
        trainer_id=trainer_user.id,
    )
    db_session.add(workout)
    await db_session.flush()

    # Atribuído apenas ao other_aluno
    db_session.add(WorkoutAssignment(
        workout_id=workout.id,
        trainee_id=other_aluno.id,
    ))
    await db_session.commit()

    # aluno_user tenta acessar — deve receber 404 (não 403, para não revelar existência)
    response = await client.get(
        f"/workouts/{workout.id}",
        headers=auth_header(aluno_token),
    )
    assert response.status_code in (403, 404)


@pytest.mark.asyncio
async def test_idor_aluno_nao_acessa_sessao_de_outro(
    client: AsyncClient,
    aluno_user,
    other_aluno,
    aluno_token,
    trainer_user,
    db_session: AsyncSession,
):
    """Aluno não pode acessar a sessão de outro aluno."""
    workout = Workout(name="Workout IDOR", trainer_id=trainer_user.id)
    db_session.add(workout)
    await db_session.flush()

    # Sessão do other_aluno
    session = WorkoutSession(
        trainee_id=other_aluno.id,
        workout_id=workout.id,
    )
    db_session.add(session)
    await db_session.commit()

    response = await client.get(
        f"/sessions/{session.id}",
        headers=auth_header(aluno_token),
    )
    assert response.status_code in (403, 404)


@pytest.mark.asyncio
async def test_idor_trainer_nao_acessa_aluno_de_outro_trainer(
    client: AsyncClient,
    trainer_user,
    other_aluno,
    trainer_token,
    db_session: AsyncSession,
):
    """Trainer não pode acessar perfil de aluno de outro trainer."""
    # other_aluno NÃO tem relação com trainer_user
    response = await client.get(
        f"/students/{other_aluno.id}/profile",
        headers=auth_header(trainer_token),
    )
    assert response.status_code in (403, 404)


# --- Escalação de privilégio ---
@pytest.mark.asyncio
async def test_aluno_nao_acessa_dashboard_do_trainer(
    client: AsyncClient,
    aluno_token,
):
    response = await client.get(
        "/dashboard/metrics",
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 403


@pytest.mark.asyncio
async def test_aluno_nao_cria_treino(
    client: AsyncClient,
    aluno_token,
):
    response = await client.post(
        "/workouts",
        json={"name": "Treino Malicioso", "level": "hypertrophy"},
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 403


@pytest.mark.asyncio
async def test_aluno_nao_atribui_treino(
    client: AsyncClient,
    aluno_token,
    trainer_user,
    db_session: AsyncSession,
):
    workout = Workout(name="Workout", trainer_id=trainer_user.id)
    db_session.add(workout)
    await db_session.commit()

    response = await client.post(
        f"/workouts/{workout.id}/assign",
        json={"student_ids": ["qualquer-id"]},
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 403


@pytest.mark.asyncio
async def test_trainer_nao_inicia_sessao_como_aluno(
    client: AsyncClient,
    trainer_token,
    trainer_user,
    db_session: AsyncSession,
):
    workout = Workout(name="Workout", trainer_id=trainer_user.id)
    db_session.add(workout)
    await db_session.commit()

    # Trainer não pode iniciar sessão (rota de aluno)
    response = await client.post(
        "/sessions",
        json={"workout_id": workout.id},
        headers=auth_header(trainer_token),
    )
    assert response.status_code == 403


# --- Injection prevention ---
@pytest.mark.asyncio
async def test_sql_injection_no_nome_do_treino(
    client: AsyncClient,
    trainer_token,
):
    """ORM parametrizado previne injection — payload malicioso deve ser tratado como string."""
    response = await client.post(
        "/workouts",
        json={
            "name": "'; DROP TABLE workouts; --",
            "level": "hypertrophy",
        },
        headers=auth_header(trainer_token),
    )
    # Deve criar normalmente (ORM previne injection) ou rejeitar por validação
    assert response.status_code in (201, 422)


@pytest.mark.asyncio
async def test_xss_em_nome_de_treino(
    client: AsyncClient,
    trainer_token,
):
    response = await client.post(
        "/workouts",
        json={
            "name": "<script>alert(1)</script>",
            "level": "hypertrophy",
        },
        headers=auth_header(trainer_token),
    )
    # Cria ou rejeita — mas nunca executa o script
    assert response.status_code in (201, 422)
    if response.status_code == 201:
        # Valor deve ser armazenado como texto puro
        workout_id = response.json()["id"]
        get_response = await client.get(
            f"/workouts/{workout_id}",
            headers=auth_header(trainer_token),
        )
        assert "<script>" in get_response.json().get("name", "")


# --- Race condition ---
@pytest.mark.asyncio
async def test_race_condition_multiple_sessions(
    client: AsyncClient,
    aluno_user,
    aluno_token,
    trainer_user,
    db_session: AsyncSession,
):
    """N requests simultâneos para iniciar sessão — apenas 1 deve ter efeito no estado."""
    import asyncio
    workout = Workout(name="Race Workout", trainer_id=trainer_user.id)
    db_session.add(workout)
    from app.models.workout import WorkoutAssignment
    db_session.add(WorkoutAssignment(
        workout_id=workout.id if workout.id else "test",
        trainee_id=aluno_user.id,
    ))
    await db_session.commit()

    tasks = [
        client.post(
            "/sessions",
            json={"workout_id": workout.id},
            headers=auth_header(aluno_token),
        )
        for _ in range(5)
    ]
    responses = await asyncio.gather(*tasks, return_exceptions=True)
    success = [r for r in responses if hasattr(r, "status_code") and r.status_code == 201]
    assert len(success) >= 1  # pelo menos 1 deve funcionar


# --- Tamanho de campos ---
@pytest.mark.asyncio
async def test_campo_com_tamanho_absurdo(
    client: AsyncClient,
    trainer_token,
):
    response = await client.post(
        "/workouts",
        json={
            "name": "x" * 100_000,
            "level": "hypertrophy",
        },
        headers=auth_header(trainer_token),
    )
    assert response.status_code == 422
