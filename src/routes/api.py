from typing import List
from fastapi import APIRouter, File, UploadFile, Depends, HTTPException
from sqlalchemy.orm import Session
from src.database import schemas, database, crud
from src.database.crud import *

router = APIRouter()


@router.post("/create-work/", response_model=schemas.Work)
async def create_work_endpoint(work: schemas.WorkCreate = Depends(), file: UploadFile = File(...),
                               db: Session = Depends(database.get_db)):
    return await create_work(work, file, db)


@router.get("/works", response_model=List[schemas.Work])
async def get_works_endpoint(db: Session = Depends(database.get_db)):
    return get_works(db)


@router.get("/download-image/{work_id}")
async def download_image_endpoint(work_id: int, db: Session = Depends(database.get_db)):
    return download_image(work_id, db)


@router.get("/")
async def home():
    return {"message": "Home"}


@router.get("/contacts")
async def contacts():
    return {"message": "Contacts"}


@router.get("/feedbacks")
async def feedbacks():
    return {"message": "Feedbacks"}


@router.get("/about")
async def about():
    return {"message": "About"}


@router.get("/gratitude")
async def gratitude():
    return {"message": "Gratitude"}


@router.get("/{path:path}")
async def page_not_found(path: str):
    return {"message": "Page Not Found"}
