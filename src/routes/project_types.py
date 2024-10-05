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
# # ProjectType routes
# @router.post("/project_types/", response_model=schemas.ProjectTypeSchema)
# async def create_project_type(project_type: schemas.ProjectTypeSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_project_type(project_type, db)
#
#
# @router.get("/project_types/{project_type_id}", response_model=schemas.ProjectTypeSchema)
# async def get_project_type(project_type_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_project_type(project_type_id, db)
#
#
# @router.get("/project_types/", response_model=List[schemas.ProjectTypeSchema])
# async def get_all_project_types(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_project_types(db)
#
#
# @router.put("/project_types/{project_type_id}", response_model=schemas.ProjectTypeSchema)
# async def update_project_type(project_type_id: int, project_type: schemas.ProjectTypeSchema,
#                               db: AsyncSession = Depends(get_db)):
#     return await crud.update_project_type(project_type_id, project_type, db)
#
#
# @router.delete("/project_types/{project_type_id}", response_model=schemas.ProjectTypeSchema)
# async def delete_project_type(project_type_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_project_type(project_type_id, db)
