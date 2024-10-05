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
# # FAQ routes
# @router.post("/faqs/", response_model=schemas.FAQSchema)
# async def create_faq(faq: schemas.FAQSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_faq(faq, db)
#
#
# @router.get("/faqs/{faq_id}", response_model=schemas.FAQSchema)
# async def get_faq(faq_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_faq(faq_id, db)
#
#
# @router.get("/faqs/", response_model=List[schemas.FAQSchema])
# async def get_all_faqs(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_faqs(db)
#
#
# @router.put("/faqs/{faq_id}", response_model=schemas.FAQSchema)
# async def update_faq(faq_id: int, faq: schemas.FAQSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_faq(faq_id, faq, db)
#
#
# @router.delete("/faqs/{faq_id}", response_model=schemas.FAQSchema)
# async def delete_faq(faq_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_faq(faq_id, db)
