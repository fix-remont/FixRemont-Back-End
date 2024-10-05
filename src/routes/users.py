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
# # User routes
# @router.post("/users/", response_model=schemas.UserSchema)
# async def create_user(user: schemas.UserSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_user(user, db)
#
#
# @router.get("/users/{user_id}", response_model=schemas.UserSchema)
# async def get_user(user_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_user(user_id, db)
#
#
# @router.get("/users/", response_model=List[schemas.UserSchema])
# async def get_all_users(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_users(db)
#
#
# @router.put("/users/{user_id}", response_model=schemas.UserSchema)
# async def update_user(user_id: int, user: schemas.UserSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_user(user_id, user, db)
#
#
# @router.delete("/users/{user_id}", response_model=schemas.UserSchema)
# async def delete_user(user_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_user(user_id, db)
