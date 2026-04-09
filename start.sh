#!/bin/bash
set -e

cd backend
python3 -m pip install -r requirements.txt
python3 -m alembic upgrade head
python3 -m uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}
