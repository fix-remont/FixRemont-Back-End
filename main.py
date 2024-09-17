from asyncio import Future
from typing import Any
from sqladmin.fields import FileField
from src.database import schemas
from src.database.crud import create_post, create_work, create_notification
import base64
from markupsafe import Markup
from fastapi_storages import FileSystemStorage
from sqladmin import Admin, ModelView
from starlette.middleware.sessions import SessionMiddleware
from fastapi.middleware.cors import CORSMiddleware
from sqladmin.authentication import AuthenticationBackend

from src.database.enums import NotificationType, MessageType, PostType, UserType, ProjectType
from src.database.models import User, Client, Contract, Post, Work, Notification
from src import routes
from src.database import user_routes
from src.database.db import get_db, engine, Base
from src.database.models import User
from src.database.schemas import UserCreate, UserResponse, Token
from src.database.crud import create_user
from src.auth.auth_routes import verify_password, create_access_token, decode_token, get_password_hash
from fastapi import FastAPI, Depends, HTTPException, status
from sqlalchemy.orm import Session, selectinload
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi import Request
from src.database.crud import get_user_by_email
import logging
from wtforms import SelectField


class CustomAuthBackend(AuthenticationBackend):
    async def login(self, request: Request) -> bool:
        form_data = await request.form()
        db = next(get_db())
        print(form_data['username'])
        user = get_user_by_email(db, form_data['username'])
        if not user or not verify_password(form_data['password'], user.hashed_password):
            return False
        if not user.is_superuser:
            return False
        access_token = create_access_token(data={"sub": user.email})
        request.session['access_token'] = access_token
        return True

    async def logout(self, request: Request) -> bool:
        request.session.pop("access_token", None)
        return True

    async def authenticate(self, request: Request) -> Any | None:
        token = request.session.get("access_token")
        if token:
            payload = decode_token(token)
            if payload:
                db = next(get_db())
                user = get_user_by_email(db, payload.get("sub"))
                if user:
                    return user
        return None


Base.metadata.create_all(bind=engine)

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

app.add_middleware(
    SessionMiddleware,
    secret_key="09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7",
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

admin = Admin(app=app, engine=engine, authentication_backend=CustomAuthBackend(
    secret_key="09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"), title="Панель управления")


class UserAdmin(ModelView, model=User):
    name = "Пользователь"
    name_plural = "Пользователи"
    icon = "fa-solid fa-user-tie"
    column_list = [User.email, User.name, User.surname, User.phone, User.user_type, User.notification_status,
                   User.notifications]
    column_searchable_list = [User.email, User.name, User.surname, User.user_type]
    column_filters = [User.user_type]
    column_sortable_list = [User.email, User.name, User.surname, User.user_type]
    column_details_exclude_list = [User.hashed_password, User.id, User.is_active]
    column_labels = dict(name="Имя", email="Email", surname="Фамилия", phone="Номер телефона", user_type="Роль",
                         notification_status="Статус уведомлений", user_referral_code="Реферальный код пользователя",
                         others_referral_code="Сторонний реферальный код", is_active="Активен",
                         is_superuser="Является админом", clients="Клиенты", contracts="Контракты",
                         hashed_password="Пароль", notifications="Уведомления")
    form_edit_rules = ['name', 'surname', 'phone', 'user_type', 'notification_status', 'user_referral_code',
                       'others_referral_code', 'is_superuser', 'clients', 'contracts', 'notifications']
    form_create_rules = ['email', 'name', 'surname', 'phone', 'user_type', 'notification_status', 'user_referral_code',
                         'others_referral_code', 'is_superuser', 'clients', 'contracts', 'hashed_password']
    can_create = True
    can_edit = True
    can_delete = True

    form_overrides = {
        'user_type': SelectField,
        'notification_status': SelectField,
    }

    form_args = {
        'user_type': {
            'choices': [
                (UserType.REALTOR, 'Риэлтор'),
                (UserType.DEVELOPER, 'Заказчик'),
                (UserType.INDIVIDUAL, 'Физическое лицо')
            ]
        },
        'notification_status': {
            'choices': [
                (NotificationType.NO_MESSAGES, 'Сообщений нет'),
                (NotificationType.NEW_MESSAGE, 'Новое сообщение'),
                (NotificationType.FILL_DOCUMENT, 'Заполнить документы')
            ]
        }
    }

    column_formatters = {
        'user_type': lambda m, p: m.user_type,
        'notification_status': lambda m, p: m.notification_status,
    }

    form_widget_args = {
        "name": {
            'placeholder="Пользователь пока не ввел имя"': True,
        },
        "surname": {
            'placeholder="Пользователь пока не ввел фамилию"': True,
        },
        "phone": {
            'pattern': "[0-9]",  # TODO: add pattern for phone number
            'placeholder="Пользователь пока не ввел номер телефона"': True,
        },
        "others_referral_code": {
            'placeholder="Пользователь пока не ввел сторонний реферальный код"': True,
        },
        "email": {
            'placeholder="Введите email пользователя"': True,
        },
        "hashed_password": {
            'placeholder="Введите пароль пользователя"': True,
        },
    }

    async def on_model_change(self, data, model, is_created, request):
        if is_created:
            if not data.get('hashed_password'):
                raise ValueError("Password cannot be None")
            model.hashed_password = get_password_hash(data['hashed_password'])
            model.user_type = UserType.REALTOR if data['user_type'] == 'Риэлтор' else UserType.DEVELOPER if data[
                                                                                                                'user_type'] == 'Заказчик' else UserType.INDIVIDUAL
        return Future().set_result(None)


class ClientAdmin(ModelView, model=Client):
    name = "Клиент"
    name_plural = "Клиенты"
    icon = "fa-solid fa-users-gear"
    column_list = [Client.object, Client.tariff, Client.location, Client.rate, Client.current_stage,
                   Client.user_id]
    column_searchable_list = [Client.object]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(object="Объект", tariff="Тариф", location="Местоположение", rate="Оценка",
                         current_stage="Текущий этап", user_id="ID пользователя")

    form_ajax_refs = {
        'user': {
            'fields': ['email', 'name', 'surname'],
            'page_size': 10
        }
    }


class ContractAdmin(ModelView, model=Contract):
    name = "Контракт"
    name_plural = "Контракты"
    icon = "fa-solid fa-file-signature"
    column_list = [Contract.id, Contract.object, Contract.tariff, Contract.location, Contract.total_cost,
                   Contract.current_stage, Contract.user_id]
    column_searchable_list = [Contract.object]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(object="Объект", tariff="Тариф", location="Местоположение", total_cost="Общая стоимость",
                         current_stage="Текущий этап", user_id="ID пользователя")


class PostAdmin(ModelView, model=Post):
    name = "Пост"
    name_plural = "Посты"
    icon = "fa-solid fa-newspaper"
    column_list = [Post.title, Post.post_type, Post.content, Post.images]
    column_searchable_list = [Post.title]
    column_filters = [Post.post_type]
    column_sortable_list = [Post.id, Post.title]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(title="Заголовок", post_type="Тип поста", content="Содержание", images="Изображения")

    form_overrides = {
        'images': FileField,
        'post_type': SelectField
    }

    form_args = {
        'post_type': {
            'choices': [
                (PostType.NEWS, 'Новость'),
                (PostType.BLOG, 'Блог'),
            ]
        },
    }

    column_formatters_detail = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR',
        'post_type': lambda m, p: m.post_type
    }

    column_formatters = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR',
        'post_type': lambda m, p: m.post_type
    }

    async def on_model_change(self, data, model, is_created, request):
        if 'images' in data:
            images = []
            file = data['images']
            content = await file.read()
            images.append(base64.b64encode(content).decode('utf-8') if content else None)

            post_data = schemas.PostCreate(
                title=data['title'],
                post_type=PostType.NEWS if data['post_type'] == 'Новость' else PostType.BLOG,
                content=data['content'],
                images=images
            )

            for db_session in get_db():
                await create_post(post_data, db_session)


class WorkAdmin(ModelView, model=Work):
    name = "Портфолио"
    name_plural = "Портфолио"
    icon = "fa-solid fa-building-circle-check"

    column_list = [Work.title, Work.project_type, Work.deadline, Work.cost, Work.square, Work.task,
                   Work.description, Work.images]
    column_searchable_list = [Work.title]
    column_filters = [Work.project_type]
    column_sortable_list = [Work.id, Work.title, Work.cost, Work.square, Work.deadline]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(title="Заголовок", project_type="Тип проекта", deadline="Дедлайн", cost="Стоимость",
                         square="Площадь", task="Задача", description="Описание", images="Изображения")

    form_overrides = {
        'images': FileField,
        'project_type': SelectField
    }

    form_args = {
        'project_type': {
            'choices': [
                (ProjectType.FLAT, 'Квартира'),
                (ProjectType.HOUSE, 'Дом'),
            ]
        },
    }

    column_formatters = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR',
        'project_type': lambda m, p: m.project_type
    }

    column_formatters_detail = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR',
        'project_type': lambda m, p: m.project_type
    }

    async def on_model_change(self, data, model, is_created, request):
        if 'images' in data:
            images = []
            file = data['images']
            content = await file.read()
            images.append(base64.b64encode(content).decode('utf-8') if content else None)

            work_data = schemas.WorkCreate(
                title=data['title'],
                project_type=ProjectType.FLAT if data['project_type'] == 'Квартира' else ProjectType.HOUSE,
                deadline=data['deadline'],
                cost=data['cost'],
                square=data['square'],
                task=data['task'],
                description=data['description'],
                images=images
            )

            for db_session in get_db():
                await create_work(work_data, db_session)


class NotificationAdmin(ModelView, model=Notification):
    name = "Уведомление"
    name_plural = "Уведомления"
    icon = "fa-solid fa-bell"

    column_list = [Notification.message_type, Notification.content, Notification.user_id,
                   Notification.attachment]
    column_searchable_list = [Notification.content]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(message_type="Тип сообщения", content="Содержание", user_id="ID пользователя",
                         attachment="Вложение", user="Пользователь")

    column_details_exclude_list = [Notification.id]

    form_overrides = {
        'attachment': FileField,
        'message_type': SelectField
    }

    form_args = {
        'message_type': {
            'choices': [
                (MessageType.MESSAGE, 'Сообщение'),
                (MessageType.SIGNATURE, 'Акт'),
            ]
        }
    }

    column_formatters_detail = {
        'attachment': lambda m, p: Markup(
            f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>'
        ) if m.attachment else 'ERROR',
        'message_type': lambda m, p: m.message_type
    }

    column_formatters = {
        'attachment': lambda m, p: Markup(
            f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>'
        ) if m.attachment else 'ERROR',
        'message_type': lambda m, p: m.message_type
    }

    async def on_model_change(self, data, model, is_created, request):
        if 'attachment' in data:
            file_data = await data['attachment'].read()
            user_id = data['user']
            notification_data = schemas.NotificationCreate(
                user_id=user_id,
                message_type=MessageType.MESSAGE if data['message_type'] == 'Сообщение' else MessageType.SIGNATURE,
                content=data['content'],
                attachment=file_data,
            )

            for db_session in get_db():
                await create_notification(notification_data, db_session)


admin.add_view(UserAdmin)
admin.add_view(ClientAdmin)
admin.add_view(ContractAdmin)
admin.add_view(PostAdmin)
admin.add_view(WorkAdmin)
admin.add_view(NotificationAdmin)

app.include_router(user_routes.router)
app.include_router(routes.meta())


# main.py


# Register Route
@app.post("/register", response_model=UserResponse)
def register(user: UserCreate, db: Session = Depends(get_db)):
    db_user = get_user_by_email(db, user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="email already registered")
    return create_user(user, db)


# Login Route
@app.post("/login", response_model=Token)
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = get_user_by_email(db, form_data.username)
    if not user or not verify_password(form_data.password, user.hashed_password):
        raise HTTPException(status_code=400, detail="Incorrect email or password")

    access_token = create_access_token(data={"sub": user.email})
    return {"access_token": access_token, "token_type": "bearer"}


# Protected Route
@app.get("/protected")
def protected_route(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    payload = decode_token(token)
    if payload is None:
        raise HTTPException(status_code=401, detail="Invalid token")

    user = get_user_by_email(db, payload.get("sub"))
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    return {"message": f"Hello {user.email}, this is a protected route"}

# Logout Route (JWT is stateless, so we don’t need an actual "logout" functionality)
