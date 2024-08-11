import uuid
from fastapi_users import schemas
from pydantic import BaseModel
from typing import Optional
import enum


class UserType(str, enum.Enum):
    REALTOR = "realtor"
    DEVELOPER = "developer"
    INDIVIDUAL = "individual"


class UserRead(schemas.BaseUser[uuid.UUID]):
    user_type: UserType
    name: str
    surname: str
    phone: str


class UserCreate(schemas.BaseUserCreate):
    user_type: UserType
    name: str
    surname: str
    phone: str


class UserUpdate(schemas.BaseUserUpdate):
    user_type: Optional[UserType] = None
    name: Optional[str] = None
    surname: Optional[str] = None
    phone: Optional[str] = None
