"""initial schema

Revision ID: 001
Revises:
Create Date: 2026-04-09
"""
from alembic import op
import sqlalchemy as sa

revision = "001"
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # users
    op.create_table(
        "users",
        sa.Column("id", sa.String(36), primary_key=True),
        sa.Column("email", sa.String(254), nullable=False, unique=True),
        sa.Column("google_id", sa.String(128), nullable=True, unique=True),
        sa.Column("hashed_password", sa.String(256), nullable=True),
        sa.Column("role", sa.Enum("personal_trainer", "aluno", name="user_role"), nullable=False),
        sa.Column("name", sa.String(100), nullable=False),
        sa.Column("photo_url", sa.String(512), nullable=True),
        sa.Column("is_active", sa.Boolean(), default=True, nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index("ix_users_email", "users", ["email"])

    # exercises
    op.create_table(
        "exercises",
        sa.Column("id", sa.String(36), primary_key=True),
        sa.Column("name", sa.String(100), nullable=False),
        sa.Column("muscle_group", sa.String(50), nullable=False),
        sa.Column("equipment", sa.String(50), nullable=True),
        sa.Column("gif_url", sa.String(512), nullable=True),
        sa.Column("is_custom", sa.Boolean(), default=False),
        sa.Column("trainer_id", sa.String(36), sa.ForeignKey("users.id"), nullable=True),
    )

    # workouts
    op.create_table(
        "workouts",
        sa.Column("id", sa.String(36), primary_key=True),
        sa.Column("name", sa.String(100), nullable=False),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("level", sa.Enum("hypertrophy", "strength", "endurance", "mobility", name="workout_level"), default="hypertrophy"),
        sa.Column("trainer_id", sa.String(36), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("is_template", sa.Boolean(), default=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index("ix_workouts_trainer_id", "workouts", ["trainer_id"])

    # workout_exercises
    op.create_table(
        "workout_exercises",
        sa.Column("id", sa.String(36), primary_key=True),
        sa.Column("workout_id", sa.String(36), sa.ForeignKey("workouts.id", ondelete="CASCADE"), nullable=False),
        sa.Column("exercise_id", sa.String(36), sa.ForeignKey("exercises.id"), nullable=False),
        sa.Column("order", sa.Integer(), nullable=False),
        sa.Column("sets", sa.Integer(), default=3),
        sa.Column("reps", sa.Integer(), default=10),
        sa.Column("rest_seconds", sa.Integer(), default=60),
        sa.Column("rpe_target", sa.Integer(), default=8),
        sa.Column("notes", sa.String(300), nullable=True),
    )
    op.create_index("ix_workout_exercises_workout_id", "workout_exercises", ["workout_id"])

    # trainee_relations
    op.create_table(
        "trainee_relations",
        sa.Column("trainer_id", sa.String(36), sa.ForeignKey("users.id"), primary_key=True),
        sa.Column("trainee_id", sa.String(36), sa.ForeignKey("users.id"), primary_key=True),
    )

    # workout_assignments
    op.create_table(
        "workout_assignments",
        sa.Column("workout_id", sa.String(36), sa.ForeignKey("workouts.id"), primary_key=True),
        sa.Column("trainee_id", sa.String(36), sa.ForeignKey("users.id"), primary_key=True),
    )

    # workout_sessions
    op.create_table(
        "workout_sessions",
        sa.Column("id", sa.String(36), primary_key=True),
        sa.Column("trainee_id", sa.String(36), sa.ForeignKey("users.id"), nullable=False),
        sa.Column("workout_id", sa.String(36), sa.ForeignKey("workouts.id"), nullable=False),
        sa.Column("started_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("completed_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("total_volume_kg", sa.Float(), default=0.0),
    )
    op.create_index("ix_workout_sessions_trainee_id", "workout_sessions", ["trainee_id"])

    # session_sets
    op.create_table(
        "session_sets",
        sa.Column("id", sa.String(36), primary_key=True),
        sa.Column("session_id", sa.String(36), sa.ForeignKey("workout_sessions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("exercise_id", sa.String(36), sa.ForeignKey("exercises.id"), nullable=False),
        sa.Column("set_number", sa.Integer(), nullable=False),
        sa.Column("weight_kg", sa.Float(), nullable=False),
        sa.Column("reps", sa.Integer(), nullable=False),
        sa.Column("rpe", sa.Integer(), nullable=True),
        sa.Column("notes", sa.String(300), nullable=True),
        sa.Column("logged_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index("ix_session_sets_session_id", "session_sets", ["session_id"])

    # personal_records
    op.create_table(
        "personal_records",
        sa.Column("trainee_id", sa.String(36), sa.ForeignKey("users.id"), primary_key=True),
        sa.Column("exercise_id", sa.String(36), sa.ForeignKey("exercises.id"), primary_key=True),
        sa.Column("weight_kg", sa.Float(), nullable=False),
        sa.Column("reps", sa.Integer(), nullable=False),
        sa.Column("date", sa.DateTime(timezone=True), nullable=False),
    )

    # RLS — Row Level Security (PostgreSQL)
    op.execute("ALTER TABLE workout_sessions ENABLE ROW LEVEL SECURITY")
    op.execute("ALTER TABLE session_sets ENABLE ROW LEVEL SECURITY")
    op.execute("ALTER TABLE personal_records ENABLE ROW LEVEL SECURITY")


def downgrade():
    op.execute("ALTER TABLE personal_records DISABLE ROW LEVEL SECURITY")
    op.execute("ALTER TABLE session_sets DISABLE ROW LEVEL SECURITY")
    op.execute("ALTER TABLE workout_sessions DISABLE ROW LEVEL SECURITY")

    op.drop_table("personal_records")
    op.drop_table("session_sets")
    op.drop_table("workout_sessions")
    op.drop_table("workout_assignments")
    op.drop_table("trainee_relations")
    op.drop_table("workout_exercises")
    op.drop_table("workouts")
    op.drop_table("exercises")
    op.drop_table("users")
    op.execute("DROP TYPE IF EXISTS user_role")
    op.execute("DROP TYPE IF EXISTS workout_level")
