from enum import Enum

from pydantic import BaseModel, EmailStr, NonNegativeFloat, PositiveInt
from typing import Optional, List, NewType


class ProjectType(str, Enum):
    FLAT = "flat"
    HOUSE = "house"


class PostType(str, Enum):
    FLAT_RENOVATION = "flat_renovation"
    HOUSE_BUILDING = "house_building"
    NEWS = "news"


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
