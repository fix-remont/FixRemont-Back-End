from sqlalchemy import Column, Integer, String, Float
from sqlalchemy.dialects.postgresql import ARRAY

from .database import Base
from sqlalchemy import Column, Integer, String, Float, ForeignKey, Enum as SQLAEnum
from sqlalchemy.orm import relationship
from .database import Base
from src.database.schemas import ProjectType
from sqlalchemy import LargeBinary


class Work(Base):
    __tablename__ = "works"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    project_type = Column(SQLAEnum(ProjectType))
    deadline = Column(Integer)
    cost = Column(Integer)
    square = Column(Float)
    task = Column(String)
    description = Column(ARRAY(String))
    images = Column(ARRAY(LargeBinary))
