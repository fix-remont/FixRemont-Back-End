from typing import List
from fastapi import APIRouter, File, UploadFile, Depends, HTTPException
from sqlalchemy.orm import Session
from src.database import schemas, database, crud
from src.database.crud import *
from fastapi import Response
from fastapi import APIRouter, File, UploadFile, Depends
from sqlalchemy.orm import Session
from src.database import schemas, database, crud

router = APIRouter()


@router.post("/create-work/", response_model=schemas.Work)
async def create_work_endpoint(work: schemas.WorkCreate = Depends(), files: List[UploadFile] = File(...),
                               db: Session = Depends(database.get_db)):
    return create_work(work, files, db)





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
