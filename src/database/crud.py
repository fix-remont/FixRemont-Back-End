# from fastapi import HTTPException
# from sqlalchemy import select
# from sqlalchemy.ext.asyncio import AsyncSession
# from sqlalchemy.orm import Session
# from src.database import models, schemas
# from src.auth.auth_routes import get_password_hash
# import base64
# from typing import Optional, List
# from sqlalchemy.ext.asyncio import AsyncSession
# from sqlalchemy.orm import Session
# from src.database.models import User, ProjectType, PostType
#
#
# # CRUD operations for ProjectType
# async def create_project_type(project_type: schemas.ProjectTypeSchema, db: AsyncSession):
#     db_project_type = models.ProjectType(**project_type.dict())
#     db.add(db_project_type)
#     db.commit()
#     db.refresh(db_project_type)
#     return db_project_type
#
#
# async def get_project_type(project_type_id: int, db: AsyncSession):
#     result = db.execute(select(models.ProjectType).filter(models.ProjectType.id == project_type_id))
#     project_type = result.scalars().first()
#     if project_type is None:
#         raise HTTPException(status_code=404, detail="Project type not found")
#     return project_type
#
#
# async def get_all_project_types(db: AsyncSession):
#     result = db.execute(select(models.ProjectType))
#     return result.scalars().all()
#
#
# async def update_project_type(project_type_id: int, project_type: schemas.ProjectTypeSchema, db: AsyncSession):
#     db_project_type = await get_project_type(project_type_id, db)
#     for key, value in project_type.dict().items():
#         setattr(db_project_type, key, value)
#     db.commit()
#     db.refresh(db_project_type)
#     return db_project_type
#
#
# async def delete_project_type(project_type_id: int, db: AsyncSession):
#     db_project_type = await get_project_type(project_type_id, db)
#     db.delete(db_project_type)
#     db.commit()
#     return db_project_type
#
#
# # CRUD operations for UserType
# async def create_user_type(user_type: schemas.UserTypeSchema, db: AsyncSession):
#     db_user_type = models.UserType(**user_type.dict())
#     db.add(db_user_type)
#     db.commit()
#     db.refresh(db_user_type)
#     return db_user_type
#
#
# async def get_user_type(user_type_id: int, db: AsyncSession):
#     result = db.execute(select(models.UserType).filter(models.UserType.id == user_type_id))
#     user_type = result.scalars().first()
#     if user_type is None:
#         raise HTTPException(status_code=404, detail="User type not found")
#     return user_type
#
#
# async def get_all_user_types(db: AsyncSession):
#     result = db.execute(select(models.UserType))
#     return result.scalars().all()
#
#
# async def update_user_type(user_type_id: int, user_type: schemas.UserTypeSchema, db: AsyncSession):
#     db_user_type = await get_user_type(user_type_id, db)
#     for key, value in user_type.dict().items():
#         setattr(db_user_type, key, value)
#     db.commit()
#     db.refresh(db_user_type)
#     return db_user_type
#
#
# async def delete_user_type(user_type_id: int, db: AsyncSession):
#     db_user_type = await get_user_type(user_type_id, db)
#     db.delete(db_user_type)
#     db.commit()
#     return db_user_type
#
#
# # CRUD operations for NotificationType
# async def create_notification_type(notification_type: schemas.NotificationTypeSchema, db: AsyncSession):
#     db_notification_type = models.NotificationType(**notification_type.dict())
#     db.add(db_notification_type)
#     db.commit()
#     db.refresh(db_notification_type)
#     return db_notification_type
#
#
# async def get_notification_type(notification_type_id: int, db: AsyncSession):
#     result = db.execute(
#         select(models.NotificationType).filter(models.NotificationType.id == notification_type_id))
#     notification_type = result.scalars().first()
#     if notification_type is None:
#         raise HTTPException(status_code=404, detail="Notification type not found")
#     return notification_type
#
#
# async def get_all_notification_types(db: AsyncSession):
#     result = db.execute(select(models.NotificationType))
#     return result.scalars().all()
#
#
# async def update_notification_type(notification_type_id: int, notification_type: schemas.NotificationTypeSchema,
#                                    db: AsyncSession):
#     db_notification_type = await get_notification_type(notification_type_id, db)
#     for key, value in notification_type.dict().items():
#         setattr(db_notification_type, key, value)
#     db.commit()
#     db.refresh(db_notification_type)
#     return db_notification_type
#
#
# async def delete_notification_type(notification_type_id: int, db: AsyncSession):
#     db_notification_type = await get_notification_type(notification_type_id, db)
#     db.delete(db_notification_type)
#     db.commit()
#     return db_notification_type
#
#
# # CRUD operations for Paragraph
# async def create_paragraph(paragraph: schemas.ParagraphSchema, db: AsyncSession):
#     db_paragraph = models.Paragraph(**paragraph.dict())
#     db.add(db_paragraph)
#     db.commit()
#     db.refresh(db_paragraph)
#     return db_paragraph
#
#
# async def get_paragraph(paragraph_id: int, db: AsyncSession):
#     result = await db.execute(select(models.Paragraph).filter(models.Paragraph.id == paragraph_id))
#     paragraph = result.scalars().first()
#     if paragraph is None:
#         raise HTTPException(status_code=404, detail="Paragraph not found")
#     return paragraph
#
#
# async def get_all_paragraphs(db: AsyncSession):
#     result = db.execute(select(models.Paragraph))
#     return result.scalars().all()
#
#
# async def update_paragraph(paragraph_id: int, paragraph: schemas.ParagraphSchema, db: AsyncSession):
#     db_paragraph = await get_paragraph(paragraph_id, db)
#     for key, value in paragraph.dict().items():
#         setattr(db_paragraph, key, value)
#     db.commit()
#     db.refresh(db_paragraph)
#     return db_paragraph
#
#
# async def delete_paragraph(paragraph_id: int, db: AsyncSession):
#     db_paragraph = await get_paragraph(paragraph_id, db)
#     db.delete(db_paragraph)
#     db.commit()
#     return db_paragraph
#
#
# # CRUD operations for FAQ
# async def create_faq(faq: schemas.FAQSchema, db: AsyncSession):
#     db_faq = models.FAQ(**faq.dict())
#     db.add(db_faq)
#     db.commit()
#     db.refresh(db_faq)
#     return db_faq
#
#
# async def get_faq(faq_id: int, db: AsyncSession):
#     result = await db.execute(select(models.FAQ).filter(models.FAQ.id == faq_id))
#     faq = result.scalars().first()
#     if faq is None:
#         raise HTTPException(status_code=404, detail="FAQ not found")
#     return faq
#
#
# async def get_all_faqs(db: AsyncSession):
#     result = db.execute(select(models.FAQ))
#     return result.scalars().all()
#
#
# async def update_faq(faq_id: int, faq: schemas.FAQSchema, db: AsyncSession):
#     db_faq = await get_faq(faq_id, db)
#     for key, value in faq.dict().items():
#         setattr(db_faq, key, value)
#     db.commit()
#     db.refresh(db_faq)
#     return db_faq
#
#
# async def delete_faq(faq_id: int, db: AsyncSession):
#     db_faq = await get_faq(faq_id, db)
#     db.delete(db_faq)
#     db.commit()
#     return db_faq
#
#
# # CRUD operations for PlatformNews
# async def create_platform_news(platform_news: schemas.PlatformNewsSchema, db: AsyncSession):
#     db_platform_news = models.PlatformNews(**platform_news.dict())
#     db.add(db_platform_news)
#     db.commit()
#     db.refresh(db_platform_news)
#     return db_platform_news
#
#
# async def get_platform_news(platform_news_id: int, db: AsyncSession):
#     result = await db.execute(select(models.PlatformNews).filter(models.PlatformNews.id == platform_news_id))
#     platform_news = result.scalars().first()
#     if platform_news is None:
#         raise HTTPException(status_code=404, detail="Platform news not found")
#     return platform_news
#
#
# async def get_all_platform_news(db: AsyncSession):
#     result = db.execute(select(models.PlatformNews))
#     return result.scalars().all()
#
#
# async def update_platform_news(platform_news_id: int, platform_news: schemas.PlatformNewsSchema, db: AsyncSession):
#     db_platform_news = await get_platform_news(platform_news_id, db)
#     for key, value in platform_news.dict().items():
#         setattr(db_platform_news, key, value)
#     db.commit()
#     db.refresh(db_platform_news)
#     return db_platform_news
#
#
# async def delete_platform_news(platform_news_id: int, db: AsyncSession):
#     db_platform_news = await get_platform_news(platform_news_id, db)
#     db.delete(db_platform_news)
#     db.commit()
#     return db_platform_news
#
#
# # CRUD operations for Flat
# async def create_flat(flat: schemas.FlatSchema, db: AsyncSession):
#     db_flat = models.Flat(**flat.dict())
#     db.add(db_flat)
#     db.commit()
#     db.refresh(db_flat)
#     return db_flat
#
#
# async def get_flat(flat_id: int, db: AsyncSession):
#     result = await db.execute(select(models.Flat).filter(models.Flat.id == flat_id))
#     flat = result.scalars().first()
#     if flat is None:
#         raise HTTPException(status_code=404, detail="Flat not found")
#     return flat
#
#
# async def get_all_flats(db: AsyncSession):
#     result = db.execute(select(models.Flat))
#     return result.scalars().all()
#
#
# async def update_flat(flat_id: int, flat: schemas.FlatSchema, db: AsyncSession):
#     db_flat = await get_flat(flat_id, db)
#     for key, value in flat.dict().items():
#         setattr(db_flat, key, value)
#     db.commit()
#     db.refresh(db_flat)
#     return db_flat
#
#
# async def delete_flat(flat_id: int, db: AsyncSession):
#     db_flat = await get_flat(flat_id, db)
#     db.delete(db_flat)
#     db.commit()
#     return db_flat
#
#
# # CRUD operations for Tariff
# async def create_tariff(tariff: schemas.TariffSchema, db: AsyncSession):
#     db_tariff = models.Tariff(**tariff.dict())
#     db.add(db_tariff)
#     db.commit()
#     db.refresh(db_tariff)
#     return db_tariff
#
#
# async def get_tariff(tariff_id: int, db: AsyncSession):
#     result = await db.execute(select(models.Tariff).filter(models.Tariff.id == tariff_id))
#     tariff = result.scalars().first()
#     if tariff is None:
#         raise HTTPException(status_code=404, detail="Tariff not found")
#     return tariff
#
#
# async def get_all_tariffs(db: AsyncSession):
#     result = db.execute(select(models.Tariff))
#     return result.scalars().all()
#
#
# async def update_tariff(tariff_id: int, tariff: schemas.TariffSchema, db: AsyncSession):
#     db_tariff = await get_tariff(tariff_id, db)
#     for key, value in tariff.dict().items():
#         setattr(db_tariff, key, value)
#     db.commit()
#     db.refresh(db_tariff)
#     return db_tariff
#
#
# async def delete_tariff(tariff_id: int, db: AsyncSession):
#     db_tariff = await get_tariff(tariff_id, db)
#     db.delete(db_tariff)
#     db.commit()
#     return db_tariff
#
#
# # CRUD operations for Style
# async def create_style(style: schemas.StyleSchema, db: AsyncSession):
#     db_style = models.Style(**style.dict())
#     db.add(db_style)
#     db.commit()
#     db.refresh(db_style)
#     return db_style
#
#
# async def get_style(style_id: int, db: AsyncSession):
#     result = await db.execute(select(models.Style).filter(models.Style.id == style_id))
#     style = result.scalars().first()
#     if style is None:
#         raise HTTPException(status_code=404, detail="Style not found")
#     return style
#
#
# async def get_all_styles(db: AsyncSession):
#     result = db.execute(select(models.Style))
#     return result.scalars().all()
#
#
# async def update_style(style_id: int, style: schemas.StyleSchema, db: AsyncSession):
#     db_style = await get_style(style_id, db)
#     for key, value in style.dict().items():
#         setattr(db_style, key, value)
#     db.commit()
#     db.refresh(db_style)
#     return db_style
#
#
# async def delete_style(style_id: int, db: AsyncSession):
#     db_style = await get_style(style_id, db)
#     db.delete(db_style)
#     db.commit()
#     return db_style
#
#
# # CRUD operations for AdditionalOption
# async def create_additional_option(additional_option: schemas.AdditionalOptionSchema, db: AsyncSession):
#     db_additional_option = models.AdditionalOption(**additional_option.dict())
#     db.add(db_additional_option)
#     db.commit()
#     db.refresh(db_additional_option)
#     return db_additional_option
#
#
# async def get_additional_option(additional_option_id: int, db: AsyncSession):
#     result = await db.execute(
#         select(models.AdditionalOption).filter(models.AdditionalOption.id == additional_option_id))
#     additional_option = result.scalars().first()
#     if additional_option is None:
#         raise HTTPException(status_code=404, detail="Additional option not found")
#     return additional_option
#
#
# async def get_all_additional_options(db: AsyncSession):
#     result = db.execute(select(models.AdditionalOption))
#     return result.scalars().all()
#
#
# async def update_additional_option(additional_option_id: int, additional_option: schemas.AdditionalOptionSchema,
#                                    db: AsyncSession):
#     db_additional_option = await get_additional_option(additional_option_id, db)
#     for key, value in additional_option.dict().items():
#         setattr(db_additional_option, key, value)
#     db.commit()
#     db.refresh(db_additional_option)
#     return db_additional_option
#
#
# async def delete_additional_option(additional_option_id: int, db: AsyncSession):
#     db_additional_option = await get_additional_option(additional_option_id, db)
#     db.delete(db_additional_option)
#     db.commit()
#     return db_additional_option
#
#
# # CRUD operations for FlatAdditionalOption
# async def create_flat_additional_option(flat_additional_option: schemas.FlatAdditionalOptionSchema, db: AsyncSession):
#     db_flat_additional_option = models.FlatAdditionalOption(**flat_additional_option.dict())
#     db.add(db_flat_additional_option)
#     db.commit()
#     db.refresh(db_flat_additional_option)
#     return db_flat_additional_option
#
#
# async def get_flat_additional_option(flat_id: int, additional_option_id: int, db: AsyncSession):
#     result = await db.execute(select(models.FlatAdditionalOption).filter(
#         models.FlatAdditionalOption.flat_id == flat_id,
#         models.FlatAdditionalOption.additional_option_id == additional_option_id
#     ))
#     flat_additional_option = result.scalars().first()
#     if flat_additional_option is None:
#         raise HTTPException(status_code=404, detail="Flat additional option not found")
#     return flat_additional_option
#
#
# async def get_all_flat_additional_options(db: AsyncSession):
#     result = db.execute(select(models.FlatAdditionalOption))
#     return result.scalars().all()
#
#
# async def update_flat_additional_option(flat_id: int, additional_option_id: int,
#                                         flat_additional_option: schemas.FlatAdditionalOptionSchema, db: AsyncSession):
#     db_flat_additional_option = await get_flat_additional_option(flat_id, additional_option_id, db)
#     for key, value in flat_additional_option.dict().items():
#         setattr(db_flat_additional_option, key, value)
#     db.commit()
#     db.refresh(db_flat_additional_option)
#     return db_flat_additional_option
#
#
# async def delete_flat_additional_option(flat_id: int, additional_option_id: int, db: AsyncSession):
#     db_flat_additional_option = await get_flat_additional_option(flat_id, additional_option_id, db)
#     db.delete(db_flat_additional_option)
#     db.commit()
#     return db_flat_additional_option
#
#
# # CRUD operations for Work
# async def create_work(work: schemas.WorkSchema, db: AsyncSession):
#     db_work = models.Work(**work.dict())
#     db.add(db_work)
#     db.commit()
#     db.refresh(db_work)
#     return db_work
#
#
# async def get_work(work_id: int, db: AsyncSession):
#     result = await db.execute(select(models.Work).filter(models.Work.id == work_id))
#     work = result.scalars().first()
#     if work is None:
#         raise HTTPException(status_code=404, detail="Work not found")
#     return work
#
#
# async def get_all_works(project_type: Optional[str], db: AsyncSession):
#     project_types = db.query(models.ProjectType.name).all()
#     if project_type and project_type not in [x[0].lower() for x in project_types]:
#         raise HTTPException(status_code=400, detail="Invalid project types")
#
#     if project_type == 'all' or not project_type:
#         result = db.execute(select(models.Work))
#     else:
#         result = db.execute(select(models.Work).filter(models.Work.project_type == project_type))
#
#     return result.scalars().all()
#
#
# async def update_work(work_id: int, work: schemas.WorkSchema, db: AsyncSession):
#     db_work = await get_work(work_id, db)
#     for key, value in work.dict().items():
#         setattr(db_work, key, value)
#     db.commit()
#     db.refresh(db_work)
#     return db_work
#
#
# async def delete_work(work_id: int, db: AsyncSession):
#     db_work = await get_work(work_id, db)
#     db.delete(db_work)
#     db.commit()
#     return db_work
#
#
# # CRUD operations for Post
# async def create_post(post: schemas.PostSchema, db: AsyncSession):
#     db_post = models.Post(**post.dict())
#     db.add(db_post)
#     db.commit()
#     db.refresh(db_post)
#     return db_post
#
#
# async def get_post(post_id: int, db: AsyncSession):
#     result = await db.execute(select(models.Post).filter(models.Post.id == post_id))
#     post = result.scalars().first()
#     if post is None:
#         raise HTTPException(status_code=404, detail="Post not found")
#     return post
#
#
# async def get_all_posts(db: AsyncSession):
#     result = db.execute(select(models.Post))
#     return result.scalars().all()
#
#
# async def update_post(post_id: int, post: schemas.PostSchema, db: AsyncSession):
#     db_post = await get_post(post_id, db)
#     for key, value in post.dict().items():
#         setattr(db_post, key, value)
#     db.commit()
#     db.refresh(db_post)
#     return db_post
#
#
# async def delete_post(post_id: int, db: AsyncSession):
#     db_post = await get_post(post_id, db)
#     db.delete(db_post)
#     db.commit()
#     return db_post
#
#
# # CRUD operations for Contract
# async def create_contract(contract: schemas.ContractSchema, db: AsyncSession):
#     db_contract = models.Contract(**contract.dict())
#     db.add(db_contract)
#     db.commit()
#     db.refresh(db_contract)
#     return db_contract
#
#
# async def get_contract(contract_id: int, db: AsyncSession):
#     result = await db.execute(select(models.Contract).filter(models.Contract.id == contract_id))
#     contract = result.scalars().first()
#     if contract is None:
#         raise HTTPException(status_code=404, detail="Contract not found")
#     return contract
#
#
# async def get_all_contracts(db: AsyncSession):
#     result = db.execute(select(models.Contract))
#     return result.scalars().all()
#
#
# async def update_contract(contract_id: int, contract: schemas.ContractSchema, db: AsyncSession):
#     db_contract = await get_contract(contract_id, db)
#     for key, value in contract.dict().items():
#         setattr(db_contract, key, value)
#     db.commit()
#     db.refresh(db_contract)
#     return db_contract
#
#
# async def delete_contract(contract_id: int, db: AsyncSession):
#     db_contract = await get_contract(contract_id, db)
#     db.delete(db_contract)
#     db.commit()
#     return db_contract
#
#
# # CRUD operations for WorkStatus
# async def create_work_status(work_status: schemas.WorkStatusSchema, db: AsyncSession):
#     db_work_status = models.WorkStatus(**work_status.dict())
#     db.add(db_work_status)
#     db.commit()
#     db.refresh(db_work_status)
#     return db_work_status
#
#
# async def get_work_status(work_status_id: int, db: AsyncSession):
#     result = await db.execute(select(models.WorkStatus).filter(models.WorkStatus.id == work_status_id))
#     work_status = result.scalars().first()
#     if work_status is None:
#         raise HTTPException(status_code=404, detail="Work status not found")
#     return work_status
#
#
# async def get_all_work_statuses(db: AsyncSession):
#     result = db.execute(select(models.WorkStatus))
#     return result.scalars().all()
#
#
# async def update_work_status(work_status_id: int, work_status: schemas.WorkStatusSchema, db: AsyncSession):
#     db_work_status = await get_work_status(work_status_id, db)
#     for key, value in work_status.dict().items():
#         setattr(db_work_status, key, value)
#     db.commit()
#     db.refresh(db_work_status)
#     return db_work_status
#
#
# async def delete_work_status(work_status_id: int, db: AsyncSession):
#     db_work_status = await get_work_status(work_status_id, db)
#     db.delete(db_work_status)
#     db.commit()
#     return db_work_status
#
#
# # CRUD operations for User
# def get_user_by_email(db: Session, email: str):
#     return db.query(models.User).filter(models.User.email == email).first()
#
#
# def create_user(user: schemas.UserSchema, db: Session):
#     hashed_password = get_password_hash(user.password)
#     db_user = models.User(email=user.email, hashed_password=hashed_password)
#     db.add(db_user)
#     db.commit()
#     db.refresh(db_user)
#     return db_user
#
#
# # CRUD operations for Flat
#
#
# async def get_tariffs(db: AsyncSession):
#     result = await db.execute(select(models.Tariff))
#     return result.scalars().all()
#
#
# async def get_styles(db: AsyncSession):
#     result = await db.execute(select(models.Style))
#     return result.scalars().all()
#
#
# async def get_additional_options(db: AsyncSession):
#     result = await db.execute(select(models.AdditionalOption))
#     return result.scalars().all()
