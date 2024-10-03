from pydantic import BaseModel, EmailStr, Field
from typing import List, Optional
from enum import Enum
import random
import string


class Token(BaseModel):
    access_token: str
    token_type: str


class UserResponse(BaseModel):
    id: int
    email: str

    class Config:
        orm_mode = True


# Enum Classes
class PostTypeEnum(str, Enum):
    news = 'Новость'
    blog = 'Блог'


class TariffTypeEnum(str, Enum):
    base = 'Базовый'
    standard = 'Стандартный'
    comfort = 'Комфорт'
    business = 'Бизнес'


class OrderTypeEnum(str, Enum):
    renovation = 'Ремонт'
    building = 'Строительство'


class ContractNotificationStatusEnum(str, Enum):
    sign_act = 'Подписать акт'
    message = 'Сообщение'


class ProjectTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True


class UserTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True


class NotificationTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True


class ArticleSchema(BaseModel):
    title: str
    body: str

    class Config:
        orm_mode = True


class PortfolioPostSchema(BaseModel):
    id: int
    title: str
    deadline: str
    cost: int
    square: int
    video_link: str
    video_duration: int
    project_type: ProjectTypeSchema
    images: Optional[List[str]]
    articles: Optional[List[ArticleSchema]]

    class Config:
        orm_mode = True


class PostSchema(BaseModel):
    id: int
    title: str
    post_type: PostTypeEnum
    pictures: Optional[List[str]]
    articles: Optional[List[ArticleSchema]]

    class Config:
        orm_mode = True


class BlogBulletSchema(BaseModel):
    id: int
    project_type: ProjectTypeSchema
    title: str
    link: str

    class Config:
        orm_mode = True


class MyContractsSchema(BaseModel):
    id: int
    object: str
    tariff: TariffTypeEnum
    location: str
    reward: int
    status: str
    link: str

    class Config:
        orm_mode = True


class OrderInfoSchema(BaseModel):
    id: int
    object: str
    type: OrderTypeEnum
    tarrif: TariffTypeEnum
    area: int
    location: str

    class Config:
        orm_mode = True


class WorkStateSchema(BaseModel):
    id: int
    title: str
    status: bool
    document: Optional[bytes]

    class Config:
        orm_mode = True


class WorkStatusSchema(BaseModel):
    id: int
    states: List[WorkStateSchema]

    class Config:
        orm_mode = True


class EstimateSchema(BaseModel):
    id: int
    total: int
    materials: int
    job: int
    reward: int
    document: Optional[str]

    class Config:
        orm_mode = True


class ProfileInfoSchema(BaseModel):
    id: int
    name: str
    surname: str
    patronymic: str
    phone: str
    email: EmailStr
    role: UserTypeSchema
    avatar: str
    passport_status: bool

    class Config:
        orm_mode = True


class OrderClientInfoSchema(BaseModel):
    id: int
    client: UserResponse

    class Config:
        orm_mode = True

# class FAQSchema(BaseModel):
#     title: str
#     label: str
#
#     class Config:
#         orm_mode = True
#
#
# class UserSchema(BaseModel):
#     email: EmailStr
#     name: Optional[str]
#     surname: Optional[str]
#     patronymic: Optional[str]
#     password: str
#     phone: Optional[str]
#     user_type_id: int
#     user_referral_code: str = Field(default_factory=lambda: ''.join(
#         random.choices(string.ascii_uppercase + string.digits, k=16)))
#     others_referral_code: Optional[str]
#     notification_status_id: int
#     is_verified: bool = False
#     is_superuser: bool = False
#     avatar: Optional[str]
#
#     class Config:
#         orm_mode = True
#
#
# class NotificationSchema(BaseModel):
#     notification_status: ContractNotificationStatusEnum
#     title: str
#     date: Optional[str]
#     attachment: Optional[bytes]
#     contract_id: int
#     user_id: int
#
#     class Config:
#         orm_mode = True
#
#
# class PlatformNewsSchema(BaseModel):
#     title: str
#     date: str
#     label: str
#
#     class Config:
#         orm_mode = True
#
#
# class FlatSchema(BaseModel):
#     square: int
#     address: str
#     number_of_rooms: int
#     number_of_doors: int
#     number_of_wc: int
#     demolition: bool = False
#     wall_build: bool = False
#     liquid_floor: bool = False
#     ceiling_stretching: bool = False
#     tariff_id: int
#     style_id: int
#
#     class Config:
#         orm_mode = True
#
#
# class StyleSchema(BaseModel):
#     name: str
#     description: Optional[str]
#
#     class Config:
#         orm_mode = True
#
#
# class AdditionalOptionSchema(BaseModel):
#     name: str
#     description: Optional[str]
#
#     class Config:
#         orm_mode = True
#
#
# class FlatAdditionalOptionSchema(BaseModel):
#     flat_id: int
#     additional_option_id: int
#
#     class Config:
#         orm_mode = True
