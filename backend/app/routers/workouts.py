from fastapi import APIRouter, HTTPException, status
from sqlalchemy import select, and_
from pydantic import BaseModel, Field
from typing import Optional
from ..core.deps import TrainerUser, CurrentUser, DB
from ..models.workout import Workout, WorkoutExercise, WorkoutAssignment, TraineeRelation

router = APIRouter(prefix="/workouts", tags=["workouts"])


# --- Schemas ---
class ExerciseInput(BaseModel):
    exercise_id: str
    order: int = Field(ge=1)
    sets: int = Field(ge=1, le=20)
    reps: int = Field(ge=1, le=100)
    rest_seconds: int = Field(ge=0, le=600)
    rpe_target: int = Field(ge=1, le=10)
    notes: Optional[str] = Field(None, max_length=300)


class WorkoutCreateRequest(BaseModel):
    name: str = Field(min_length=1, max_length=100)
    description: Optional[str] = Field(None, max_length=500)
    level: str = Field(default="hypertrophy")
    exercises: list[ExerciseInput] = Field(default=[])


class AssignRequest(BaseModel):
    student_ids: list[str] = Field(min_length=1, max_length=50)


# --- Endpoints ---
@router.post("", status_code=status.HTTP_201_CREATED)
async def create_workout(
    body: WorkoutCreateRequest,
    trainer: TrainerUser,
    db: DB,
):
    workout = Workout(
        name=body.name,
        description=body.description,
        level=body.level,
        trainer_id=trainer.id,
    )
    db.add(workout)
    await db.flush()

    for ex in body.exercises:
        db.add(WorkoutExercise(
            workout_id=workout.id,
            exercise_id=ex.exercise_id,
            order=ex.order,
            sets=ex.sets,
            reps=ex.reps,
            rest_seconds=ex.rest_seconds,
            rpe_target=ex.rpe_target,
            notes=ex.notes,
        ))

    await db.flush()
    return {"id": workout.id, "name": workout.name}


@router.get("/{workout_id}")
async def get_workout(
    workout_id: str,
    current_user: CurrentUser,
    db: DB,
):
    result = await db.execute(
        select(Workout).where(Workout.id == workout_id)
    )
    workout = result.scalar_one_or_none()

    if workout is None:
        raise HTTPException(status_code=404, detail="Não encontrado.")

    # Autorização: trainer só acessa seus próprios treinos
    # Aluno só acessa treinos atribuídos a ele
    if current_user.role == "personal_trainer":
        if workout.trainer_id != current_user.id:
            raise HTTPException(status_code=404, detail="Não encontrado.")
    else:
        # Verifica se o treino foi atribuído ao aluno
        assignment = await db.execute(
            select(WorkoutAssignment).where(
                and_(
                    WorkoutAssignment.workout_id == workout_id,
                    WorkoutAssignment.trainee_id == current_user.id,
                )
            )
        )
        if assignment.scalar_one_or_none() is None:
            raise HTTPException(status_code=404, detail="Não encontrado.")

    # Carrega exercícios
    exercises_result = await db.execute(
        select(WorkoutExercise)
        .where(WorkoutExercise.workout_id == workout_id)
        .order_by(WorkoutExercise.order)
    )
    exercises = exercises_result.scalars().all()

    return {
        "id": workout.id,
        "name": workout.name,
        "description": workout.description,
        "level": workout.level,
        "exercises": [
            {
                "exercise_id": ex.exercise_id,
                "exercise_name": ex.exercise_id,  # TODO: join com exercises
                "order": ex.order,
                "sets": ex.sets,
                "reps": ex.reps,
                "rest_seconds": ex.rest_seconds,
                "rpe_target": ex.rpe_target,
                "notes": ex.notes,
            }
            for ex in exercises
        ],
    }


@router.put("/{workout_id}", status_code=200)
async def update_workout(
    workout_id: str,
    body: WorkoutCreateRequest,
    trainer: TrainerUser,
    db: DB,
):
    result = await db.execute(
        select(Workout).where(
            and_(Workout.id == workout_id, Workout.trainer_id == trainer.id)
        )
    )
    workout = result.scalar_one_or_none()
    if workout is None:
        raise HTTPException(status_code=404, detail="Não encontrado.")

    workout.name = body.name
    workout.description = body.description
    workout.level = body.level

    # Remove exercícios antigos e recria (simples e seguro)
    old_exercises = await db.execute(
        select(WorkoutExercise).where(
            WorkoutExercise.workout_id == workout_id
        )
    )
    for ex in old_exercises.scalars().all():
        await db.delete(ex)

    for ex in body.exercises:
        db.add(WorkoutExercise(
            workout_id=workout.id,
            exercise_id=ex.exercise_id,
            order=ex.order,
            sets=ex.sets,
            reps=ex.reps,
            rest_seconds=ex.rest_seconds,
            rpe_target=ex.rpe_target,
            notes=ex.notes,
        ))

    return {"id": workout.id}


@router.post("/{workout_id}/reorder", status_code=200)
async def reorder_exercises(
    workout_id: str,
    body: dict,
    trainer: TrainerUser,
    db: DB,
):
    """Recebe {'order': [exercise_id1, exercise_id2, ...]}"""
    result = await db.execute(
        select(Workout).where(
            and_(Workout.id == workout_id, Workout.trainer_id == trainer.id)
        )
    )
    if result.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="Não encontrado.")

    order_list = body.get("order", [])
    for i, exercise_id in enumerate(order_list):
        await db.execute(
            WorkoutExercise.__table__.update()
            .where(
                and_(
                    WorkoutExercise.workout_id == workout_id,
                    WorkoutExercise.exercise_id == str(exercise_id),
                )
            )
            .values(order=i + 1)
        )
    return {"ok": True}


@router.post("/{workout_id}/assign", status_code=200)
async def assign_workout(
    workout_id: str,
    body: AssignRequest,
    trainer: TrainerUser,
    db: DB,
):
    # Verifica dono do treino
    result = await db.execute(
        select(Workout).where(
            and_(Workout.id == workout_id, Workout.trainer_id == trainer.id)
        )
    )
    if result.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="Não encontrado.")

    for student_id in body.student_ids:
        # Verifica relação trainer ↔ aluno antes de atribuir (IDOR prevention)
        relation = await db.execute(
            select(TraineeRelation).where(
                and_(
                    TraineeRelation.trainer_id == trainer.id,
                    TraineeRelation.trainee_id == student_id,
                )
            )
        )
        if relation.scalar_one_or_none() is None:
            # Ignora silenciosamente IDs de alunos que não pertencem a este trainer
            continue

        # Upsert da atribuição
        existing = await db.execute(
            select(WorkoutAssignment).where(
                and_(
                    WorkoutAssignment.workout_id == workout_id,
                    WorkoutAssignment.trainee_id == student_id,
                )
            )
        )
        if existing.scalar_one_or_none() is None:
            db.add(WorkoutAssignment(
                workout_id=workout_id,
                trainee_id=student_id,
            ))

    return {"assigned": True}
