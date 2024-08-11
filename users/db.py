from typing import Any, AsyncGenerator

from fastapi import Depends
from fastapi_users.db import SQLAlchemyBaseUserTableUUID, SQLAlchemyUserDatabase
from sqlalchemy import Column, Enum, create_engine, text, String
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.orm import DeclarativeBase
import enum

DATABASE_URL = "postgresql+asyncpg://postgres:sdr@localhost:5432/postgres"

engine = create_async_engine(DATABASE_URL)
async_session_maker = async_sessionmaker(engine, expire_on_commit=False)


class Base(DeclarativeBase):
    pass


class UserType(str, enum.Enum):
    REALTOR = "realtor"
    DEVELOPER = "developer"
    INDIVIDUAL = "individual"


class User(SQLAlchemyBaseUserTableUUID, Base):
    user_type = Column(Enum(UserType, name="usertype"), nullable=False)
    name = Column(String, nullable=False)
    surname = Column(String, nullable=False)
    phone = Column(String, nullable=False)

    def __init__(self, **kwargs: Any):
        super().__init__(**kwargs)


async def create_db_and_tables():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)


async def get_async_session() -> AsyncGenerator[AsyncSession, None]:
    async with async_session_maker() as session:
        yield session


async def get_user_db(session: AsyncSession = Depends(get_async_session)):
    yield SQLAlchemyUserDatabase(session, User)
