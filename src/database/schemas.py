from enum import Enum

from pydantic import BaseModel, EmailStr, NonNegativeFloat, PositiveInt
from typing import Optional, List, NewType


class ProjectType(str, Enum):
    FLAT = "flat"
    HOUSE = "house"


class WorkBase(BaseModel):
    title: str
    project_type: ProjectType
    deadline: PositiveInt
    cost: PositiveInt
    square: NonNegativeFloat
    task: str
    description: List[str]

    class Config:
        orm_mode = True


class WorkCreate(WorkBase):
    pass


class Work(WorkBase):
    pass
