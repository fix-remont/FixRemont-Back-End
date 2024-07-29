from sqlalchemy.orm import Session
from fastapi import HTTPException, UploadFile
from src.database import models, schemas
import base64


def create_work(work: schemas.WorkCreate, files: list[UploadFile], db: Session):
    if len(files) == 0:
        raise HTTPException(status_code=400, detail="No files")
    images = []
    for file in files:
        images.append(file.file.read())
    work_data = models.Work(
        title=work.title,
        deadline=work.deadline,
        cost=work.cost,
        square=work.square,
        task=work.task,
        description=work.description,
        images=images
    )
    db.add(work_data)
    db.commit()
    db.refresh(work_data)
    return work_data


def get_work(work_id: int, db: Session):
    work = db.query(models.Work).filter(models.Work.id == work_id).first()
    if work is None:
        raise HTTPException(status_code=404, detail="Work not found")
    work_data = {
        "title": work.title,
        "deadline": work.deadline,
        "cost": work.cost,
        "square": work.square,
        "task": work.task,
        "description": work.description,
        "images": [base64.b64encode(i).decode('utf-8') if i else None for i in work.images]
    }
    return work_data
