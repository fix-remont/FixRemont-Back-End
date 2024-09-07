from contextlib import asynccontextmanager
from typing import Any, AsyncGenerator
from passlib.context import CryptContext
from fastapi import Depends
from fastapi_users.db import SQLAlchemyBaseUserTableUUID, SQLAlchemyUserDatabase
from sqlalchemy import Column, Enum, create_engine, text, String, Integer, ForeignKey
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.orm import DeclarativeBase, relationship
import enum
import random
import string
from sqlalchemy.dialects.postgresql import UUID

DATABASE_URL = "postgresql+asyncpg://postgres:sdr@localhost:5432/postgres"

engine = create_async_engine(DATABASE_URL)
async_session_maker = async_sessionmaker(engine, expire_on_commit=False)


class Base(DeclarativeBase):
    pass


class UserType(str, enum.Enum):
    REALTOR = "realtor"
    DEVELOPER = "developer"
    INDIVIDUAL = "individual"


pwd_context = CryptContext(schemes=["bcrypt", "argon2", "pbkdf2_sha256"], deprecated="auto")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


class User(SQLAlchemyBaseUserTableUUID, Base):
    user_type = Column(Enum(UserType, name="usertype"), nullable=False)
    name = Column(String, nullable=False)
    surname = Column(String, nullable=False)
    phone = Column(String, nullable=False)
    user_referral_code = Column(String, unique=True, nullable=False,
                                default=lambda: ''.join(random.choices(string.ascii_uppercase + string.digits, k=16)))
    others_referral_code = Column(String, nullable=True)
    clients = relationship("Client", back_populates="user")
    contracts = relationship("Contract", back_populates="user")
    hashed_password = Column(String, nullable=False)

    def __init__(self, **kwargs: Any):
        super().__init__(**kwargs)
        if 'password' in kwargs:
            self.hashed_password = hash_password(kwargs['password'])

    def verify_password(self, password: str) -> bool:
        return pwd_context.verify(password, self.hashed_password)


class Client(Base):
    __tablename__ = "clients"
    id = Column(Integer, primary_key=True, index=True)
    object = Column(String, nullable=False)
    tariff = Column(String, nullable=False)
    location = Column(String, nullable=False)
    rate = Column(Integer, nullable=False)
    current_stage = Column(String, nullable=False)
    user_id = Column(UUID(as_uuid=True), ForeignKey("user.id"))
    user = relationship("User", back_populates="clients")


class Contract(Base):
    __tablename__ = "contracts"
    id = Column(Integer, primary_key=True, index=True)
    object = Column(String, nullable=False)
    tariff = Column(String, nullable=False)
    location = Column(String, nullable=False)
    total_cost = Column(Integer, nullable=False)
    current_stage = Column(String, nullable=False)
    user_id = Column(UUID(as_uuid=True), ForeignKey("user.id"))
    user = relationship("User", back_populates="contracts")


async def create_db_and_tables():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)


@asynccontextmanager
async def get_async_session() -> AsyncGenerator[AsyncSession, None]:
    async with async_session_maker() as session:
        yield session


async def get_user_db(session: AsyncSession = Depends(get_async_session)):
    yield SQLAlchemyUserDatabase(session, User)
