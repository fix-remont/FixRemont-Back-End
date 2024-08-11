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


from pydantic import BaseModel
from typing import Optional
import uuid


class ClientCreate(BaseModel):
    object: str
    tariff: str
    location: str
    rate: int
    current_stage: str


class ClientUpdate(BaseModel):
    object: Optional[str] = None
    tariff: Optional[str] = None
    location: Optional[str] = None
    rate: Optional[int] = None
    current_stage: Optional[str] = None


class ContractCreate(BaseModel):
    object: str
    tariff: str
    location: str
    total_cost: int
    current_stage: str


class ContractUpdate(BaseModel):
    object: Optional[str] = None
    tariff: Optional[str] = None
    location: Optional[str] = None
    total_cost: Optional[int] = None
    current_stage: Optional[str] = None
