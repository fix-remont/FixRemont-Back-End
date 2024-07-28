from sqlalchemy import Column, Integer, String, Float
from sqlalchemy.dialects.postgresql import ARRAY

from .database import Base


from sqlalchemy import LargeBinary

class Work(Base):
    __tablename__ = "works"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    deadline = Column(Integer)
    cost = Column(Integer)
    square = Column(Float)
    task = Column(String)
    description = Column(ARRAY(String))
    image = Column(LargeBinary)  # New column for storing image data