from fastapi import APIRouter, Depends

from src.database import database
from src.database.crud import *

router = APIRouter()


@router.get("/portfolio")
async def portfolio():
    return {"message": "Portfolio"}


@router.get("/work/{work_id}")
async def get_work_endpoint(work_id: int, db: Session = Depends(database.get_db)):
    return get_work(work_id, db)
