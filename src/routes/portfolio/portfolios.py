from typing import Optional

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from src.database import database
from src.database.crud import get_all_works, get_work
from src.database.schemas import ProjectType

router = APIRouter()


@router.get("/portfolio")
async def get_all_works_endpoint(project_type: Optional[str] = '', db: Session = Depends(database.get_db)):
    if project_type and project_type not in [x.lower() for x in ProjectType.__members__]:
        raise HTTPException(status_code=400, detail="Invalid project type")
    return get_all_works(project_type, db)


@router.get("/work/{work_id}")
async def get_work_endpoint(work_id: int, db: Session = Depends(database.get_db)):
    return get_work(work_id, db)
