from pydantic import BaseModel
from sqlalchemy import create_engine, Column, Integer, String, Enum, ARRAY, ForeignKey, Boolean
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from src.database.schemas import ProjectType, PostType, UserType
from src.database.utils import generate_unique_id
from passlib.context import CryptContext
from typing import Any, List
import random
import string

Base = declarative_base()
pwd_context = CryptContext(schemes=["bcrypt", "argon2", "pbkdf2_sha256"], deprecated="auto")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


class Work(Base):
    __tablename__ = 'works'
    id: int = Column(Integer, primary_key=True, index=True)
    title: str = Column(String, index=True)
    project_type: ProjectType = Column(Enum(ProjectType))
    deadline: int = Column(Integer)
    cost: int = Column(Integer)
    square: int = Column(Integer)
    task: str = Column(String)
    description: List[str] = Column(ARRAY(String))
    images: List[str] = Column(ARRAY(String))


class Post(Base):
    __tablename__ = 'posts'
    id: int = Column(Integer, primary_key=True, index=True)
    title: str = Column(String, index=True)
    post_type: PostType = Column(Enum(PostType))
    content: List[str] = Column(ARRAY(String))
    images: List[str] = Column(ARRAY(String))


#
# class User(Base):
#     __tablename__ = 'users'
#     id: str = Column(String, primary_key=True, default=generate_unique_id)
#     email: str = Column(String, unique=True, nullable=False)
#     user_type: UserType = Column(Enum(UserType, name="usertype"), nullable=False)
#     name: str = Column(String, nullable=False)
#     surname: str = Column(String, nullable=False)
#     phone: str = Column(String, nullable=False)
#     user_referral_code: str = Column(String, unique=True, nullable=False, default=lambda: ''.join(
#         random.choices(string.ascii_uppercase + string.digits, k=16)))
#     others_referral_code: str = Column(String, nullable=True)
#     clients = relationship("Client", back_populates="user")
#     contracts = relationship("Contract", back_populates="user")
#     hashed_password: str = Column(String, nullable=False)
#
#     def __init__(self, **kwargs: Any):
#         super().__init__(**kwargs)
#         if 'password' in kwargs:
#             self.hashed_password = hash_password(kwargs['password'])
#
#     def verify_password(self, password: str) -> bool:
#         return pwd_context.verify(password, self.hashed_password)


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    is_active = Column(Boolean, default=True)
    is_superuser = Column(Boolean, default=False)
    clients = relationship("Client", back_populates="user")
    contracts = relationship("Contract", back_populates="user")


class Client(Base):
    __tablename__ = "clients"
    id: int = Column(Integer, primary_key=True, index=True)
    object: str = Column(String, nullable=False)
    tariff: str = Column(String, nullable=False)
    location: str = Column(String, nullable=False)
    rate: int = Column(Integer, nullable=False)
    current_stage: str = Column(String, nullable=False)
    user_id: str = Column(String, ForeignKey("users.id"))
    user = relationship("User", back_populates="clients")


class Contract(Base):
    __tablename__ = "contracts"
    id: int = Column(Integer, primary_key=True, index=True)
    object: str = Column(String, nullable=False)
    tariff: str = Column(String, nullable=False)
    location: str = Column(String, nullable=False)
    total_cost: int = Column(Integer, nullable=False)
    current_stage: str = Column(String, nullable=False)
    user_id: str = Column(String, ForeignKey("users.id"))
    user = relationship("User", back_populates="contracts")


engine = create_engine("postgresql+psycopg2://postgres:sdr@localhost:5432/postgres")
Base.metadata.create_all(engine)
