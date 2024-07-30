from src.database.crud import get_all_posts, get_post, create_post
from src.database.schemas import PostType
from typing import Optional, List

from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from src.database import db as database, schemas

router = APIRouter()


@router.post("/create-blog/", response_model=schemas.Post)
async def create_post_endpoint(post: schemas.PostCreate = Depends(),
                               files: List[UploadFile] = File(...), db: Session = Depends(database.get_db)):
    return create_post(post, files, db)


@router.get("/blog")
async def get_all_posts_endpoint(post_type: Optional[str] = '', db: Session = Depends(database.get_db)):
    print(post_type, [x.lower() for x in PostType.__members__])
    if post_type and post_type not in [x.lower() for x in PostType.__members__]:
        raise HTTPException(status_code=400, detail="Invalid post type")
    return get_all_posts(post_type, db)


@router.get("/blog/{post_id}")
async def get_post_endpoint(post_id: int, db: Session = Depends(database.get_db)):
    return get_post(post_id, db)
