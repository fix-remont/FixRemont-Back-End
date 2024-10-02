# from typing import List
# from sqlalchemy.ext.asyncio import AsyncSession
# from src.database import crud, models
# from fastapi import FastAPI, Depends, HTTPException, status, APIRouter
# from admin import *
#
# router = APIRouter()
#
#
# @router.post("/flats/", response_model=schemas.FlatResponse)
# async def create_flat(flat: schemas.FlatCreate, db: AsyncSession = Depends(get_db)):
#     return await crud.create_flat(db, flat)
#
#
# @router.get("/tariffs/", response_model=List[schemas.Tariff])
# async def get_tariffs(db: AsyncSession = Depends(get_db)):
#     return await crud.get_tariffs(db)
#
#
# @router.get("/styles/", response_model=List[schemas.Style])
# async def get_styles(db: AsyncSession = Depends(get_db)):
#     return await crud.get_styles(db)
#
#
# @router.get("/additional-options/", response_model=List[schemas.AdditionalOption])
# async def get_additional_options(db: AsyncSession = Depends(get_db)):
#     return await crud.get_additional_options(db)
#
#
# @router.put("/flats/{flat_id}/tariff/", response_model=schemas.FlatResponse)
# async def update_flat_tariff(flat_id: int, tariff_id: int, db: AsyncSession = Depends(get_db)):
#     flat = await db.get(models.Flat, flat_id)
#     if not flat:
#         raise HTTPException(status_code=404, detail="Flat not found")
#     flat.tariff_id = tariff_id
#     await db.commit()
#     await db.refresh(flat)
#     return flat
#
#
# @router.put("/flats/{flat_id}/style/", response_model=schemas.FlatResponse)
# async def update_flat_style(flat_id: int, style_id: int, db: AsyncSession = Depends(get_db)):
#     flat = await db.get(models.Flat, flat_id)
#     if not flat:
#         raise HTTPException(status_code=404, detail="Flat not found")
#     flat.style_id = style_id
#     await db.commit()
#     await db.refresh(flat)
#     return flat
#
#
# @router.put("/flats/{flat_id}/additional-options/", response_model=schemas.FlatResponse)
# async def update_flat_additional_options(flat_id: int, option_ids: List[int], db: AsyncSession = Depends(get_db)):
#     flat = await db.get(models.Flat, flat_id)
#     if not flat:
#         raise HTTPException(status_code=404, detail="Flat not found")
#     flat.additional_options = [await db.get(models.AdditionalOption, option_id) for option_id in option_ids]
#     await db.commit()
#     await db.refresh(flat)
#     return flat
