FROM python:3.11-slim

WORKDIR /app

# Dependências do sistema para psycopg2
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Instala dependências Python
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o backend para /app
COPY backend/ .

# Não rodar como root
RUN adduser --disabled-password --gecos "" appuser
USER appuser

EXPOSE 8000

# Alembic + Uvicorn — PORT vem do Railway
CMD sh -c "alembic upgrade head && uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"
