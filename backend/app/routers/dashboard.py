from fastapi import APIRouter
from sqlalchemy import select, func, and_
from datetime import datetime, timedelta, timezone
from ..core.deps import TrainerUser, DB
from ..models.workout import TraineeRelation
from ..models.session import WorkoutSession
from ..models.user import User

router = APIRouter(prefix="/dashboard", tags=["dashboard"])


@router.get("/metrics")
async def get_metrics(trainer: TrainerUser, db: DB):
    """
    Métricas do dashboard do personal.
    Acesso restrito a personal_trainer — verificado via deps.
    """
    now = datetime.now(timezone.utc)
    today_start = now.replace(hour=0, minute=0, second=0, microsecond=0)
    inactive_threshold = now - timedelta(days=3)

    # IDs dos alunos deste trainer
    relations = await db.execute(
        select(TraineeRelation.trainee_id).where(
            TraineeRelation.trainer_id == trainer.id
        )
    )
    trainee_ids = [r[0] for r in relations.all()]

    if not trainee_ids:
        return {
            "active_students": 0,
            "trained_today": 0,
            "inactive_students": 0,
        }

    # Alunos ativos
    active_count = len(trainee_ids)

    # Treinaram hoje
    trained_today = await db.execute(
        select(func.count(func.distinct(WorkoutSession.trainee_id))).where(
            and_(
                WorkoutSession.trainee_id.in_(trainee_ids),
                WorkoutSession.started_at >= today_start,
                WorkoutSession.completed_at.is_not(None),
            )
        )
    )

    # Inativos há mais de 3 dias — SEM treino completo nos últimos 3 dias
    active_recent = await db.execute(
        select(func.distinct(WorkoutSession.trainee_id)).where(
            and_(
                WorkoutSession.trainee_id.in_(trainee_ids),
                WorkoutSession.started_at >= inactive_threshold,
            )
        )
    )
    recent_ids = {r[0] for r in active_recent.all()}
    inactive_count = sum(1 for tid in trainee_ids if tid not in recent_ids)

    return {
        "active_students": active_count,
        "trained_today": trained_today.scalar(),
        "inactive_students": inactive_count,
    }


@router.get("/activity")
async def get_activity_feed(trainer: TrainerUser, db: DB):
    """Feed das últimas sessões concluídas pelos alunos."""
    relations = await db.execute(
        select(TraineeRelation.trainee_id).where(
            TraineeRelation.trainer_id == trainer.id
        )
    )
    trainee_ids = [r[0] for r in relations.all()]
    if not trainee_ids:
        return []

    sessions = await db.execute(
        select(WorkoutSession, User)
        .join(User, User.id == WorkoutSession.trainee_id)
        .where(
            and_(
                WorkoutSession.trainee_id.in_(trainee_ids),
                WorkoutSession.completed_at.is_not(None),
            )
        )
        .order_by(WorkoutSession.completed_at.desc())
        .limit(20)
    )

    result = []
    for session, user in sessions.all():
        result.append({
            "student_name": user.name,
            "student_photo_url": user.photo_url,
            "workout_name": session.workout_id,  # TODO: join com workout
            "total_volume_kg": session.total_volume_kg,
            "completed_at": session.completed_at.isoformat(),
        })
    return result
