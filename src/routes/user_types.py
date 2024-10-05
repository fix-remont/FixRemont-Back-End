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
# # UserType routes
# @router.post("/user_types/", response_model=schemas.UserTypeSchema)
# async def create_user_type(user_type: schemas.UserTypeSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_user_type(user_type, db)
#
#
# @router.get("/user_types/{user_type_id}", response_model=schemas.UserTypeSchema)
# async def get_user_type(user_type_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_user_type(user_type_id, db)
#
#
# @router.get("/user_types/", response_model=List[schemas.UserTypeSchema])
# async def get_all_user_types(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_user_types(db)
#
#
# @router.put("/user_types/{user_type_id}", response_model=schemas.UserTypeSchema)
# async def update_user_type(user_type_id: int, user_type: schemas.UserTypeSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_user_type(user_type_id, user_type, db)
#
#
# @router.delete("/user_types/{user_type_id}", response_model=schemas.UserTypeSchema)
# async def delete_user_type(user_type_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_user_type(user_type_id, db)
