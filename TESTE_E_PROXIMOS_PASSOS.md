# KINETIC — Como Testar e Próximos Passos

**Data:** 10 de Abril de 2026  
**Status:** Backend deployado no Railway + Frontend Flutter rodando localmente

---

## 1. COMO TESTAR O APP NO CHROME

### Pré-requisitos
- Flutter SDK instalado (já está)
- Chrome instalado (já está)
- Terminal aberto na pasta do projeto

### Passo a passo

```bash
# 1. Entrar na pasta do Flutter
cd c:\Users\Gabriel\Desktop\APPTREINO\flutter

# 2. Instalar dependências (só na primeira vez)
flutter pub get

# 3. Rodar no Chrome
flutter run -d chrome
```

O app vai abrir no Chrome automaticamente em ~30 segundos.

### O que você vai ver

**Tela de Login:**
- Campo de e-mail
- Campo de senha
- Botão "ENTRAR"
- Divisor "ou"
- Botão "Continuar com Google"
- Link "Não tem conta? **Criar conta**" (amarelo neon)

**Tela de Registro (clicar em "Criar conta"):**
- Campo nome completo
- Campo e-mail
- Campo senha (mín. 8 caracteres)
- Seletor: "SOU ALUNO" ou "SOU PERSONAL"
- Botão "CRIAR CONTA"

**Após login como ALUNO → vai para:**
- Home (treino do dia, PRs recentes, progresso semanal)
- Aba Workouts (lista de treinos)
- Aba Progress (calendário, gráficos, PRs)

**Após login como PERSONAL TRAINER → vai para:**
- Dashboard (métricas: alunos ativos, treinaram hoje, inativos)
- Aba Students (lista de alunos com ADR%)
- Aba Builder (montar treino com exercícios)

### Atalhos úteis no Chrome
- `r` no terminal = hot reload (aplica mudanças sem reiniciar)
- `R` no terminal = hot restart (reinicia o app)
- `q` no terminal = sair

---

## 2. ESTADO ATUAL DO PROJETO

### Backend (Railway) ✅ ONLINE
- **URL:** `https://apptreino-benny-production.up.railway.app`
- **Health check:** `https://apptreino-benny-production.up.railway.app/health`
- **Docs (Swagger):** `https://apptreino-benny-production.up.railway.app/docs`

**Endpoints funcionando:**
| Método | Rota | Descrição | Status |
|--------|------|-----------|--------|
| POST | /auth/register | Criar conta (email+senha) | ⚠️ Precisa push |
| POST | /auth/email | Login com email | ✅ |
| POST | /auth/google | Login com Google | ✅ (precisa GOOGLE_CLIENT_ID) |
| POST | /auth/refresh | Renovar token | ✅ |
| GET | /health | Health check | ✅ |
| GET | /me | Perfil do usuário logado | ✅ |
| GET | /me/workouts/today | Treino do dia (aluno) | ✅ |
| GET | /me/personal-records | PRs do aluno | ✅ |
| GET | /dashboard/metrics | Métricas do personal | ✅ |
| GET | /students | Lista de alunos do personal | ✅ |
| GET | /students/{id}/profile | Perfil do aluno | ✅ |
| POST | /workouts | Criar treino | ✅ |
| PUT | /workouts/{id} | Editar treino | ✅ |
| POST | /workouts/{id}/assign | Atribuir treino a aluno | ✅ |
| POST | /sessions | Iniciar sessão de treino | ✅ |
| POST | /sessions/{id}/sets | Registrar série | ✅ |

### Frontend Flutter — 30 arquivos Dart
| Arquivo | Descrição | Status |
|---------|-----------|--------|
| `main.dart` | Entry point + BLoC providers | ✅ |
| `app_router.dart` | GoRouter com auth redirect | ✅ |
| `app_theme.dart` | Tema escuro KINETIC (cores Stitch) | ✅ |
| `injection.dart` | GetIt dependency injection | ✅ |
| `login_screen.dart` | Login email + Google + link registro | ✅ |
| `register_screen.dart` | Registro com seletor aluno/personal | ✅ |
| `auth_bloc.dart` | BLoC de autenticação | ✅ |
| `aluno_home_screen.dart` | Home do aluno (treino do dia) | ✅ |
| `session_screen.dart` | Execução de treino (timer + sets) | ✅ |
| `progress_screen.dart` | Progresso (calendar, charts, PRs) | ✅ |
| `trainer_dashboard_screen.dart` | Dashboard do personal | ✅ |
| `students_screen.dart` | Lista de alunos | ✅ |
| `student_profile_screen.dart` | Perfil do aluno (vista personal) | ✅ |
| `workout_builder_screen.dart` | Montar treino | ✅ |

### Banco de dados (PostgreSQL no Railway) ✅
Tabelas criadas via Alembic:
- `users` (email, senha Argon2id, role, google_id)
- `workouts` + `workout_exercises`
- `exercises`
- `workout_sessions` + `session_sets`
- `personal_records`
- `trainee_relations` (workout_assignments)

---

## 3. O QUE FALTA FAZER (PENDENTE)

### ✅ URGENTE (concluído)

**1. Endpoint de registro** ✅ (já estava pronto, testado com curl)

**2. ALLOWED_ORIGINS** ✅ (usuário confirmou)

**3. GOOGLE_CLIENT_ID** ✅ (usuário confirmou)

### 🟡 IMPORTANTE

**4. Seed de exercícios** ✅

Adicionei endpoints CRUD para trainers: GET /exercises (lista), POST /exercises (criar)

Push para Railway (deploy em progresso)

Criei `seed_exercises.py` com 20 exercícios focados em mulheres/senhoras para crescer quadril e pernas fortes:
- Hip Thrust (Glutes, Barbell)
- Glute Bridge (Glutes, Bodyweight)
- Bulgarian Split Squat (Glutes, Dumbbell)
- Romanian Deadlift (Hamstrings, Barbell)
- Back Squat (Quads, Barbell)
- Walking Lunges (Legs, Dumbbell)
- Leg Press (Legs, Machine)
- Good Mornings, Step Ups, Calf Raise, etc. (20 total)

Rode `python seed_exercises.py` após deploy confirmar /exercises funcionando.

**Perfis de treino criados:**

| Nome | Role | ID | Email |
|------|------|----|-------|
| Benny | personal_trainer | eac7e492-bd1b-4f9b-9410-acfe7e1fdcf9 | benny@kinetic.com |
| Ana Silva | aluno | 93abbdbe-3c63-41f6-b7bf-9b14d46304c7 | ana@aluna.com |
| Maria Santos | aluno | b940b8dd-d4c0-4efa-a159-ada090ffc611 | maria@aluna.com |
| Joana Oliveira | aluno | abd2042e-1c0a-422f-892f-453ce2ff1b6b | joana@aluna.com |

**5. Testar Android** ⏳ (usuário disse ainda não)

**6. Build APK** 🔄 em progresso (`flutter/build/app/outputs/flutter-apk/app-release.apk`)

### 🟢 FUTURO (Fase 2)

**7. Telas que faltam implementar**
- Tela de perfil do usuário (editar nome, foto, peso)
- Tela de histórico do personal (History tab)
- Tela de notificações
- Biblioteca de exercícios com busca e filtro
- Nudge (notificação para aluno inativo)

**8. Features avançadas**
- Suporte offline (Hive/Isar para cache local)
- Push notifications (Firebase Cloud Messaging)
- Fotos de progresso
- Exportar treino em PDF
- Supersets na montagem de treino

**9. Segurança (FASE 4 — Otimização)**
- Testes automatizados (pytest + flutter_test)
- IDOR protection tests
- Rate limiting fine-tuning
- Token refresh automático no Dio interceptor

---

## 4. ARQUITETURA DO PROJETO

```
APPTREINO/
├── backend/                    # Python + FastAPI
│   ├── app/
│   │   ├── core/
│   │   │   ├── config.py       # Pydantic Settings (.env)
│   │   │   ├── database.py     # SQLAlchemy async engine
│   │   │   ├── security.py     # Argon2id + JWT
│   │   │   └── deps.py         # Dependency injection (get_current_user)
│   │   ├── models/
│   │   │   ├── user.py         # User model (SQLAlchemy)
│   │   │   ├── workout.py      # Workout + Exercise models
│   │   │   └── session.py      # Session + Sets + PRs
│   │   ├── routers/
│   │   │   ├── auth.py         # Login + Register + Google + Refresh
│   │   │   ├── dashboard.py    # Métricas do personal
│   │   │   ├── students.py     # CRUD alunos
│   │   │   ├── workouts.py     # CRUD treinos + assign
│   │   │   └── sessions.py     # Sessões de treino + sets
│   │   └── main.py             # FastAPI app + rotas /me
│   ├── alembic/                # Migrations
│   └── requirements.txt
│
├── flutter/                    # Flutter mobile app
│   ├── lib/
│   │   ├── core/
│   │   │   ├── router/         # GoRouter com auth redirect
│   │   │   ├── theme/          # Tema escuro KINETIC
│   │   │   ├── di/             # GetIt injection
│   │   │   ├── network/        # Dio + ApiClient
│   │   │   ├── constants/      # URLs, keys, roles
│   │   │   ├── errors/         # Failure classes
│   │   │   └── utils/          # Either, validators
│   │   ├── features/
│   │   │   ├── auth/           # Login + Register + BLoC
│   │   │   ├── trainer/        # Dashboard + Students + Builder
│   │   │   └── aluno/          # Home + Session + Progress
│   │   └── main.dart
│   ├── .env                    # API_BASE_URL
│   └── pubspec.yaml
│
├── Dockerfile                  # Build do backend para Railway
├── railway.json                # Config Railway (DOCKERFILE builder)
├── .dockerignore
└── CLAUDE.md                   # Spec completa do projeto (SDD)
```

---

## 5. VARIÁVEIS DE AMBIENTE

### Railway (backend)
| Variável | Valor | Obrigatório |
|----------|-------|-------------|
| DATABASE_URL | (auto do PostgreSQL Railway) | ✅ |
| SECRET_KEY | `703bd5aa...` (já configurado) | ✅ |
| APP_ENV | `production` | ✅ |
| ALLOWED_ORIGINS | `http://localhost:8888,...` | ✅ |
| GOOGLE_CLIENT_ID | (do Google Cloud Console) | ⚠️ Só para Google login |

### Flutter (.env)
| Variável | Valor |
|----------|-------|
| API_BASE_URL | `https://apptreino-benny-production.up.railway.app` |
| GOOGLE_CLIENT_ID | (mesmo do Railway, quando configurar) |

---

## 6. COMANDOS ÚTEIS

```bash
# --- Flutter ---
flutter pub get                    # Instalar dependências
flutter run -d chrome              # Rodar no Chrome
flutter run -d windows             # Rodar no Windows
flutter run -d emulator-5554       # Rodar no emulador Android
flutter build apk --release        # Gerar APK
flutter analyze                    # Verificar erros

# --- Backend (local) ---
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload      # Rodar local (precisa .env com DATABASE_URL)

# --- Git ---
git add -A && git commit -m "msg"  # Commitar
git push origin main               # Push → Railway auto-deploy

# --- Railway ---
# Dashboard: https://railway.app/dashboard
# Logs: railway logs (se tiver CLI instalada)
```

---

**Última atualização:** 10/04/2026  
**Backend live:** https://apptreino-benny-production.up.railway.app  
**Próxima ação:** Push do código + criar primeira conta de teste
