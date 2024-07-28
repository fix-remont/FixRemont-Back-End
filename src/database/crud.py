from sqlalchemy.orm import Session
from fastapi import HTTPException, UploadFile
from src.database import models, schemas
import base64
import os
from fastapi.responses import FileResponse


async def create_work(work: schemas.WorkCreate, file: UploadFile, db: Session):
    image_data = await file.read()
    db_work = models.Work(**work.dict(), image=image_data)
    db.add(db_work)
    db.commit()
    db.refresh(db_work)
    return db_work


def get_works(db: Session):
    works = db.query(models.Work).all()
    return works


def download_image(work_id: int, db: Session):
    work = db.query(models.Work).filter(models.Work.id == work_id).first()
    if not work or not work.image:
        raise HTTPException(status_code=404, detail="Image not found")

    image_path = f"temp_image_{work_id}.png"
    with open(image_path, "wb") as image_file:
        image_file.write(work.image)

    response = FileResponse(image_path, media_type="image/png", filename=f"work_{work_id}.png")

    return response
