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
# # Paragraph routes
# @router.post("/paragraphs/", response_model=schemas.ParagraphSchema)
# async def create_paragraph(paragraph: schemas.ParagraphSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_paragraph(paragraph, db)
#
#
# @router.get("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
# async def get_paragraph(paragraph_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_paragraph(paragraph_id, db)
#
#
# @router.get("/paragraphs/", response_model=List[schemas.ParagraphSchema])
# async def get_all_paragraphs(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_paragraphs(db)
#
#
# @router.put("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
# async def update_paragraph(paragraph_id: int, paragraph: schemas.ParagraphSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_paragraph(paragraph_id, paragraph, db)
#
#
# @router.delete("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
# async def delete_paragraph(paragraph_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_paragraph(paragraph_id, db)
