import pytest
import pytest_asyncio
from httpx import AsyncClient, ASGITransport
from sqlalchemy.ext.asyncio import (
    AsyncSession, create_async_engine, async_sessionmaker
)
from app.main import app
from app.core.database import Base, get_db
from app.core.security import hash_password, create_access_token
from app.models.user import User
from app.models.workout import Workout, TraineeRelation, WorkoutAssignment

DATABASE_TEST_URL = "postgresql+asyncpg://kinetic:kinetic@localhost:5432/kinetic_test"

engine_test = create_async_engine(DATABASE_TEST_URL, echo=False)
TestSessionLocal = async_sessionmaker(
    engine_test, class_=AsyncSession, expire_on_commit=False
)


async def override_get_db():
    async with TestSessionLocal() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise


@pytest_asyncio.fixture(scope="function", autouse=True)
async def setup_db():
    async with engine_test.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    async with engine_test.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


@pytest_asyncio.fixture
async def db_session():
    async with TestSessionLocal() as session:
        yield session


@pytest_asyncio.fixture
async def client():
    app.dependency_overrides[get_db] = override_get_db
    async with AsyncClient(
        transport=ASGITransport(app=app), base_url="http://test"
    ) as c:
        yield c
    app.dependency_overrides.clear()


# --- Fixtures de usuários ---
@pytest_asyncio.fixture
async def trainer_user(db_session: AsyncSession):
    user = User(
        id="trainer-001",
        email="trainer@kinetic.com",
        role="personal_trainer",
        name="Coach Silva",
        hashed_password=hash_password("senha123!"),
    )
    db_session.add(user)
    await db_session.commit()
    return user


@pytest_asyncio.fixture
async def aluno_user(db_session: AsyncSession):
    user = User(
        id="aluno-001",
        email="aluno@kinetic.com",
        role="aluno",
        name="Alex Silva",
        hashed_password=hash_password("senha123!"),
    )
    db_session.add(user)
    await db_session.commit()
    return user


@pytest_asyncio.fixture
async def other_aluno(db_session: AsyncSession):
    """Aluno de outro trainer — para testes de IDOR."""
    user = User(
        id="aluno-002",
        email="outro@kinetic.com",
        role="aluno",
        name="Outro Aluno",
        hashed_password=hash_password("senha123!"),
    )
    db_session.add(user)
    await db_session.commit()
    return user


# --- Tokens de autenticação ---
@pytest.fixture
def trainer_token(trainer_user):
    return create_access_token(trainer_user.id, trainer_user.role)


@pytest.fixture
def aluno_token(aluno_user):
    return create_access_token(aluno_user.id, aluno_user.role)


@pytest.fixture
def other_aluno_token(other_aluno):
    return create_access_token(other_aluno.id, other_aluno.role)


def auth_header(token: str) -> dict:
    return {"Authorization": f"Bearer {token}"}
