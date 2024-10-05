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
# # NotificationType routes
# @router.post("/notification_types/", response_model=schemas.NotificationTypeSchema)
# async def create_notification_type(notification_type: schemas.NotificationTypeSchema,
#                                    db: AsyncSession = Depends(get_db)):
#     return await crud.create_notification_type(notification_type, db)
#
#
# @router.get("/notification_types/{notification_type_id}", response_model=schemas.NotificationTypeSchema)
# async def get_notification_type(notification_type_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_notification_type(notification_type_id, db)
#
#
# @router.get("/notification_types/", response_model=List[schemas.NotificationTypeSchema])
# async def get_all_notification_types(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_notification_types(db)
#
#
# @router.put("/notification_types/{notification_type_id}", response_model=schemas.NotificationTypeSchema)
# async def update_notification_type(notification_type_id: int, notification_type: schemas.NotificationTypeSchema,
#                                    db: AsyncSession = Depends(get_db)):
#     return await crud.update_notification_type(notification_type_id, notification_type, db)
#
#
# @router.delete("/notification_types/{notification_type_id}", response_model=schemas.NotificationTypeSchema)
# async def delete_notification_type(notification_type_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_notification_type(notification_type_id, db)
