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
# # Tariff routes
# @router.post("/tariffs/", response_model=schemas.TariffSchema)
# async def create_tariff(tariff: schemas.TariffSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_tariff(tariff, db)
#
#
# @router.get("/tariffs/{tariff_id}", response_model=schemas.TariffSchema)
# async def get_tariff(tariff_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_tariff(tariff_id, db)
#
#
# @router.get("/tariffs/", response_model=List[schemas.TariffSchema])
# async def get_all_tariffs(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_tariffs(db)
#
#
# @router.put("/tariffs/{tariff_id}", response_model=schemas.TariffSchema)
# async def update_tariff(tariff_id: int, tariff: schemas.TariffSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_tariff(tariff_id, tariff, db)
#
#
# @router.delete("/tariffs/{tariff_id}", response_model=schemas.TariffSchema)
# async def delete_tariff(tariff_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_tariff(tariff_id, db)
