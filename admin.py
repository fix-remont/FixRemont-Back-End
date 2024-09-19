from asyncio import Future
from sqladmin.fields import FileField
from src.database.crud import create_post, create_work, create_notification
import base64
from markupsafe import Markup
from src.database import schemas
from src.database.models import Client, Contract, Post, Work, Notification, ProjectType, PostType, UserType, \
    NotificationType, MessageType
from src.database.db import get_db
from src.database.models import User
from src.auth.auth_routes import get_password_hash
from wtforms import SelectField
from sqladmin import ModelView
from src.database.models import Flat
from src.database.models import Style
from src.database.models import AdditionalOption
from src.database.models import Tariff
from asyncio import Future
from sqladmin.fields import FileField
from src.database.crud import create_post, create_work, create_notification
import base64
from markupsafe import Markup
from src.database import schemas
from src.database.models import Client, Contract, Post, Work, Notification, ProjectType, PostType, UserType, \
    NotificationType, MessageType
from src.database.db import get_db
from src.database.models import User
from src.auth.auth_routes import get_password_hash
from wtforms import SelectField
from sqladmin import ModelView
from src.database.models import Flat
from src.database.models import Style
from src.database.models import AdditionalOption
from src.database.models import Tariff
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

db = get_db()


async def get_all_model_values(db: AsyncSession, model):
    result = await db.execute(select(model.name))
    return [x[0] for x in result.scalars().all()]


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
            model.user_type = db.query(UserType).filter_by(name=data['user_type']).first()
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
    }

    column_formatters_detail = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR'
    }

    column_formatters = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR'
    }

    async def on_model_change(self, data, model, is_created, request):
        if 'images' in data:
            images = []
            file = data['images']
            content = await file.read()
            images.append(base64.b64encode(content).decode('utf-8') if content else None)

            post_data = schemas.PostCreate(
                title=data['title'],
                post_type=data['post_type'],
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
        'images': FileField
    }

    column_formatters = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR'
    }

    column_formatters_detail = {
        'images': lambda m, p: Markup(
            ''.join(
                f'<img src="data:image/png;base64,{image}" width="100" />'
                for image in m.images
            )
        ) if m.images else 'ERROR'
    }

    async def on_model_change(self, data, model, is_created, request):
        if 'images' in data:
            images = []
            file = data['images']
            content = await file.read()
            images.append(base64.b64encode(content).decode('utf-8') if content else None)
            data['images'] = images
            work_data = schemas.WorkCreate(
                title=data['title'],
                project_type=data['project_type'],
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
        'attachment': FileField
    }

    column_formatters_detail = {
        'attachment': lambda m, p: Markup(
            f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>'
        ) if m.attachment else 'ERROR'
    }

    column_formatters = {
        'attachment': lambda m, p: Markup(
            f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>'
        ) if m.attachment else 'ERROR'
    }

    async def on_model_change(self, data, model, is_created, request):
        if 'attachment' in data:
            file_data = await data['attachment'].read()
            user_id = data['user']
            notification_data = schemas.NotificationCreate(
                user_id=user_id,
                message_type=data['message_type'],
                content=data['content'],
                attachment=file_data,
            )

            for db_session in get_db():
                await create_notification(notification_data, db_session)


class FlatAdmin(ModelView, model=Flat):
    name = "Квартира"
    name_plural = "Квартиры"
    icon = "fa-solid fa-building"
    column_list = [Flat.square, Flat.address, Flat.number_of_rooms, Flat.number_of_doors, Flat.number_of_wc,
                   Flat.demolition, Flat.wall_build, Flat.liquid_floor, Flat.ceiling_stretching, Flat.tariff_id,
                   Flat.style_id]
    column_searchable_list = [Flat.address]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(square="Площадь", address="Адрес", number_of_rooms="Количество комнат",
                         number_of_doors="Количество дверей", number_of_wc="Количество санузлов", demolition="Снос",
                         wall_build="Постройка стен", liquid_floor="Жидкий пол", ceiling_stretching="Натяжной потолок",
                         tariff_id="Тариф", style_id="Стиль")


class TariffAdmin(ModelView, model=Tariff):
    name = "Тариф"
    name_plural = "Тарифы"
    icon = "fa-solid fa-money-bill"
    category = "Ремонт квартир"
    column_list = [Tariff.name, Tariff.description]
    column_searchable_list = [Tariff.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название", description="Описание")


class StyleAdmin(ModelView, model=Style):
    name = "Стиль"
    name_plural = "Стили"
    icon = "fa-solid fa-paint-brush"
    category = "Ремонт квартир"
    column_list = [Style.name, Style.description]
    column_searchable_list = [Style.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название", description="Описание")


class AdditionalOptionAdmin(ModelView, model=AdditionalOption):
    name = "Дополнительная опция"
    name_plural = "Дополнительные опции"
    category = "Ремонт квартир"
    icon = "fa-solid fa-plus"
    column_list = [AdditionalOption.name, AdditionalOption.description]
    column_searchable_list = [AdditionalOption.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название", description="Описание")


class ProjectTypeAdmin(ModelView, model=ProjectType):
    name = "Тип проекта"
    name_plural = "Типы проектов"
    icon = "fa-solid fa-building"
    column_list = [ProjectType.name]
    column_searchable_list = [ProjectType.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название")


class PostTypeAdmin(ModelView, model=PostType):
    name = "Тип поста"
    name_plural = "Типы постов"
    icon = "fa-solid fa-newspaper"
    column_list = [PostType.name]
    column_searchable_list = [PostType.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название")


class UserTypeAdmin(ModelView, model=UserType):
    name = "Тип пользователя"
    name_plural = "Типы пользователей"
    icon = "fa-solid fa-user"
    column_list = [UserType.name]
    column_searchable_list = [UserType.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название")


class NotificationTypeAdmin(ModelView, model=NotificationType):
    name = "Тип уведомления"
    name_plural = "Типы уведомлений"
    icon = "fa-solid fa-bell"
    column_list = [NotificationType.name]
    column_searchable_list = [NotificationType.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название")


class MessageTypeAdmin(ModelView, model=MessageType):
    name = "Тип сообщения"
    name_plural = "Типы сообщений"
    icon = "fa-solid fa-envelope"
    column_list = [MessageType.name]
    column_searchable_list = [MessageType.name]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(name="Название")
