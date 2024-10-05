from fastapi import APIRouter
from typing import List
from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from src.database import cruds, schemas
from src.database.db import get_db
from src.database.schemas import (
    Token, UserResponse, ProjectTypeSchema, UserTypeSchema, NotificationTypeSchema,
    ArticleSchema, PortfolioPostSchema, PostSchema, BlogBulletSchema, MyContractsSchema,
    OrderInfoSchema, WorkStateSchema, WorkStatusSchema, EstimateSchema, ProfileInfoSchema,
    OrderClientInfoSchema, OrderNotificationSchema, OrderDocumentsSchema, ContractsSchema,
    InvitedPartnersSchema, ProfileNotificationSchema, SupportCategorySchema
)

router = APIRouter()


@router.get("/portfolio_posts", response_model=List[PortfolioPostSchema])
async def get_portfolio_posts(db: AsyncSession = Depends(get_db)):
    return await cruds.get_portfolio_posts(db)


@router.post("/portfolio_posts", response_model=PortfolioPostSchema)
async def create_portfolio_post(portfolio_post: PortfolioPostSchema, db: AsyncSession = Depends(get_db)):
    return await cruds.create_portfolio_post(portfolio_post, db)


@router.get("/posts", response_model=List[PostSchema])
async def get_posts():
    return []


@router.get("/blog_bullets", response_model=List[BlogBulletSchema])
async def get_blog_bullets():
    return []


@router.get("/my_contracts", response_model=List[MyContractsSchema])
async def get_my_contracts():
    return []


@router.get("/order_infos", response_model=List[OrderInfoSchema])
async def get_order_infos():
    return []


@router.get("/work_states", response_model=List[WorkStateSchema])
async def get_work_states():
    return []


@router.get("/work_statuses", response_model=List[WorkStatusSchema])
async def get_work_statuses():
    return []


@router.get("/estimates", response_model=List[EstimateSchema])
async def get_estimates():
    return []


@router.get("/profile_infos", response_model=List[ProfileInfoSchema])
async def get_profile_infos():
    return []


@router.get("/order_client_infos", response_model=List[OrderClientInfoSchema])
async def get_order_client_infos():
    return []


@router.get("/order_notifications", response_model=List[OrderNotificationSchema])
async def get_order_notifications():
    return []


@router.get("/order_documents", response_model=List[OrderDocumentsSchema])
async def get_order_documents():
    return []


@router.get("/contracts", response_model=List[ContractsSchema])
async def get_contracts():
    return []


@router.get("/invited_partners", response_model=List[InvitedPartnersSchema])
async def get_invited_partners():
    return []


@router.get("/profile_notifications", response_model=List[ProfileNotificationSchema])
async def get_profile_notifications():
    return []


@router.get("/support_categories", response_model=List[SupportCategorySchema])
async def get_support_categories():
    return []
