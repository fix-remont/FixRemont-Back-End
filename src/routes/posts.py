# from typing import List, Optional
#
# from fastapi import APIRouter, Depends, HTTPException
# from sqlalchemy.ext.asyncio import AsyncSession
# from src.database import crud, schemas
# from src.database.db import get_db
#
# router = APIRouter()
#
#
# # Post routes
# @router.post("/posts/", response_model=schemas.PostSchema)
# async def create_post(post: schemas.PostSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_post(post, db)
#
#
# @router.get("/posts/{post_id}", response_model=schemas.PostSchema)
# async def get_post(post_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_post(post_id, db)
#
#
# @router.get("/posts/", response_model=List[schemas.PostSchema])
# async def get_all_posts(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_posts(db)
#
#
# @router.put("/posts/{post_id}", response_model=schemas.PostSchema)
# async def update_post(post_id: int, post: schemas.PostSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_post(post_id, post, db)
#
#
# @router.delete("/posts/{post_id}", response_model=schemas.PostSchema)
# async def delete_post(post_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_post(post_id, db)
