from typing import Optional, List
from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.ext.asyncio import AsyncSession
from src.database import db as database, schemas
from src.database.crud import get_all_works, get_work, create_work
from src.database.models import ProjectType

router = APIRouter()


def get_all_project_types(db: AsyncSession):
    return db.query(ProjectType.name).all()


@router.post("/create-work/", response_model=schemas.Work)
async def create_work_endpoint(work: schemas.WorkCreate = Depends(),
                               db: AsyncSession = Depends(database.get_db)):
    return await create_work(work, db)


@router.get("/portfolio")
async def get_all_works_endpoint(project_type: Optional[str] = '', db: AsyncSession = Depends(database.get_db)):
    project_types = get_all_project_types(db)
    if project_type and project_type not in [x[0].lower() for x in project_types]:
        raise HTTPException(status_code=400, detail="Invalid project type")
    return await get_all_works(project_type, db)


@router.get("/work/{work_id}")
async def get_work_endpoint(work_id: int, db: AsyncSession = Depends(database.get_db)):
    return await get_work(work_id, db)
