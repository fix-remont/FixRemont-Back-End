from sqlalchemy import create_engine, Column, Integer, String, Enum, ARRAY, ForeignKey, Boolean
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from passlib.context import CryptContext
from typing import Any, List
import random
import string
from src.database.enums import ProjectType, PostType, UserType, NotificationType

Base = declarative_base()
pwd_context = CryptContext(schemes=["bcrypt", "argon2", "pbkdf2_sha256"], deprecated="auto")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


class Work(Base):
    __tablename__ = 'works'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    project_type: ProjectType = Column(Enum(ProjectType))
    deadline = Column(Integer)
    cost = Column(Integer)
    square = Column(Integer)
    task = Column(String)
    description = Column(ARRAY(String))
    images = Column(ARRAY(String))


class Post(Base):
    __tablename__ = 'posts'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    post_type = Column(Enum(PostType))
    content = Column(ARRAY(String))
    images = Column(ARRAY(String))


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    name = Column(String)
    surname = Column(String)
    phone = Column(String)
    user_type = Column(Enum(UserType))
    user_referral_code = Column(String, unique=True, default=lambda: ''.join(
        random.choices(string.ascii_uppercase + string.digits, k=16)))
    others_referral_code = Column(String)
    notification_status = Column(Enum(NotificationType))
    is_active = Column(Boolean, default=True)
    is_superuser = Column(Boolean, default=False)
    clients = relationship("Client", back_populates="user")
    contracts = relationship("Contract", back_populates="user")


class Client(Base):
    __tablename__ = "clients"
    id = Column(Integer, primary_key=True, index=True)
    object = Column(String, nullable=False)
    tariff = Column(String, nullable=False)
    location = Column(String, nullable=False)
    rate = Column(Integer, nullable=False)
    current_stage = Column(String, nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    user = relationship("User", back_populates="clients")


class Contract(Base):
    __tablename__ = "contracts"
    id = Column(Integer, primary_key=True, index=True)
    object = Column(String, nullable=False)
    tariff = Column(String, nullable=False)
    location = Column(String, nullable=False)
    total_cost = Column(Integer, nullable=False)
    current_stage = Column(String, nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    user = relationship("User", back_populates="contracts")


engine = create_engine("postgresql+psycopg2://postgres:fixremontadmin@localhost:5432/postgres")
Base.metadata.create_all(engine)
