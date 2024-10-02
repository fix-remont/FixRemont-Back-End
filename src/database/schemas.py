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


# Pydantic Schemas
class ProjectTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True


class ProjectTypeCreate(ProjectTypeSchema):
    pass


class ProjectTypeUpdate(ProjectTypeSchema):
    pass


class ProjectTypeDelete(ProjectTypeSchema):
    pass


class UserTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True


class UserTypeCreate(UserTypeSchema):
    pass


class UserTypeUpdate(UserTypeSchema):
    pass


class UserTypeDelete(UserTypeSchema):
    pass


class NotificationTypeSchema(BaseModel):
    name: str

    class Config:
        orm_mode = True


class NotificationTypeCreate(NotificationTypeSchema):
    pass


class NotificationTypeUpdate(NotificationTypeSchema):
    pass


class NotificationTypeDelete(NotificationTypeSchema):
    pass


class WorkSchema(BaseModel):
    title: str
    project_type_id: int
    deadline: Optional[str]
    cost: Optional[int]
    square: Optional[int]
    task: Optional[str]
    description: Optional[List[str]]
    image1: Optional[str]
    image2: Optional[str]
    image3: Optional[str]
    image4: Optional[str]
    image5: Optional[str]
    video_link: Optional[str]
    video_duration: Optional[str]

    class Config:
        orm_mode = True


class WorkCreate(WorkSchema):
    pass


class WorkUpdate(WorkSchema):
    pass


class WorkDelete(WorkSchema):
    pass


class ParagraphSchema(BaseModel):
    title: str
    body: str
    post_id: int

    class Config:
        orm_mode = True


class ParagraphCreate(ParagraphSchema):
    pass


class ParagraphUpdate(ParagraphSchema):
    pass


class ParagraphDelete(ParagraphSchema):
    pass


class PostSchema(BaseModel):
    title: str
    post_type: PostTypeEnum
    paragraphs: List[ParagraphSchema] = []
    image1: Optional[str]
    image2: Optional[str]
    image3: Optional[str]

    class Config:
        orm_mode = True


class PostCreate(PostSchema):
    pass


class PostUpdate(PostSchema):
    pass


class PostDelete(PostSchema):
    pass


class FAQSchema(BaseModel):
    title: str
    label: str

    class Config:
        orm_mode = True


class FAQCreate(FAQSchema):
    pass


class FAQUpdate(FAQSchema):
    pass


class FAQDelete(FAQSchema):
    pass


class UserSchema(BaseModel):
    email: EmailStr
    name: Optional[str]
    surname: Optional[str]
    patronymic: Optional[str]
    phone: Optional[str]
    user_type_id: int
    user_referral_code: str = Field(default_factory=lambda: ''.join(
        random.choices(string.ascii_uppercase + string.digits, k=16)))
    others_referral_code: Optional[str]
    notification_status_id: int
    is_verified: bool = False
    is_superuser: bool = False
    avatar: Optional[str]

    class Config:
        orm_mode = True


class UserCreate(UserSchema):
    pass


class UserUpdate(UserSchema):
    pass


class UserDelete(UserSchema):
    pass


class WorkStatusSchema(BaseModel):
    title: str
    document: Optional[bytes]
    status: bool
    contract_id: int

    class Config:
        orm_mode = True


class WorkStatusCreate(WorkStatusSchema):
    pass


class WorkStatusUpdate(WorkStatusSchema):
    pass


class WorkStatusDelete(WorkStatusSchema):
    pass


class ContractSchema(BaseModel):
    object: str
    order_type: OrderTypeEnum
    tariff_type: TariffTypeEnum
    square: int
    location: str
    current_stage: str
    total_cost: int
    materials_cost: int
    work_cost: int
    revenue: int
    client_id: int
    date: str

    class Config:
        orm_mode = True


class ContractCreate(ContractSchema):
    pass


class ContractUpdate(ContractSchema):
    pass


class ContractDelete(ContractSchema):
    pass


class NotificationSchema(BaseModel):
    notification_status: ContractNotificationStatusEnum
    title: str
    date: Optional[str]
    attachment: Optional[bytes]
    contract_id: int
    user_id: int

    class Config:
        orm_mode = True


class NotificationCreate(NotificationSchema):
    pass


class NotificationUpdate(NotificationSchema):
    pass


class NotificationDelete(NotificationSchema):
    pass


class PlatformNewsSchema(BaseModel):
    title: str
    date: str
    label: str

    class Config:
        orm_mode = True


class PlatformNewsCreate(PlatformNewsSchema):
    pass


class PlatformNewsUpdate(PlatformNewsSchema):
    pass


class PlatformNewsDelete(PlatformNewsSchema):
    pass


class FlatSchema(BaseModel):
    square: int
    address: str
    number_of_rooms: int
    number_of_doors: int
    number_of_wc: int
    demolition: bool = False
    wall_build: bool = False
    liquid_floor: bool = False
    ceiling_stretching: bool = False
    tariff_id: int
    style_id: int

    class Config:
        orm_mode = True


class FlatCreate(FlatSchema):
    pass


class FlatUpdate(FlatSchema):
    pass


class FlatDelete(FlatSchema):
    pass


class TariffSchema(BaseModel):
    name: str
    description: Optional[str]

    class Config:
        orm_mode = True


class TariffCreate(TariffSchema):
    pass


class TariffUpdate(TariffSchema):
    pass


class TariffDelete(TariffSchema):
    pass


class StyleSchema(BaseModel):
    name: str
    description: Optional[str]

    class Config:
        orm_mode = True


class StyleCreate(StyleSchema):
    pass


class StyleUpdate(StyleSchema):
    pass


class StyleDelete(StyleSchema):
    pass


class AdditionalOptionSchema(BaseModel):
    name: str
    description: Optional[str]

    class Config:
        orm_mode = True


class AdditionalOptionCreate(AdditionalOptionSchema):
    pass


class AdditionalOptionUpdate(AdditionalOptionSchema):
    pass


class AdditionalOptionDelete(AdditionalOptionSchema):
    pass


class FlatAdditionalOptionSchema(BaseModel):
    flat_id: int
    additional_option_id: int

    class Config:
        orm_mode = True


class FlatAdditionalOptionCreate(FlatAdditionalOptionSchema):
    pass


class FlatAdditionalOptionUpdate(FlatAdditionalOptionSchema):
    pass


class FlatAdditionalOptionDelete(FlatAdditionalOptionSchema):
    pass
