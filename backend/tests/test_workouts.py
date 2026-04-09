"""Testes do Workout Builder."""
import pytest
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.workout import Workout, TraineeRelation, WorkoutAssignment
from .conftest import auth_header


@pytest.mark.asyncio
async def test_create_workout_success(client: AsyncClient, trainer_token):
    payload = {
        "name": "Push Day A",
        "description": "Foco em peito e ombros",
        "level": "hypertrophy",
        "exercises": [],
    }
    response = await client.post(
        "/workouts",
        json=payload,
        headers=auth_header(trainer_token),
    )
    assert response.status_code == 201
    assert response.json()["name"] == "Push Day A"
    assert "id" in response.json()


@pytest.mark.asyncio
async def test_create_workout_without_auth(client: AsyncClient):
    response = await client.post(
        "/workouts",
        json={"name": "Test", "level": "hypertrophy"},
    )
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_reorder_exercises(
    client: AsyncClient,
    trainer_token,
    trainer_user,
    db_session: AsyncSession,
):
    # Cria treino via API
    workout = await client.post(
        "/workouts",
        json={"name": "Test Reorder", "level": "hypertrophy"},
        headers=auth_header(trainer_token),
    )
    workout_id = workout.json()["id"]

    response = await client.post(
        f"/workouts/{workout_id}/reorder",
        json={"order": ["ex3", "ex1", "ex2"]},
        headers=auth_header(trainer_token),
    )
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_assign_workout_to_student(
    client: AsyncClient,
    trainer_user,
    aluno_user,
    trainer_token,
    db_session: AsyncSession,
):
    # Cria relação trainer ↔ aluno
    db_session.add(TraineeRelation(
        trainer_id=trainer_user.id,
        trainee_id=aluno_user.id,
    ))
    await db_session.commit()

    workout_resp = await client.post(
        "/workouts",
        json={"name": "Test Assign", "level": "hypertrophy"},
        headers=auth_header(trainer_token),
    )
    workout_id = workout_resp.json()["id"]

    response = await client.post(
        f"/workouts/{workout_id}/assign",
        json={"student_ids": [aluno_user.id]},
        headers=auth_header(trainer_token),
    )
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_assign_workout_to_student_of_other_trainer(
    client: AsyncClient,
    trainer_token,
    other_aluno,
    db_session: AsyncSession,
):
    """Não pode atribuir para aluno de outro trainer — deve ignorar silenciosamente."""
    workout_resp = await client.post(
        "/workouts",
        json={"name": "Test IDOR Assign", "level": "hypertrophy"},
        headers=auth_header(trainer_token),
    )
    workout_id = workout_resp.json()["id"]

    # other_aluno não tem relação com este trainer
    response = await client.post(
        f"/workouts/{workout_id}/assign",
        json={"student_ids": [other_aluno.id]},
        headers=auth_header(trainer_token),
    )
    # Não retorna erro — apenas ignora
    assert response.status_code == 200

    # Verifica que o treino NÃO foi de fato atribuído
    from sqlalchemy import select, and_
    from app.models.workout import WorkoutAssignment
    assignment = await db_session.execute(
        select(WorkoutAssignment).where(
            and_(
                WorkoutAssignment.workout_id == workout_id,
                WorkoutAssignment.trainee_id == other_aluno.id,
            )
        )
    )
    assert assignment.scalar_one_or_none() is None


@pytest.mark.asyncio
async def test_workout_name_too_long(client: AsyncClient, trainer_token):
    response = await client.post(
        "/workouts",
        json={"name": "x" * 101, "level": "hypertrophy"},
        headers=auth_header(trainer_token),
    )
    assert response.status_code == 422
