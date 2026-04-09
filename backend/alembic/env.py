import os
from logging.config import fileConfig
from sqlalchemy import engine_from_config, pool
from alembic import context

# Importa todos os models para o Base.metadata
from app.core.database import Base
from app.models.user import User
from app.models.workout import Workout, Exercise, WorkoutExercise, TraineeRelation, WorkoutAssignment
from app.models.session import WorkoutSession, SessionSet, PersonalRecord

config = context.config
fileConfig(config.config_file_name)

# Usa DATABASE_URL da variável de ambiente (sync — alembic não suporta async)
db_url = os.environ.get("DATABASE_URL", "").replace(
    "postgresql+asyncpg://", "postgresql+psycopg2://"
)
config.set_main_option("sqlalchemy.url", db_url)

target_metadata = Base.metadata


def run_migrations_offline():
    context.configure(
        url=db_url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )
    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online():
    connectable = engine_from_config(
        config.get_section(config.config_ini_section),
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
    )
    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)
        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
