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
# # WorkStatus routes
# @router.post("/work_statuses/", response_model=schemas.WorkStatusSchema)
# async def create_work_status(work_status: schemas.WorkStatusSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_work_status(work_status, db)
#
#
# @router.get("/work_statuses/{work_status_id}", response_model=schemas.WorkStatusSchema)
# async def get_work_status(work_status_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_work_status(work_status_id, db)
#
#
# @router.get("/work_statuses/", response_model=List[schemas.WorkStatusSchema])
# async def get_all_work_statuses(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_work_statuses(db)
#
#
# @router.put("/work_statuses/{work_status_id}", response_model=schemas.WorkStatusSchema)
# async def update_work_status(work_status_id: int, work_status: schemas.WorkStatusSchema,
#                              db: AsyncSession = Depends(get_db)):
#     return await crud.update_work_status(work_status_id, work_status, db)
#
#
# @router.delete("/work_statuses/{work_status_id}", response_model=schemas.WorkStatusSchema)
# async def delete_work_status(work_status_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_work_status(work_status_id, db)
