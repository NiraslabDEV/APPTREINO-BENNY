from fastapi import APIRouter, status, Query
from sqlalchemy import select, or_, func
from pydantic import BaseModel, ConfigDict, Field
from typing import Optional
from ..core.deps import TrainerUser, DB
from ..models.workout import Exercise

router = APIRouter(prefix="/exercises", tags=["exercises"])

class ExerciseCreate(BaseModel):
    name: str = Field(max_length=100)
    muscle_group: str = Field(max_length=50)
    equipment: Optional[str] = Field(None, max_length=50)
    gif_url: Optional[str] = Field(None, max_length=512)

class ExerciseOut(ExerciseCreate):
    model_config = ConfigDict(from_attributes=True)
    id: str
    is_custom: bool
    trainer_id: Optional[str]

@router.post("", response_model=ExerciseOut, status_code=status.HTTP_201_CREATED)
async def create_exercise(body: ExerciseCreate, trainer: TrainerUser, db: DB):
    exercise = Exercise(
        name=body.name,
        muscle_group=body.muscle_group,
        equipment=body.equipment,
        gif_url=body.gif_url,
        trainer_id=trainer.id,
        is_custom=True,
    )
    db.add(exercise)
    await db.flush()
    await db.refresh(exercise)
    return exercise

@router.get("", response_model=list[ExerciseOut])
async def list_exercises(
    trainer: TrainerUser,
    db: DB,
    muscle_group: Optional[str] = Query(None),
    equipment: Optional[str] = Query(None),
):
    query = select(Exercise).where(or_(Exercise.trainer_id.is_(None), Exercise.trainer_id == trainer.id)).order_by(Exercise.name)
    if muscle_group:
        query = query.where(func.lower(Exercise.muscle_group).like(f"%{muscle_group.lower()}%"))
    if equipment:
        query = query.where(func.lower(Exercise.equipment).like(f"%{equipment.lower()}%"))
    result = await db.execute(query)
    return result.scalars().all()