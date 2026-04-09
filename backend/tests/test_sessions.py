"""Testes de sessões de treino."""
import pytest
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.workout import Workout, WorkoutAssignment
from .conftest import auth_header


@pytest.fixture
async def assigned_workout(trainer_user, aluno_user, db_session: AsyncSession):
    workout = Workout(name="Session Workout", trainer_id=trainer_user.id)
    db_session.add(workout)
    await db_session.flush()
    db_session.add(WorkoutAssignment(
        workout_id=workout.id,
        trainee_id=aluno_user.id,
    ))
    await db_session.commit()
    return workout


@pytest.mark.asyncio
async def test_start_session_success(
    client: AsyncClient,
    assigned_workout,
    aluno_token,
):
    response = await client.post(
        "/sessions",
        json={"workout_id": assigned_workout.id},
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 201
    assert "id" in response.json()


@pytest.mark.asyncio
async def test_start_session_workout_not_assigned(
    client: AsyncClient,
    aluno_token,
    trainer_user,
    db_session: AsyncSession,
):
    """Aluno não pode iniciar treino que não foi atribuído a ele."""
    workout = Workout(name="Unassigned", trainer_id=trainer_user.id)
    db_session.add(workout)
    await db_session.commit()

    response = await client.post(
        "/sessions",
        json={"workout_id": workout.id},
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 404


@pytest.mark.asyncio
async def test_log_set_success(
    client: AsyncClient,
    assigned_workout,
    aluno_user,
    aluno_token,
    db_session: AsyncSession,
):
    # Inicia sessão
    session_resp = await client.post(
        "/sessions",
        json={"workout_id": assigned_workout.id},
        headers=auth_header(aluno_token),
    )
    session_id = session_resp.json()["id"]

    # Registra série — precisa de exercise existente
    from app.models.workout import Exercise
    ex = Exercise(name="Supino", muscle_group="Peito")
    db_session.add(ex)
    await db_session.commit()

    set_payload = {
        "exercise_id": ex.id,
        "set_number": 1,
        "weight_kg": 85.0,
        "reps": 10,
        "rpe": 8,
    }
    response = await client.post(
        f"/sessions/{session_id}/sets",
        json=set_payload,
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 201
    assert "total_volume_kg" in response.json()


@pytest.mark.asyncio
async def test_log_set_on_another_users_session(
    client: AsyncClient,
    assigned_workout,
    aluno_user,
    aluno_token,
    other_aluno_token,
    db_session: AsyncSession,
):
    """Aluno B não pode logar série na sessão do aluno A."""
    session_resp = await client.post(
        "/sessions",
        json={"workout_id": assigned_workout.id},
        headers=auth_header(aluno_token),
    )
    session_id = session_resp.json()["id"]

    from app.models.workout import Exercise
    ex = Exercise(name="Agachamento", muscle_group="Pernas")
    db_session.add(ex)
    await db_session.commit()

    response = await client.post(
        f"/sessions/{session_id}/sets",
        json={
            "exercise_id": ex.id,
            "set_number": 1,
            "weight_kg": 100.0,
            "reps": 5,
        },
        headers=auth_header(other_aluno_token),
    )
    assert response.status_code in (403, 404)


@pytest.mark.asyncio
async def test_log_set_weight_too_large(
    client: AsyncClient,
    assigned_workout,
    aluno_token,
    db_session: AsyncSession,
):
    session_resp = await client.post(
        "/sessions",
        json={"workout_id": assigned_workout.id},
        headers=auth_header(aluno_token),
    )
    session_id = session_resp.json()["id"]

    from app.models.workout import Exercise
    ex = Exercise(name="Terra", muscle_group="Costas")
    db_session.add(ex)
    await db_session.commit()

    response = await client.post(
        f"/sessions/{session_id}/sets",
        json={
            "exercise_id": ex.id,
            "set_number": 1,
            "weight_kg": 99999,  # valor absurdo
            "reps": 10,
        },
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_pr_detection(
    client: AsyncClient,
    assigned_workout,
    aluno_token,
    db_session: AsyncSession,
):
    """Deve detectar e retornar novos PRs."""
    session_resp = await client.post(
        "/sessions",
        json={"workout_id": assigned_workout.id},
        headers=auth_header(aluno_token),
    )
    session_id = session_resp.json()["id"]

    from app.models.workout import Exercise
    ex = Exercise(name="Rosca", muscle_group="Bíceps")
    db_session.add(ex)
    await db_session.commit()

    response = await client.post(
        f"/sessions/{session_id}/sets",
        json={
            "exercise_id": ex.id,
            "set_number": 1,
            "weight_kg": 50.0,
            "reps": 10,
            "rpe": 9,
        },
        headers=auth_header(aluno_token),
    )
    assert response.status_code == 201
    # Primeiro set de um exercício = PR automático
    assert response.json()["is_pr"] is True
