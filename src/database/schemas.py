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
        from_attributes = True


# Enum Classes
class PostTypeEnum(str, Enum):
    news = 'Новость'
    blog = 'Блог'

    class Config:
        orm_mode = True
        from_attributes = True


class TariffTypeEnum(str, Enum):
    base = 'Базовый'
    standard = 'Стандартный'
    comfort = 'Комфорт'
    business = 'Бизнес'

    class Config:
        orm_mode = True
        from_attributes = True


class OrderTypeEnum(str, Enum):
    renovation = 'Ремонт'
    building = 'Строительство'

    class Config:
        orm_mode = True
        from_attributes = True


class ContractNotificationStatusEnum(str, Enum):
    sign_act = 'Подписать акт'
    message = 'Сообщение'

    class Config:
        orm_mode = True
        from_attributes = True


class ProjectTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True
        from_attributes = True


class UserTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True
        from_attributes = True


class NotificationTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True
        from_attributes = True


class ArticleSchema(BaseModel):
    title: str
    body: str

    class Config:
        orm_mode = True
        from_attributes = True


class PortfolioPostSchema(BaseModel):
    id: int
    title: str
    deadline: str
    cost: int
    square: int
    video_link: str
    video_duration: str
    project_type: ProjectTypeSchema
    images: Optional[List[Optional[str]]] = None
    articles: Optional[List[Optional[ArticleSchema]]] = None

    class Config:
        from_attributes = True
        orm_mode = True


class PostSchema(BaseModel):
    id: int
    title: str
    post_type: PostTypeEnum
    pictures: Optional[List[Optional[str]]] = None
    articles: Optional[List[Optional[ArticleSchema]]] = None

    class Config:
        orm_mode = True
        from_attributes = True


class BlogBulletSchema(BaseModel):
    id: int
    project_type: ProjectTypeSchema
    title: str

    class Config:
        orm_mode = True
        from_attributes = True


class MyContractsSchema(BaseModel):
    id: int
    object: str
    tariff: Optional[TariffTypeEnum] = None
    location: str
    reward: Optional[int] = None
    status: Optional[str] = None

    class Config:
        orm_mode = True
        from_attributes = True


class OrderInfoSchema(BaseModel):
    id: int
    object: Optional[str] = None
    type: Optional[OrderTypeEnum] = None
    tariff: Optional[TariffTypeEnum] = None
    area: Optional[int] = None
    location: Optional[str] = None

    class Config:
        orm_mode = True
        from_attributes = True


class WorkStateSchema(BaseModel):
    id: int
    title: str
    status: bool
    current: bool
    document: Optional[bytes]

    class Config:
        orm_mode = True
        from_attributes = True


class WorkStatusSchema(BaseModel):
    id: int
    states: List[WorkStateSchema]

    class Config:
        orm_mode = True
        from_attributes = True


class EstimateSchema(BaseModel):
    id: int
    total: int
    materials: int
    job: int
    reward: int
    document: Optional[str]

    class Config:
        orm_mode = True
        from_attributes = True


class ProfileInfoSchema(BaseModel):
    id: int
    name: Optional[str]
    surname: Optional[str]
    patronymic: Optional[str]
    phone: Optional[str]
    email: EmailStr
    role: Optional[UserTypeSchema]
    avatar: Optional[str]
    passport_status: bool

    class Config:
        orm_mode = True
        from_attributes = True


class OrderClientInfoSchema(BaseModel):
    id: int
    client: ProfileInfoSchema
    date: Optional[str]

    class Config:
        orm_mode = True
        from_attributes = True


class OrderNotificationSchema(BaseModel):
    id: int
    type: ContractNotificationStatusEnum
    title: str
    label: Optional[str]

    class Config:
        orm_mode = True
        from_attributes = True


class OrderDocumentsSchema(BaseModel):
    id: int
    title: str
    label: str
    type: ContractNotificationStatusEnum
    attachment: Optional[bytes]

    class Config:
        orm_mode = True
        from_attributes = True


class ContractsSchema(BaseModel):
    order: OrderInfoSchema
    status: WorkStatusSchema
    stage: str
    reward: int
    user_id: int

    class Config:
        orm_mode = True
        from_attributes = True


class InvitedPartnersSchema(BaseModel):
    id: int
    data: ProfileInfoSchema
    reward: int

    class Config:
        orm_mode = True
        from_attributes = True


class ProfileNotificationSchema(BaseModel):
    id: int
    title: Optional[str]
    date: Optional[str]
    label: Optional[str]

    class Config:
        orm_mode = True
        from_attributes = True


class SupportCategorySchema(BaseModel):
    heading: Optional[str]
    date: Optional[str]
    key_word: Optional[str]

    class Config:
        orm_mode = True
        from_attributes = True


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
class UserSchema(BaseModel):
    email: EmailStr
    name: Optional[str] = None
    surname: Optional[str] = None
    patronymic: Optional[str] = None
    hashed_password: str
    phone: Optional[str] = None
    user_type_id: Optional[int] = None
    user_referral_code: str = Field(default_factory=lambda: ''.join(
        random.choices(string.ascii_uppercase + string.digits, k=16)))
    others_referral_code: Optional[str] = None
    notification_status_id: Optional[int] = None
    is_verified: bool = False
    is_superuser: bool = False
    avatar: Optional[str] = None

    class Config:
        orm_mode = True

class UserRegistrationSchema(BaseModel):
    email: EmailStr
    hashed_password: str
    class Config:
        orm_mode = True