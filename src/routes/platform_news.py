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
# # PlatformNews routes
# @router.post("/platform_news/", response_model=schemas.PlatformNewsSchema)
# async def create_platform_news(platform_news: schemas.PlatformNewsSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_platform_news(platform_news, db)
#
#
# @router.get("/platform_news/{platform_news_id}", response_model=schemas.PlatformNewsSchema)
# async def get_platform_news(platform_news_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_platform_news(platform_news_id, db)
#
#
# @router.get("/platform_news/", response_model=List[schemas.PlatformNewsSchema])
# async def get_all_platform_news(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_platform_news(db)
#
#
# @router.put("/platform_news/{platform_news_id}", response_model=schemas.PlatformNewsSchema)
# async def update_platform_news(platform_news_id: int, platform_news: schemas.PlatformNewsSchema,
#                                db: AsyncSession = Depends(get_db)):
#     return await crud.update_platform_news(platform_news_id, platform_news, db)
#
#
# @router.delete("/platform_news/{platform_news_id}", response_model=schemas.PlatformNewsSchema)
# async def delete_platform_news(platform_news_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_platform_news(platform_news_id, db)
