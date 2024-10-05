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
# # Work routes
# @router.post("/works/", response_model=schemas.WorkSchema)
# async def create_work(work: schemas.WorkSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_work(work, db)
#
#
# @router.get("/works/{work_id}", response_model=schemas.WorkSchema)
# async def get_work(work_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_work(work_id, db)
#
#
# @router.get("/works/", response_model=List[schemas.WorkSchema])
# async def get_all_works(project_type: Optional[str] = None, db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_works(project_type, db)
#
#
# @router.put("/works/{work_id}", response_model=schemas.WorkSchema)
# async def update_work(work_id: int, work: schemas.WorkSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_work(work_id, work, db)
#
#
# @router.delete("/works/{work_id}", response_model=schemas.WorkSchema)
# async def delete_work(work_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_work(work_id, db)
