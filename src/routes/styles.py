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
# # Style routes
# @router.post("/styles/", response_model=schemas.StyleSchema)
# async def create_style(style: schemas.StyleSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_style(style, db)
#
#
# @router.get("/styles/{style_id}", response_model=schemas.StyleSchema)
# async def get_style(style_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_style(style_id, db)
#
#
# @router.get("/styles/", response_model=List[schemas.StyleSchema])
# async def get_all_styles(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_styles(db)
#
#
# @router.put("/styles/{style_id}", response_model=schemas.StyleSchema)
# async def update_style(style_id: int, style: schemas.StyleSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_style(style_id, style, db)
#
#
# @router.delete("/styles/{style_id}", response_model=schemas.StyleSchema)
# async def delete_style(style_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_style(style_id, db)
