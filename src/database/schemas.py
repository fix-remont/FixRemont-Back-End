from pydantic import BaseModel, EmailStr, NonNegativeFloat, PositiveInt
from typing import Optional, List


class WorkBase(BaseModel):
    title: str
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
