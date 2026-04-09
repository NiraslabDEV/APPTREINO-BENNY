import uuid
from datetime import datetime, timezone
from sqlalchemy import String, Text, Boolean, Integer, Float, ForeignKey, DateTime, Enum as SAEnum
from sqlalchemy.orm import Mapped, mapped_column, relationship
from ..core.database import Base


class Workout(Base):
    __tablename__ = "workouts"

    id: Mapped[str] = mapped_column(
        String(36), primary_key=True, default=lambda: str(uuid.uuid4())
    )
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    description: Mapped[str | None] = mapped_column(Text, nullable=True)
    level: Mapped[str] = mapped_column(
        SAEnum("hypertrophy", "strength", "endurance", "mobility",
               name="workout_level"),
        default="hypertrophy",
    )
    trainer_id: Mapped[str] = mapped_column(
        String(36), ForeignKey("users.id"), nullable=False, index=True
    )
    is_template: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=lambda: datetime.now(timezone.utc)
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc),
    )

    exercises: Mapped[list["WorkoutExercise"]] = relationship(
        back_populates="workout",
        cascade="all, delete-orphan",
        order_by="WorkoutExercise.order",
    )


class Exercise(Base):
    __tablename__ = "exercises"

    id: Mapped[str] = mapped_column(
        String(36), primary_key=True, default=lambda: str(uuid.uuid4())
    )
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    muscle_group: Mapped[str] = mapped_column(String(50), nullable=False)
    equipment: Mapped[str | None] = mapped_column(String(50), nullable=True)
    gif_url: Mapped[str | None] = mapped_column(String(512), nullable=True)
    is_custom: Mapped[bool] = mapped_column(Boolean, default=False)
    trainer_id: Mapped[str | None] = mapped_column(
        String(36), ForeignKey("users.id"), nullable=True
    )


class WorkoutExercise(Base):
    __tablename__ = "workout_exercises"

    id: Mapped[str] = mapped_column(
        String(36), primary_key=True, default=lambda: str(uuid.uuid4())
    )
    workout_id: Mapped[str] = mapped_column(
        String(36), ForeignKey("workouts.id", ondelete="CASCADE"),
        nullable=False, index=True
    )
    exercise_id: Mapped[str] = mapped_column(
        String(36), ForeignKey("exercises.id"), nullable=False
    )
    order: Mapped[int] = mapped_column(Integer, nullable=False)
    sets: Mapped[int] = mapped_column(Integer, default=3)
    reps: Mapped[int] = mapped_column(Integer, default=10)
    rest_seconds: Mapped[int] = mapped_column(Integer, default=60)
    rpe_target: Mapped[int] = mapped_column(Integer, default=8)
    notes: Mapped[str | None] = mapped_column(String(300), nullable=True)

    workout: Mapped["Workout"] = relationship(back_populates="exercises")
    exercise: Mapped["Exercise"] = relationship()


class TraineeRelation(Base):
    """Personal ↔ Aluno — um personal pode ter vários alunos."""
    __tablename__ = "trainee_relations"

    trainer_id: Mapped[str] = mapped_column(
        String(36), ForeignKey("users.id"), primary_key=True
    )
    trainee_id: Mapped[str] = mapped_column(
        String(36), ForeignKey("users.id"), primary_key=True
    )


class WorkoutAssignment(Base):
    """Atribuição de treino a um aluno."""
    __tablename__ = "workout_assignments"

    workout_id: Mapped[str] = mapped_column(
        String(36), ForeignKey("workouts.id"), primary_key=True
    )
    trainee_id: Mapped[str] = mapped_column(
        String(36), ForeignKey("users.id"), primary_key=True
    )
