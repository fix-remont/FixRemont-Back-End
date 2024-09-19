from fastapi import HTTPException
from sqlalchemy import select
from src.database import models, schemas
import base64
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session
from src.database.models import User, ProjectType, PostType
from src.database.schemas import UserCreate
from src.auth.auth_routes import get_password_hash


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


def get_all_project_types(db: AsyncSession):
    return db.query(ProjectType.name).all()


async def get_all_works(project_type: Optional[str], db: AsyncSession):
    project_types = get_all_project_types(db)
    if project_type and project_type not in [x[0].lower() for x in project_types]:
        raise HTTPException(status_code=400, detail="Invalid project types")

    if project_type == 'all' or not project_type:
        result = await db.execute(select(models.Work))
    else:
        result = await db.execute(select(models.Work).filter(models.Work.project_type == project_type))

    works = result.scalars().all()
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
            "images": [base64.b64encode(base64.b64decode(i)).decode('utf-8') if i else None for i in work.images]
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
    post_types = db.query(PostType.name).all()
    if post_type and post_type not in [x[0].lower() for x in post_types]:
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


async def create_work(work: schemas.WorkCreate, db: AsyncSession):
    work_data = models.Work(
        title=work.title,
        project_type_id=work.project_type,
        deadline=work.deadline,
        cost=work.cost,
        square=work.square,
        task=work.task,
        description=work.description,
        images=work.images,
    )
    db.add(work_data)
    await db.commit()
    await db.refresh(work_data)
    return work_data


async def create_notification(notification: schemas.NotificationCreate, db: AsyncSession):
    notification_data = models.Notification(
        user_id=notification.user_id,
        message_type_id=notification.message_type,
        content=notification.content,
        attachment=notification.attachment
    )
    db.add(notification_data)
    await db.commit()
    await db.refresh(notification_data)
    return notification_data


async def create_post(post: schemas.PostCreate, db: AsyncSession):
    post_data = models.Post(
        title=post.title,
        post_type_id=post.post_type,
        content=post.content,
        images=post.images
    )
    db.add(post_data)
    await db.commit()
    await db.refresh(post_data)
    return post_data


def get_user_by_email(db: Session, email: str):
    return db.query(User).filter(User.email == email).first()


def create_user(user: UserCreate, db: Session):
    hashed_password = get_password_hash(user.password)
    db_user = User(email=user.email, hashed_password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


# src/database/crud.py

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from src.database import models, schemas


async def create_flat(db: AsyncSession, flat: schemas.FlatCreate):
    db_flat = models.Flat(**flat.dict())
    db.add(db_flat)
    await db.commit()
    await db.refresh(db_flat)
    return db_flat


async def get_tariffs(db: AsyncSession):
    result = await db.execute(select(models.Tariff))
    return result.scalars().all()


async def get_styles(db: AsyncSession):
    result = await db.execute(select(models.Style))
    return result.scalars().all()


async def get_additional_options(db: AsyncSession):
    result = await db.execute(select(models.AdditionalOption))
    return result.scalars().all()
