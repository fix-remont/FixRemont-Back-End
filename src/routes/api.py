from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from src.database import crud, schemas
from src.database.db import get_db

router = APIRouter()


# ProjectType routes
@router.post("/project_types/", response_model=schemas.ProjectTypeSchema)
async def create_project_type(project_type: schemas.ProjectTypeSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_project_type(project_type, db)


@router.get("/project_types/{project_type_id}", response_model=schemas.ProjectTypeSchema)
async def get_project_type(project_type_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_project_type(project_type_id, db)


@router.get("/project_types/", response_model=List[schemas.ProjectTypeSchema])
async def get_all_project_types(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_project_types(db)


@router.put("/project_types/{project_type_id}", response_model=schemas.ProjectTypeSchema)
async def update_project_type(project_type_id: int, project_type: schemas.ProjectTypeSchema,
                              db: AsyncSession = Depends(get_db)):
    return await crud.update_project_type(project_type_id, project_type, db)


@router.delete("/project_types/{project_type_id}", response_model=schemas.ProjectTypeSchema)
async def delete_project_type(project_type_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_project_type(project_type_id, db)


# UserType routes
@router.post("/user_types/", response_model=schemas.UserTypeSchema)
async def create_user_type(user_type: schemas.UserTypeSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_user_type(user_type, db)


@router.get("/user_types/{user_type_id}", response_model=schemas.UserTypeSchema)
async def get_user_type(user_type_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_user_type(user_type_id, db)


@router.get("/user_types/", response_model=List[schemas.UserTypeSchema])
async def get_all_user_types(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_user_types(db)


@router.put("/user_types/{user_type_id}", response_model=schemas.UserTypeSchema)
async def update_user_type(user_type_id: int, user_type: schemas.UserTypeSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_user_type(user_type_id, user_type, db)


@router.delete("/user_types/{user_type_id}", response_model=schemas.UserTypeSchema)
async def delete_user_type(user_type_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_user_type(user_type_id, db)


# NotificationType routes
@router.post("/notification_types/", response_model=schemas.NotificationTypeSchema)
async def create_notification_type(notification_type: schemas.NotificationTypeSchema,
                                   db: AsyncSession = Depends(get_db)):
    return await crud.create_notification_type(notification_type, db)


@router.get("/notification_types/{notification_type_id}", response_model=schemas.NotificationTypeSchema)
async def get_notification_type(notification_type_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_notification_type(notification_type_id, db)


@router.get("/notification_types/", response_model=List[schemas.NotificationTypeSchema])
async def get_all_notification_types(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_notification_types(db)


@router.put("/notification_types/{notification_type_id}", response_model=schemas.NotificationTypeSchema)
async def update_notification_type(notification_type_id: int, notification_type: schemas.NotificationTypeSchema,
                                   db: AsyncSession = Depends(get_db)):
    return await crud.update_notification_type(notification_type_id, notification_type, db)


@router.delete("/notification_types/{notification_type_id}", response_model=schemas.NotificationTypeSchema)
async def delete_notification_type(notification_type_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_notification_type(notification_type_id, db)


# Paragraph routes
@router.post("/paragraphs/", response_model=schemas.ParagraphSchema)
async def create_paragraph(paragraph: schemas.ParagraphSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_paragraph(paragraph, db)


@router.get("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
async def get_paragraph(paragraph_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_paragraph(paragraph_id, db)


@router.get("/paragraphs/", response_model=List[schemas.ParagraphSchema])
async def get_all_paragraphs(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_paragraphs(db)


@router.put("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
async def update_paragraph(paragraph_id: int, paragraph: schemas.ParagraphSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_paragraph(paragraph_id, paragraph, db)


@router.delete("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
async def delete_paragraph(paragraph_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_paragraph(paragraph_id, db)


# FAQ routes
@router.post("/faqs/", response_model=schemas.FAQSchema)
async def create_faq(faq: schemas.FAQSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_faq(faq, db)


@router.get("/faqs/{faq_id}", response_model=schemas.FAQSchema)
async def get_faq(faq_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_faq(faq_id, db)


@router.get("/faqs/", response_model=List[schemas.FAQSchema])
async def get_all_faqs(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_faqs(db)


@router.put("/faqs/{faq_id}", response_model=schemas.FAQSchema)
async def update_faq(faq_id: int, faq: schemas.FAQSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_faq(faq_id, faq, db)


@router.delete("/faqs/{faq_id}", response_model=schemas.FAQSchema)
async def delete_faq(faq_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_faq(faq_id, db)


# PlatformNews routes
@router.post("/platform_news/", response_model=schemas.PlatformNewsSchema)
async def create_platform_news(platform_news: schemas.PlatformNewsSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_platform_news(platform_news, db)


@router.get("/platform_news/{platform_news_id}", response_model=schemas.PlatformNewsSchema)
async def get_platform_news(platform_news_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_platform_news(platform_news_id, db)


@router.get("/platform_news/", response_model=List[schemas.PlatformNewsSchema])
async def get_all_platform_news(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_platform_news(db)


@router.put("/platform_news/{platform_news_id}", response_model=schemas.PlatformNewsSchema)
async def update_platform_news(platform_news_id: int, platform_news: schemas.PlatformNewsSchema,
                               db: AsyncSession = Depends(get_db)):
    return await crud.update_platform_news(platform_news_id, platform_news, db)


@router.delete("/platform_news/{platform_news_id}", response_model=schemas.PlatformNewsSchema)
async def delete_platform_news(platform_news_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_platform_news(platform_news_id, db)


# Flat routes
@router.post("/flats/", response_model=schemas.FlatSchema)
async def create_flat(flat: schemas.FlatSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_flat(flat, db)


@router.get("/flats/{flat_id}", response_model=schemas.FlatSchema)
async def get_flat(flat_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_flat(flat_id, db)


@router.get("/flats/", response_model=List[schemas.FlatSchema])
async def get_all_flats(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_flats(db)


@router.put("/flats/{flat_id}", response_model=schemas.FlatSchema)
async def update_flat(flat_id: int, flat: schemas.FlatSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_flat(flat_id, flat, db)


@router.delete("/flats/{flat_id}", response_model=schemas.FlatSchema)
async def delete_flat(flat_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_flat(flat_id, db)


# Tariff routes
@router.post("/tariffs/", response_model=schemas.TariffSchema)
async def create_tariff(tariff: schemas.TariffSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_tariff(tariff, db)


@router.get("/tariffs/{tariff_id}", response_model=schemas.TariffSchema)
async def get_tariff(tariff_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_tariff(tariff_id, db)


@router.get("/tariffs/", response_model=List[schemas.TariffSchema])
async def get_all_tariffs(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_tariffs(db)


@router.put("/tariffs/{tariff_id}", response_model=schemas.TariffSchema)
async def update_tariff(tariff_id: int, tariff: schemas.TariffSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_tariff(tariff_id, tariff, db)


@router.delete("/tariffs/{tariff_id}", response_model=schemas.TariffSchema)
async def delete_tariff(tariff_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_tariff(tariff_id, db)


# Style routes
@router.post("/styles/", response_model=schemas.StyleSchema)
async def create_style(style: schemas.StyleSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_style(style, db)


@router.get("/styles/{style_id}", response_model=schemas.StyleSchema)
async def get_style(style_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_style(style_id, db)


@router.get("/styles/", response_model=List[schemas.StyleSchema])
async def get_all_styles(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_styles(db)


@router.put("/styles/{style_id}", response_model=schemas.StyleSchema)
async def update_style(style_id: int, style: schemas.StyleSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_style(style_id, style, db)


@router.delete("/styles/{style_id}", response_model=schemas.StyleSchema)
async def delete_style(style_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_style(style_id, db)


# AdditionalOption routes
@router.post("/additional_options/", response_model=schemas.AdditionalOptionSchema)
async def create_additional_option(additional_option: schemas.AdditionalOptionSchema,
                                   db: AsyncSession = Depends(get_db)):
    return await crud.create_additional_option(additional_option, db)


@router.get("/additional_options/{additional_option_id}", response_model=schemas.AdditionalOptionSchema)
async def get_additional_option(additional_option_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_additional_option(additional_option_id, db)


@router.get("/additional_options/", response_model=List[schemas.AdditionalOptionSchema])
async def get_all_additional_options(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_additional_options(db)


@router.put("/additional_options/{additional_option_id}", response_model=schemas.AdditionalOptionSchema)
async def update_additional_option(additional_option_id: int, additional_option: schemas.AdditionalOptionSchema,
                                   db: AsyncSession = Depends(get_db)):
    return await crud.update_additional_option(additional_option_id, additional_option, db)


@router.delete("/additional_options/{additional_option_id}", response_model=schemas.AdditionalOptionSchema)
async def delete_additional_option(additional_option_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_additional_option(additional_option_id, db)


# FlatAdditionalOption routes
@router.post("/flat_additional_options/", response_model=schemas.FlatAdditionalOptionSchema)
async def create_flat_additional_option(flat_additional_option: schemas.FlatAdditionalOptionSchema,
                                        db: AsyncSession = Depends(get_db)):
    return await crud.create_flat_additional_option(flat_additional_option, db)


@router.get("/flat_additional_options/{flat_id}/{additional_option_id}",
            response_model=schemas.FlatAdditionalOptionSchema)
async def get_flat_additional_option(flat_id: int, additional_option_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_flat_additional_option(flat_id, additional_option_id, db)


@router.get("/flat_additional_options/", response_model=List[schemas.FlatAdditionalOptionSchema])
async def get_all_flat_additional_options(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_flat_additional_options(db)


@router.put("/flat_additional_options/{flat_id}/{additional_option_id}",
            response_model=schemas.FlatAdditionalOptionSchema)
async def update_flat_additional_option(flat_id: int, additional_option_id: int,
                                        flat_additional_option: schemas.FlatAdditionalOptionSchema,
                                        db: AsyncSession = Depends(get_db)):
    return await crud.update_flat_additional_option(flat_id, additional_option_id, flat_additional_option, db)


@router.delete("/flat_additional_options/{flat_id}/{additional_option_id}",
               response_model=schemas.FlatAdditionalOptionSchema)
async def delete_flat_additional_option(flat_id: int, additional_option_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_flat_additional_option(flat_id, additional_option_id, db)


# Work routes
@router.post("/works/", response_model=schemas.WorkSchema)
async def create_work(work: schemas.WorkSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_work(work, db)


@router.get("/works/{work_id}", response_model=schemas.WorkSchema)
async def get_work(work_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_work(work_id, db)


@router.get("/works/", response_model=List[schemas.WorkSchema])
async def get_all_works(project_type: Optional[str] = None, db: AsyncSession = Depends(get_db)):
    return await crud.get_all_works(project_type, db)


@router.put("/works/{work_id}", response_model=schemas.WorkSchema)
async def update_work(work_id: int, work: schemas.WorkSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_work(work_id, work, db)


@router.delete("/works/{work_id}", response_model=schemas.WorkSchema)
async def delete_work(work_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_work(work_id, db)


# Post routes
@router.post("/posts/", response_model=schemas.PostSchema)
async def create_post(post: schemas.PostSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_post(post, db)


@router.get("/posts/{post_id}", response_model=schemas.PostSchema)
async def get_post(post_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_post(post_id, db)


@router.get("/posts/", response_model=List[schemas.PostSchema])
async def get_all_posts(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_posts(db)


@router.put("/posts/{post_id}", response_model=schemas.PostSchema)
async def update_post(post_id: int, post: schemas.PostSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_post(post_id, post, db)


@router.delete("/posts/{post_id}", response_model=schemas.PostSchema)
async def delete_post(post_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_post(post_id, db)


# Contract routes
@router.post("/contracts/", response_model=schemas.ContractSchema)
async def create_contract(contract: schemas.ContractSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_contract(contract, db)


@router.get("/contracts/{contract_id}", response_model=schemas.ContractSchema)
async def get_contract(contract_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_contract(contract_id, db)


@router.get("/contracts/", response_model=List[schemas.ContractSchema])
async def get_all_contracts(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_contracts(db)


@router.put("/contracts/{contract_id}", response_model=schemas.ContractSchema)
async def update_contract(contract_id: int, contract: schemas.ContractSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_contract(contract_id, contract, db)


@router.delete("/contracts/{contract_id}", response_model=schemas.ContractSchema)
async def delete_contract(contract_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_contract(contract_id, db)


# WorkStatus routes
@router.post("/work_statuses/", response_model=schemas.WorkStatusSchema)
async def create_work_status(work_status: schemas.WorkStatusSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_work_status(work_status, db)


@router.get("/work_statuses/{work_status_id}", response_model=schemas.WorkStatusSchema)
async def get_work_status(work_status_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_work_status(work_status_id, db)


@router.get("/work_statuses/", response_model=List[schemas.WorkStatusSchema])
async def get_all_work_statuses(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_work_statuses(db)


@router.put("/work_statuses/{work_status_id}", response_model=schemas.WorkStatusSchema)
async def update_work_status(work_status_id: int, work_status: schemas.WorkStatusSchema,
                             db: AsyncSession = Depends(get_db)):
    return await crud.update_work_status(work_status_id, work_status, db)


@router.delete("/work_statuses/{work_status_id}", response_model=schemas.WorkStatusSchema)
async def delete_work_status(work_status_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_work_status(work_status_id, db)


# User routes
@router.post("/users/", response_model=schemas.UserSchema)
async def create_user(user: schemas.UserSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_user(user, db)


@router.get("/users/{user_id}", response_model=schemas.UserSchema)
async def get_user(user_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_user(user_id, db)


@router.get("/users/", response_model=List[schemas.UserSchema])
async def get_all_users(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_users(db)


@router.put("/users/{user_id}", response_model=schemas.UserSchema)
async def update_user(user_id: int, user: schemas.UserSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_user(user_id, user, db)


@router.delete("/users/{user_id}", response_model=schemas.UserSchema)
async def delete_user(user_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_user(user_id, db)


# Example for Paragraph
@router.post("/paragraphs/", response_model=schemas.ParagraphSchema)
async def create_paragraph(paragraph: schemas.ParagraphSchema, db: AsyncSession = Depends(get_db)):
    return await crud.create_paragraph(paragraph, db)


@router.get("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
async def get_paragraph(paragraph_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.get_paragraph(paragraph_id, db)


@router.get("/paragraphs/", response_model=List[schemas.ParagraphSchema])
async def get_all_paragraphs(db: AsyncSession = Depends(get_db)):
    return await crud.get_all_paragraphs(db)


@router.put("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
async def update_paragraph(paragraph_id: int, paragraph: schemas.ParagraphSchema, db: AsyncSession = Depends(get_db)):
    return await crud.update_paragraph(paragraph_id, paragraph, db)


@router.delete("/paragraphs/{paragraph_id}", response_model=schemas.ParagraphSchema)
async def delete_paragraph(paragraph_id: int, db: AsyncSession = Depends(get_db)):
    return await crud.delete_paragraph(paragraph_id, db)
