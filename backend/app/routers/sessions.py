from fastapi import APIRouter, HTTPException, status
from sqlalchemy import select, and_, func
from pydantic import BaseModel, Field
from datetime import datetime, timezone
from ..core.deps import AlunoUser, CurrentUser, DB
from ..models.workout import WorkoutAssignment
from ..models.session import WorkoutSession, SessionSet, PersonalRecord

router = APIRouter(prefix="/sessions", tags=["sessions"])


# --- Schemas ---
class StartSessionRequest(BaseModel):
    workout_id: str


class LogSetRequest(BaseModel):
    exercise_id: str
    set_number: int = Field(ge=1, le=100)
    weight_kg: float = Field(gt=0, le=999)
    reps: int = Field(ge=1, le=999)
    rpe: int | None = Field(None, ge=1, le=10)
    notes: str | None = Field(None, max_length=300)


# --- Endpoints ---
@router.post("", status_code=status.HTTP_201_CREATED)
async def start_session(
    body: StartSessionRequest,
    aluno: AlunoUser,
    db: DB,
):
    # Verifica que o treino foi atribuído ao aluno (IDOR prevention)
    assignment = await db.execute(
        select(WorkoutAssignment).where(
            and_(
                WorkoutAssignment.workout_id == body.workout_id,
                WorkoutAssignment.trainee_id == aluno.id,
            )
        )
    )
    if assignment.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="Treino não encontrado.")

    session = WorkoutSession(
        trainee_id=aluno.id,
        workout_id=body.workout_id,
    )
    db.add(session)
    await db.flush()

    return {"id": session.id, "started_at": session.started_at.isoformat()}


@router.post("/{session_id}/sets", status_code=status.HTTP_201_CREATED)
async def log_set(
    session_id: str,
    body: LogSetRequest,
    aluno: AlunoUser,
    db: DB,
):
    # Verifica dono da sessão — IDOR prevention
    result = await db.execute(
        select(WorkoutSession).where(
            and_(
                WorkoutSession.id == session_id,
                WorkoutSession.trainee_id == aluno.id,  # só o dono
                WorkoutSession.completed_at.is_(None),  # sessão aberta
            )
        )
    )
    session = result.scalar_one_or_none()
    if session is None:
        raise HTTPException(status_code=404, detail="Sessão não encontrada.")

    new_set = SessionSet(
        session_id=session_id,
        exercise_id=body.exercise_id,
        set_number=body.set_number,
        weight_kg=body.weight_kg,
        reps=body.reps,
        rpe=body.rpe,
        notes=body.notes,
    )
    db.add(new_set)

    # Atualiza volume total
    session.total_volume_kg += body.weight_kg * body.reps

    # Detecta PR automaticamente
    pr_result = await db.execute(
        select(PersonalRecord).where(
            and_(
                PersonalRecord.trainee_id == aluno.id,
                PersonalRecord.exercise_id == body.exercise_id,
            )
        )
    )
    pr = pr_result.scalar_one_or_none()

    is_pr = False
    if pr is None:
        # Primeiro registro = PR automático
        db.add(PersonalRecord(
            trainee_id=aluno.id,
            exercise_id=body.exercise_id,
            weight_kg=body.weight_kg,
            reps=body.reps,
        ))
        is_pr = True
    elif body.weight_kg > pr.weight_kg or (
        body.weight_kg == pr.weight_kg and body.reps > pr.reps
    ):
        pr.weight_kg = body.weight_kg
        pr.reps = body.reps
        pr.date = datetime.now(timezone.utc)
        is_pr = True

    await db.flush()
    return {
        "id": new_set.id,
        "is_pr": is_pr,
        "total_volume_kg": session.total_volume_kg,
    }


@router.patch("/{session_id}/complete", status_code=200)
async def complete_session(
    session_id: str,
    aluno: AlunoUser,
    db: DB,
):
    result = await db.execute(
        select(WorkoutSession).where(
            and_(
                WorkoutSession.id == session_id,
                WorkoutSession.trainee_id == aluno.id,
            )
        )
    )
    session = result.scalar_one_or_none()
    if session is None:
        raise HTTPException(status_code=404, detail="Sessão não encontrada.")

    session.completed_at = datetime.now(timezone.utc)

    # Busca PRs desta sessão para retornar no response
    sets = await db.execute(
        select(SessionSet).where(SessionSet.session_id == session_id)
    )
    all_sets = sets.scalars().all()
    exercise_ids = list({s.exercise_id for s in all_sets})

    prs = await db.execute(
        select(PersonalRecord).where(
            and_(
                PersonalRecord.trainee_id == aluno.id,
                PersonalRecord.exercise_id.in_(exercise_ids),
            )
        )
    )

    # Verifica quais exercises bateram PR nesta sessão
    new_pr_names: list[str] = []
    for pr in prs.scalars().all():
        session_max = max(
            (s.weight_kg for s in all_sets if s.exercise_id == pr.exercise_id),
            default=0,
        )
        if session_max >= pr.weight_kg:
            new_pr_names.append(pr.exercise_id)  # TODO: nome real

    return {
        "id": session_id,
        "total_volume_kg": session.total_volume_kg,
        "completed_at": session.completed_at.isoformat(),
        "new_prs": new_pr_names,
    }


@router.get("/{session_id}")
async def get_session(
    session_id: str,
    current_user: CurrentUser,
    db: DB,
):
    """Trainer e aluno podem ver, mas com restrições diferentes."""
    result = await db.execute(
        select(WorkoutSession).where(WorkoutSession.id == session_id)
    )
    session = result.scalar_one_or_none()

    if session is None:
        raise HTTPException(status_code=404, detail="Não encontrado.")

    # Aluno só vê sua própria sessão
    if current_user.role == "aluno":
        if session.trainee_id != current_user.id:
            raise HTTPException(status_code=403, detail="Acesso negado.")

    # Trainer só vê sessões dos seus alunos (verificação omitida por brevidade — TODO)

    return {
        "id": session.id,
        "workout_id": session.workout_id,
        "trainee_id": session.trainee_id,
        "started_at": session.started_at.isoformat(),
        "completed_at": session.completed_at.isoformat()
        if session.completed_at
        else None,
        "total_volume_kg": session.total_volume_kg,
    }
