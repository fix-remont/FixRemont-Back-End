from enum import Enum

from pydantic import BaseModel, NonNegativeFloat, PositiveInt
from typing import List
import uuid
from pydantic import BaseModel, EmailStr
from typing import Optional
import enum
from pydantic import BaseModel
from typing import Optional
import uuid
from pydantic import BaseModel


class ProjectType(str, Enum):
    FLAT = "flat"
    HOUSE = "house"


class PostType(str, Enum):
    FLAT_RENOVATION = "flat_renovation"
    HOUSE_BUILDING = "house_building"
    NEWS = "news"


class UserType(str, Enum):
    REALTOR = "realtor"
    DEVELOPER = "developer"
    INDIVIDUAL = "individual"


class WorkBase(BaseModel):
    title: str
    project_type: ProjectType
    deadline: PositiveInt
    cost: PositiveInt
    square: NonNegativeFloat
    task: str
    description: List[str]
    images: List[str]

    class Config:
        orm_mode = True


class WorkCreate(WorkBase):
    pass


class Work(WorkBase):
    pass


class PostBase(BaseModel):
    title: str
    post_type: PostType
    content: List[str]
    images: List[str]

    class Config:
        orm_mode = True


class PostCreate(PostBase):
    pass


class Post(PostBase):
    pass


# src/database/schemas.py
from pydantic import BaseModel, EmailStr
from typing import Optional
from enum import Enum

# schemas.py
from pydantic import BaseModel


class UserCreate(BaseModel):
    username: str
    email: str
    password: str


class UserResponse(BaseModel):
    id: int
    username: str
    email: str

    class Config:
        orm_mode = True


class Token(BaseModel):
    access_token: str
    token_type: str


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


class ReferralCodeInput(BaseModel):
    user_referral_code: str
