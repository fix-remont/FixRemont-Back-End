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
# # FlatAdditionalOption routes
# @router.post("/flat_additional_options/", response_model=schemas.FlatAdditionalOptionSchema)
# async def create_flat_additional_option(flat_additional_option: schemas.FlatAdditionalOptionSchema,
#                                         db: AsyncSession = Depends(get_db)):
#     return await crud.create_flat_additional_option(flat_additional_option, db)
#
#
# @router.get("/flat_additional_options/{flat_id}/{additional_option_id}",
#             response_model=schemas.FlatAdditionalOptionSchema)
# async def get_flat_additional_option(flat_id: int, additional_option_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_flat_additional_option(flat_id, additional_option_id, db)
#
#
# @router.get("/flat_additional_options/", response_model=List[schemas.FlatAdditionalOptionSchema])
# async def get_all_flat_additional_options(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_flat_additional_options(db)
#
#
# @router.put("/flat_additional_options/{flat_id}/{additional_option_id}",
#             response_model=schemas.FlatAdditionalOptionSchema)
# async def update_flat_additional_option(flat_id: int, additional_option_id: int,
#                                         flat_additional_option: schemas.FlatAdditionalOptionSchema,
#                                         db: AsyncSession = Depends(get_db)):
#     return await crud.update_flat_additional_option(flat_id, additional_option_id, flat_additional_option, db)
#
#
# @router.delete("/flat_additional_options/{flat_id}/{additional_option_id}",
#                response_model=schemas.FlatAdditionalOptionSchema)
# async def delete_flat_additional_option(flat_id: int, additional_option_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_flat_additional_option(flat_id, additional_option_id, db)
