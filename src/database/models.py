from sqlalchemy import Column, Integer, String, Enum, ARRAY, LargeBinary
from src.database.db import Base
from src.database.schemas import ProjectType, PostType


class Work(Base):
    __tablename__ = 'works'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    project_type = Column(Enum(ProjectType))
    deadline = Column(Integer)
    cost = Column(Integer)
    square = Column(Integer)
    task = Column(String)
    description = Column(ARRAY(String))
    images = Column(ARRAY(LargeBinary))


class Post(Base):
    __tablename__ = 'posts'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    post_type = Column(Enum(PostType))
    content = Column(ARRAY(String))
    images = Column(ARRAY(LargeBinary))
