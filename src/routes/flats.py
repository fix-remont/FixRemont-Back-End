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
# # Flat routes
# @router.post("/flats/", response_model=schemas.FlatSchema)
# async def create_flat(flat: schemas.FlatSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_flat(flat, db)
#
#
# @router.get("/flats/{flat_id}", response_model=schemas.FlatSchema)
# async def get_flat(flat_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_flat(flat_id, db)
#
#
# @router.get("/flats/", response_model=List[schemas.FlatSchema])
# async def get_all_flats(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_flats(db)
#
#
# @router.put("/flats/{flat_id}", response_model=schemas.FlatSchema)
# async def update_flat(flat_id: int, flat: schemas.FlatSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_flat(flat_id, flat, db)
#
#
# @router.delete("/flats/{flat_id}", response_model=schemas.FlatSchema)
# async def delete_flat(flat_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_flat(flat_id, db)
