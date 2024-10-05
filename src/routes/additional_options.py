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
# # AdditionalOption routes
# @router.post("/additional_options/", response_model=schemas.AdditionalOptionSchema)
# async def create_additional_option(additional_option: schemas.AdditionalOptionSchema,
#                                    db: AsyncSession = Depends(get_db)):
#     return await crud.create_additional_option(additional_option, db)
#
#
# @router.get("/additional_options/{additional_option_id}", response_model=schemas.AdditionalOptionSchema)
# async def get_additional_option(additional_option_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_additional_option(additional_option_id, db)
#
#
# @router.get("/additional_options/", response_model=List[schemas.AdditionalOptionSchema])
# async def get_all_additional_options(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_additional_options(db)
#
#
# @router.put("/additional_options/{additional_option_id}", response_model=schemas.AdditionalOptionSchema)
# async def update_additional_option(additional_option_id: int, additional_option: schemas.AdditionalOptionSchema,
#                                    db: AsyncSession = Depends(get_db)):
#     return await crud.update_additional_option(additional_option_id, additional_option, db)
#
#
# @router.delete("/additional_options/{additional_option_id}", response_model=schemas.AdditionalOptionSchema)
# async def delete_additional_option(additional_option_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_additional_option(additional_option_id, db)
