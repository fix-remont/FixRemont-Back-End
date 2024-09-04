from sqlalchemy import create_engine, Column, Integer, String, Enum, ARRAY
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from src.database.schemas import ProjectType, PostType

Base = declarative_base()


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
    images = Column(ARRAY(String))


class Post(Base):
    __tablename__ = 'posts'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    post_type = Column(Enum(PostType))
    content = Column(ARRAY(String))
    images = Column(ARRAY(String))


engine = create_engine("postgresql+psycopg2://postgres:sdr@localhost:5432/postgres")
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)
session = Session()
session.commit()
session.close()
