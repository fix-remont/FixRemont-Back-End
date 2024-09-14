from pydantic import BaseModel, NonNegativeFloat, PositiveInt
from typing import List
from src.database.enums import ProjectType, PostType, NotificationType, UserType, MessageType
from typing import Optional
from pydantic import BaseModel

from src.database.models import LargeBinary


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


class UserCreate(BaseModel):
    email: str
    password: str


class UserResponse(BaseModel):
    id: int
    email: str

    class Config:
        orm_mode = True


# class UserUp


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


class Notification(BaseModel):
    message_type: MessageType
    content: str
    attachment: Optional[bytes]

    class Config:
        orm_mode = True
        arbitrary_types_allowed = True

class NotificationCreate(Notification):
    pass

class NotificationUpdate(Notification):
    pass

# from pydantic import BaseModel
# from typing import List, Optional
# from src.database.enums import PostType
# from src.database.models import Client, Contract, ProjectType, PostType, UserType
#
#
# class PostBase(BaseModel):
#     title: str
#     post_type: PostType
#     content: List[str]
#     images: List[str]
#
#     class Config:
#         orm_mode = True
#         arbitrary_types_allowed = True
#
#
# class PostCreate(PostBase):
#     pass
#
#
# class Post(PostBase):
#     id: Optional[int] = None
#
#
# from pydantic import BaseModel, EmailStr
# from typing import List, Optional
# from src.database.enums import UserType
#
#
# class UserCreate(BaseModel):
#     email: EmailStr
#     password: str
#
#
# class UserResponse(BaseModel):
#     id: int
#     email: EmailStr
#     name: str
#     surname: str
#     user_type: UserType
#     user_referral_code: str
#     others_referral_code: Optional[str]
#     clients: List["Client"]
#     contracts: List["Contract"]
#
#     class Config:
#         orm_mode = True
#         arbitrary_types_allowed = True
#
#
# from pydantic import BaseModel
# from typing import Optional
#
#
# class ClientBase(BaseModel):
#     object: str
#     tariff: str
#     location: str
#     rate: int
#     current_stage: str
#
#     class Config:
#         orm_mode = True
#         arbitrary_types_allowed = True
#
#
# class ClientCreate(ClientBase):
#     pass
#
#
# class ClientUpdate(ClientBase):
#     object: Optional[str] = None
#     tariff: Optional[str] = None
#     location: Optional[str] = None
#     rate: Optional[int] = None
#     current_stage: Optional[str] = None
#
#
# from pydantic import BaseModel
# from typing import Optional
#
#
# class ContractBase(BaseModel):
#     object: str
#     tariff: str
#     location: str
#     total_cost: int
#     current_stage: str
#
#     class Config:
#         orm_mode = True
#         arbitrary_types_allowed = True
#
#
# class ContractCreate(ContractBase):
#     pass
#
#
# class ContractUpdate(ContractBase):
#     object: Optional[str] = None
#     tariff: Optional[str] = None
#     location: Optional[str] = None
#     total_cost: Optional[int] = None
#     current_stage: Optional[str] = None
#
#
# from pydantic import BaseModel
#
#
# class Token(BaseModel):
#     access_token: str
#     token_type: str
#
#
# from pydantic import BaseModel
#
#
# class ReferralCodeInput(BaseModel):
#     user_referral_code: str
#
#
# class Work(BaseModel):
#     title: str
#     project_type: ProjectType
#     deadline: int
#     cost: int
#     square: int
#     task: str
#     description: List[str]
#     images: List[str]
#
#     class Config:
#         orm_mode = True
#         arbitrary_types_allowed = True
#
#
# class WorkCreate(Work):
#     pass
#
#
# class WorkUpdate(Work):
#     title: str
#     project_type: ProjectType
#     deadline: int
#     cost: int
#     square: int
#     task: str
#     description: List[str]
#     images: List[str]
#
#     class Config:
#         orm_mode = True
#         arbitrary_types_allowed = True
