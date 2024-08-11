from fastapi import HTTPException, UploadFile
from sqlalchemy import select

from src.database import models, schemas
import base64
from typing import Optional, List
from sqlalchemy.ext.asyncio import AsyncSession
from src.database.schemas import ProjectType, PostType


async def get_work(work_id: int, db: AsyncSession):
    work = await db.execute(select(models.Work).filter(models.Work.id == work_id))
    work = work.scalars().first()
    if work is None:
        raise HTTPException(status_code=404, detail="Work not found")
    work_data = {
        "title": work.title,
        "project_type": work.project_type,
        "deadline": work.deadline,
        "cost": work.cost,
        "square": work.square,
        "task": work.task,
        "description": work.description,
        "images": [base64.b64encode(i).decode('utf-8') if i else None for i in work.images]
    }
    return work_data


async def get_all_works(project_type: Optional[str], db: AsyncSession):
    if project_type and project_type not in [x.lower() for x in ProjectType.__members__]:
        raise HTTPException(status_code=400, detail="Invalid project types")

    if project_type == 'all' or not project_type:
        works = await db.execute(select(models.Work))
    else:
        works = await db.execute(select(models.Work).filter(models.Work.project_type == project_type))

    works = works.scalars().all()
    works_data = []
    for work in works:
        work_data = {
            "title": work.title,
            "project_type": work.project_type,
            "deadline": work.deadline,
            "cost": work.cost,
            "square": work.square,
            "task": work.task,
            "description": work.description,
            "images": [base64.b64encode(i).decode('utf-8') if i else None for i in work.images]
        }
        works_data.append(work_data)
    return works_data


async def get_post(post_id: int, db: AsyncSession):
    post = await db.execute(select(models.Post).filter(models.Post.id == post_id))
    post = post.scalars().first()
    if post is None:
        raise HTTPException(status_code=404, detail="Post not found")
    post_data = {
        "title": post.title,
        "post_type": post.post_type,
        "content": post.content,
        "images": [base64.b64encode(i).decode('utf-8') if i else None for i in post.images]
    }
    return post_data


async def get_all_posts(post_type: Optional[str], db: AsyncSession):
    if post_type and post_type not in [x.value for x in PostType]:
        raise HTTPException(status_code=400, detail="Invalid post type")

    if post_type == 'all' or not post_type:
        posts = await db.execute(select(models.Post))
    else:
        posts = await db.execute(select(models.Post).filter(models.Post.post_type == post_type))

    posts = posts.scalars().all()
    posts_data = []
    for post in posts:
        post_data = {
            "title": post.title,
            "post_type": post.post_type,
            "content": post.content,
            "images": [base64.b64encode(i).decode('utf-8') if i else None for i in post.images]
        }
        posts_data.append(post_data)
    return posts_data


async def create_work(work: schemas.WorkCreate, files: list[UploadFile], db: AsyncSession):
    if len(files) == 0:
        raise HTTPException(status_code=400, detail="No files")
    images = []
    for file in files:
        images.append(file.file.read())
    work_data = models.Work(
        title=work.title,
        project_type=work.project_type,
        deadline=work.deadline,
        cost=work.cost,
        square=work.square,
        task=work.task,
        description=work.description,
        images=images
    )
    db.add(work_data)
    await db.commit()
    await db.refresh(work_data)
    return work_data


async def create_post(post: schemas.PostCreate, files: List[UploadFile], db: AsyncSession):
    if len(files) == 0:
        raise HTTPException(status_code=400, detail="No files")
    images = []
    for file in files:
        images.append(file.file.read())
    post_data = models.Post(
        title=post.title,
        post_type=post.post_type,
        content=post.content,
        images=images
    )
    db.add(post_data)
    await db.commit()
    await db.refresh(post_data)
    return post_data

# TODO: feedbacks
