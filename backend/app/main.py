from fastapi import FastAPI, Request, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded
import structlog

from .core.config import settings
from .routers import auth, dashboard, workouts, sessions, students, exercises

log = structlog.get_logger()

# Rate limiter global
limiter = Limiter(key_func=get_remote_address)

app = FastAPI(
    title="Kinetic API",
    version="1.0.0",
    # Desabilita docs em produção
    docs_url=None if settings.is_production else "/docs",
    redoc_url=None if settings.is_production else "/redoc",
)

# Estado do limiter
app.state.limiter = limiter
app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

# CORS — restrito às origens permitidas
origins = [o.strip() for o in settings.ALLOWED_ORIGINS.split(",")]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE"],
    allow_headers=["Authorization", "Content-Type"],
)


# Middleware de logging estruturado
@app.middleware("http")
async def log_requests(request: Request, call_next):
    response = await call_next(request)
    log.info(
        "request",
        method=request.method,
        path=request.url.path,
        status=response.status_code,
        ip=request.client.host if request.client else "unknown",
    )
    return response


# Handler global para 422 — não revelar detalhes de validação
@app.exception_handler(422)
async def validation_exception_handler(request: Request, exc):
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content={"detail": "Dados inválidos. Verifique os campos."},
    )


# Routers
app.include_router(auth.router)
app.include_router(dashboard.router)
app.include_router(workouts.router)
app.include_router(sessions.router)
app.include_router(students.router)
app.include_router(exercises.router)



# Rota de aluno — me
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_
from .core.deps import get_current_user, DB, AlunoUser
from .models.user import User
from .models.workout import WorkoutAssignment, Workout
from .models.session import PersonalRecord
from .models.workout import Exercise

me_router = APIRouter(prefix="/me", tags=["me"])


@me_router.get("")
async def get_me(current_user=Depends(get_current_user)):
    return {
        "id": current_user.id,
        "email": current_user.email,
        "name": current_user.name,
        "role": current_user.role,
        "photo_url": current_user.photo_url,
    }


@me_router.get("/workouts/today")
async def get_today_workout(aluno: AlunoUser, db: DB):
    """Retorna o treino do dia do aluno."""
    # Pega a última atribuição
    result = await db.execute(
        select(WorkoutAssignment, Workout)
        .join(Workout, Workout.id == WorkoutAssignment.workout_id)
        .where(WorkoutAssignment.trainee_id == aluno.id)
        .order_by(WorkoutAssignment.workout_id.desc())
        .limit(1)
    )
    row = result.first()
    if row is None:
        return None

    _, workout = row
    return {
        "id": workout.id,
        "name": workout.name,
        "estimated_minutes": 45,
        "exercise_count": 0,  # TODO: count
    }


@me_router.get("/personal-records")
async def get_personal_records(
    aluno: AlunoUser,
    db: DB,
    limit: int = 3,
):
    result = await db.execute(
        select(PersonalRecord, Exercise)
        .join(Exercise, Exercise.id == PersonalRecord.exercise_id)
        .where(PersonalRecord.trainee_id == aluno.id)
        .order_by(PersonalRecord.date.desc())
        .limit(limit)
    )

    return [
        {
            "exercise_name": exercise.name,
            "weight_kg": pr.weight_kg,
            "reps": pr.reps,
        }
        for pr, exercise in result.all()
    ]


app.include_router(me_router)


@app.get("/health")
async def health():
    return {"status": "ok"}
