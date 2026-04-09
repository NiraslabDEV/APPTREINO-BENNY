from fastapi import APIRouter, HTTPException
from sqlalchemy import select, and_, func
from datetime import datetime, timedelta, timezone
from ..core.deps import TrainerUser, DB
from ..models.workout import TraineeRelation
from ..models.session import WorkoutSession
from ..models.user import User

router = APIRouter(prefix="/students", tags=["students"])


@router.get("")
async def list_students(trainer: TrainerUser, db: DB):
    """Lista alunos do trainer com ADR% calculado."""
    relations = await db.execute(
        select(TraineeRelation.trainee_id).where(
            TraineeRelation.trainer_id == trainer.id
        )
    )
    trainee_ids = [r[0] for r in relations.all()]
    if not trainee_ids:
        return []

    users = await db.execute(
        select(User).where(User.id.in_(trainee_ids))
    )

    result = []
    now = datetime.now(timezone.utc)
    month_start = now.replace(day=1, hour=0, minute=0, second=0)

    for user in users.scalars().all():
        # Calcula ADR% — sessões no mês / dias úteis esperados
        sessions_month = await db.execute(
            select(func.count(WorkoutSession.id)).where(
                and_(
                    WorkoutSession.trainee_id == user.id,
                    WorkoutSession.started_at >= month_start,
                    WorkoutSession.completed_at.is_not(None),
                )
            )
        )
        sessions_count = sessions_month.scalar() or 0
        days_in_month = (now - month_start).days + 1
        expected = max(days_in_month * 0.5, 1)  # assume 3-4x por semana
        adr = min((sessions_count / expected) * 100, 100)

        # Último treino
        last_session = await db.execute(
            select(WorkoutSession)
            .where(
                and_(
                    WorkoutSession.trainee_id == user.id,
                    WorkoutSession.completed_at.is_not(None),
                )
            )
            .order_by(WorkoutSession.completed_at.desc())
            .limit(1)
        )
        last = last_session.scalar_one_or_none()

        result.append({
            "id": user.id,
            "name": user.name,
            "photo_url": user.photo_url,
            "adr_percent": round(adr, 1),
            "last_workout": last.completed_at.strftime("%d/%m/%Y")
            if last else None,
        })

    return result


@router.get("/{student_id}/adherence")
async def get_adherence(
    student_id: str,
    trainer: TrainerUser,
    db: DB,
):
    # Verifica relação trainer ↔ aluno
    relation = await db.execute(
        select(TraineeRelation).where(
            and_(
                TraineeRelation.trainer_id == trainer.id,
                TraineeRelation.trainee_id == student_id,
            )
        )
    )
    if relation.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="Aluno não encontrado.")

    now = datetime.now(timezone.utc)
    month_start = now.replace(day=1, hour=0, minute=0, second=0)
    sessions = await db.execute(
        select(func.count(WorkoutSession.id)).where(
            and_(
                WorkoutSession.trainee_id == student_id,
                WorkoutSession.started_at >= month_start,
                WorkoutSession.completed_at.is_not(None),
            )
        )
    )
    count = sessions.scalar() or 0
    days = (now - month_start).days + 1
    expected = max(days * 0.5, 1)
    adr = min((count / expected) * 100, 100)

    return {"adr_percent": round(adr, 1), "sessions_this_month": count}


@router.get("/{student_id}/profile")
async def get_student_profile(
    student_id: str,
    trainer: TrainerUser,
    db: DB,
):
    # IDOR check — só alunos deste trainer
    relation = await db.execute(
        select(TraineeRelation).where(
            and_(
                TraineeRelation.trainer_id == trainer.id,
                TraineeRelation.trainee_id == student_id,
            )
        )
    )
    if relation.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="Aluno não encontrado.")

    user_result = await db.execute(select(User).where(User.id == student_id))
    user = user_result.scalar_one_or_none()
    if user is None:
        raise HTTPException(status_code=404, detail="Aluno não encontrado.")

    # Volume semanal
    week_ago = datetime.now(timezone.utc) - timedelta(days=7)
    volume_result = await db.execute(
        select(func.sum(WorkoutSession.total_volume_kg)).where(
            and_(
                WorkoutSession.trainee_id == student_id,
                WorkoutSession.started_at >= week_ago,
                WorkoutSession.completed_at.is_not(None),
            )
        )
    )
    weekly_volume = volume_result.scalar() or 0

    return {
        "id": user.id,
        "name": user.name,
        "photo_url": user.photo_url,
        "weekly_volume_kg": weekly_volume,
        "body_weight_kg": 0,  # TODO: tabela de body weight
        "adr_percent": 0,
        "recent_logs": [],
    }


@router.post("/nudge-all", status_code=200)
async def nudge_all_inactive(trainer: TrainerUser, db: DB):
    """Endpoint placeholder — em prod enviaria push notification."""
    # TODO: integrar com FCM/APNs
    return {"nudged": True}
