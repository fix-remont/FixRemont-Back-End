from sqlalchemy import create_engine, Column, Integer, String, Enum, ARRAY, ForeignKey, Boolean, LargeBinary
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from passlib.context import CryptContext
from typing import Any, List
import random
import string

Base = declarative_base()
pwd_context = CryptContext(schemes=["bcrypt", "argon2", "pbkdf2_sha256"], deprecated="auto")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


class ProjectType(Base):
    __tablename__ = 'project_type'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    works = relationship("Work", back_populates="project_type")

    def __str__(self):
        return self.name


class PostType(Base):
    __tablename__ = 'post_type'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    posts = relationship("Post", back_populates="post_type")

    def __str__(self):
        return self.name


class UserType(Base):
    __tablename__ = 'user_type'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    users = relationship("User", back_populates="user_type")

    def __str__(self):
        return self.name


class NotificationType(Base):
    __tablename__ = 'notification_type'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    users = relationship("User", back_populates="notification_status")

    def __str__(self):
        return self.name


class MessageType(Base):
    __tablename__ = 'message_type'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    notifications = relationship("Notification", back_populates="message_type")

    def __str__(self):
        return self.name


class Work(Base):
    __tablename__ = 'works'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    project_type_id = Column(Integer, ForeignKey('project_type.id'))
    project_type = relationship("ProjectType", back_populates="works")
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
    post_type_id = Column(Integer, ForeignKey('post_type.id'))
    post_type = relationship("PostType", back_populates="posts")
    content = Column(ARRAY(String))
    images = Column(ARRAY(String))


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    name = Column(String)
    surname = Column(String)
    phone = Column(String)
    user_type_id = Column(Integer, ForeignKey('user_type.id'))
    user_type = relationship("UserType", back_populates="users")
    user_referral_code = Column(String, unique=True, default=lambda: ''.join(
        random.choices(string.ascii_uppercase + string.digits, k=16)))
    others_referral_code = Column(String)
    notification_status_id = Column(Integer, ForeignKey('notification_type.id'))
    notification_status = relationship("NotificationType", back_populates="users")
    is_active = Column(Boolean, default=True)
    is_superuser = Column(Boolean, default=False)
    clients = relationship("Client", back_populates="user")
    contracts = relationship("Contract", back_populates="user")
    notifications = relationship("Notification", back_populates="user")

    def __str__(self):
        return self.email


class Client(Base):
    __tablename__ = "clients"
    id = Column(Integer, primary_key=True, index=True)
    object = Column(String, nullable=False)
    tariff = Column(String, nullable=False)
    location = Column(String, nullable=False)
    rate = Column(Integer, nullable=False)
    current_stage = Column(String, nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    user = relationship("User", back_populates="clients")

    def __str__(self):
        return self.object


class Contract(Base):
    __tablename__ = "contracts"
    id = Column(Integer, primary_key=True, index=True)
    object = Column(String, nullable=False)
    tariff = Column(String, nullable=False)
    location = Column(String, nullable=False)
    total_cost = Column(Integer, nullable=False)
    current_stage = Column(String, nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    user = relationship("User", back_populates="contracts")


class Notification(Base):
    __tablename__ = "notifications"
    id = Column(Integer, primary_key=True, index=True)
    message_type_id = Column(Integer, ForeignKey('message_type.id'))
    message_type = relationship("MessageType", back_populates="notifications")
    content = Column(String, nullable=False)
    attachment = Column(LargeBinary)
    user_id = Column(Integer, ForeignKey("users.id"))
    user = relationship("User", back_populates="notifications")

    def __str__(self):
        return f'{self.message_type.value}: {self.content}'


class Flat(Base):
    __tablename__ = 'flats'
    id = Column(Integer, primary_key=True, index=True)
    square = Column(Integer, nullable=False)
    address = Column(String, nullable=False)
    number_of_rooms = Column(Integer, nullable=False)
    number_of_doors = Column(Integer, nullable=False)
    number_of_wc = Column(Integer, nullable=False)
    demolition = Column(Boolean, default=False)
    wall_build = Column(Boolean, default=False)
    liquid_floor = Column(Boolean, default=False)
    ceiling_stretching = Column(Boolean, default=False)
    tariff_id = Column(Integer, ForeignKey('tariffs.id'))
    style_id = Column(Integer, ForeignKey('styles.id'))
    additional_options = relationship('AdditionalOption', secondary='flat_additional_options')


class Tariff(Base):
    __tablename__ = 'tariffs'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String)


class Style(Base):
    __tablename__ = 'styles'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String)


class AdditionalOption(Base):
    __tablename__ = 'additional_options'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String)


class FlatAdditionalOption(Base):
    __tablename__ = 'flat_additional_options'
    flat_id = Column(Integer, ForeignKey('flats.id'), primary_key=True)
    additional_option_id = Column(Integer, ForeignKey('additional_options.id'), primary_key=True)


engine = create_engine("postgresql+psycopg2://postgres:fixremontadmin@localhost:5432/postgres")
Base.metadata.create_all(engine)
