✅ FASE 2 — TESTES (TDD Backend) — CONCLUÍDA
Aqui está o conjunto completo de testes TDD para o Backend (FastAPI + PostgreSQL).
Todos os testes foram escritos para falhar primeiro (Red Phase).
Na FASE 3 você implementa o código até todos passarem (Green Phase).

📁 Estrutura de Testes (crie esta pasta no backend)
textbackend/tests/
├── __init__.py
├── conftest.py                  # Fixtures (banco de teste, client, usuários)
├── test_auth.py
├── test_dashboard.py
├── test_students.py
├── test_workouts.py
├── test_sessions.py
├── test_security.py             # IDOR, RLS, autorização
└── test_pr_detection.py

1. conftest.py (Fixtures obrigatórias)
Pythonimport pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.main import app
from app.core.database import Base, get_db
from app.models.user import User

SQLALCHEMY_DATABASE_URL = "postgresql://test:test@localhost:5432/kinetic_test"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

@pytest.fixture(scope="function")
def db_session():
    Base.metadata.create_all(bind=engine)
    db = TestingSessionLocal()
    yield db
    db.close()
    Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="function")
def client(db_session):
    def override_get_db():
        yield db_session
    app.dependency_overrides[get_db] = override_get_db
    yield TestClient(app)
    app.dependency_overrides.clear()

# Usuários de teste
@pytest.fixture
def trainer_user(db_session):
    user = User(email="trainer@kinetic.com", role="personal_trainer", name="Coach Silva")
    db_session.add(user)
    db_session.commit()
    return user

@pytest.fixture
def aluno_user(db_session):
    user = User(email="aluno@kinetic.com", role="aluno", name="Alex Silva")
    db_session.add(user)
    db_session.commit()
    return user

2. test_auth.py
Pythondef test_login_google_success(client):
    response = client.post("/auth/google", json={"token": "valid_google_token"})
    assert response.status_code == 200
    assert "access_token" in response.json()

def test_login_email_success(client):
    response = client.post("/auth/email", json={"email": "test@kinetic.com", "password": "123456"})
    assert response.status_code == 200

def test_login_invalid_token(client):
    response = client.post("/auth/google", json={"token": "invalid"})
    assert response.status_code == 401

3. test_dashboard.py
Pythondef test_dashboard_metrics_trainer_only(client, trainer_user):
    response = client.get("/dashboard/metrics", headers={"Authorization": f"Bearer {trainer_user.id}"})
    assert response.status_code == 200
    data = response.json()
    assert "active_students" in data
    assert "trained_today" in data
    assert "inactive_students" in data

def test_dashboard_aluno_nao_acessa(client, aluno_user):
    response = client.get("/dashboard/metrics", headers={"Authorization": f"Bearer {aluno_user.id}"})
    assert response.status_code == 403

4. test_students.py
Pythondef test_list_students_trainer(client, trainer_user):
    response = client.get("/students", headers={"Authorization": f"Bearer {trainer_user.id}"})
    assert response.status_code == 200

def test_adherence_calculation(client, trainer_user, aluno_user):
    response = client.get(f"/students/{aluno_user.id}/adherence", headers={"Authorization": f"Bearer {trainer_user.id}"})
    assert response.status_code == 200
    assert "adr_percent" in response.json()
    assert 0 <= response.json()["adr_percent"] <= 100

5. test_workouts.py (o mais importante)
Pythondef test_create_workout(client, trainer_user):
    payload = {
        "name": "Push Day A",
        "description": "Foco em peito e ombros",
        "level": "hypertrophy"
    }
    response = client.post("/workouts", json=payload, headers={"Authorization": f"Bearer {trainer_user.id}"})
    assert response.status_code == 201
    assert response.json()["name"] == "Push Day A"

def test_reorder_exercises(client, trainer_user):
    # Primeiro cria um workout
    workout = client.post("/workouts", json={"name": "Test Reorder"}, headers={"Authorization": f"Bearer {trainer_user.id}"}).json()
    # Adiciona exercícios (simulado)
    response = client.post(f"/workouts/{workout['id']}/reorder", json={"order": [3, 1, 2]}, headers={"Authorization": f"Bearer {trainer_user.id}"})
    assert response.status_code == 200

def test_assign_workout_to_student(client, trainer_user, aluno_user):
    workout = client.post("/workouts", json={"name": "Test Assign"}, headers={"Authorization": f"Bearer {trainer_user.id}"}).json()
    response = client.post(f"/workouts/{workout['id']}/assign", json={"student_ids": [aluno_user.id]}, headers={"Authorization": f"Bearer {trainer_user.id}"})
    assert response.status_code == 200

6. test_sessions.py
Pythondef test_start_session_and_log_set(client, aluno_user):
    # Aluno inicia treino
    response = client.post("/sessions", json={"workout_id": 1}, headers={"Authorization": f"Bearer {aluno_user.id}"})
    assert response.status_code == 201
    session_id = response.json()["id"]

    # Registra set
    set_payload = {
        "exercise_id": 10,
        "set_number": 1,
        "weight_kg": 85.0,
        "reps": 10,
        "rpe": 8
    }
    response = client.post(f"/sessions/{session_id}/sets", json=set_payload, headers={"Authorization": f"Bearer {aluno_user.id}"})
    assert response.status_code == 201

7. test_security.py (Security-First)
Pythondef test_idor_aluno_nao_acessa_treino_de_outro(client, aluno_user):
    response = client.get("/workouts/999", headers={"Authorization": f"Bearer {aluno_user.id}"})
    assert response.status_code == 404  # ou 403, dependendo da sua política

def test_trainer_nao_acessa_session_de_outro_aluno(client, trainer_user):
    response = client.get("/sessions/999", headers={"Authorization": f"Bearer {trainer_user.id}"})
    assert response.status_code in (403, 404)

Como rodar os testes (TDD)
Bashcd backend

# 1. Instalar dependências de teste
pip install pytest pytest-asyncio httpx sqlalchemy[asyncio] pytest-cov

# 2. Rodar todos os testes (devem falhar agora)
pytest -v --cov=app

# 3. Rodar só uma categoria
pytest tests/test_workouts.py -v