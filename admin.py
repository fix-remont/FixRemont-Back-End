# from asyncio import Future
# from sqladmin.fields import FileField
# from src.database.crud import create_post, create_work, create_notification
# import base64
# from markupsafe import Markup
# from src.database import schemas
# from src.database.db import get_db
# from src.database.models import User
# from src.auth.auth_routes import get_password_hash
# from wtforms import SelectField
# from sqladmin import ModelView
# from src.database.models import Flat
# from src.database.models import Style
# from src.database.models import AdditionalOption
# from src.database.models import Tariff
# from asyncio import Future
# from sqladmin.fields import FileField
# from src.database.crud import create_post, create_work, create_notification
# import base64
# from markupsafe import Markup
# from src.database import schemas
# from src.database.models import Contract, Post, Work, Notification, ProjectType, PostType, UserType, \
#     NotificationType
# from src.database.db import get_db
# from src.database.models import User
# from src.auth.auth_routes import get_password_hash
# from wtforms import SelectField
# from sqladmin import ModelView
# from src.database.models import Flat
# from src.database.models import Style
# from src.database.models import AdditionalOption
# from src.database.models import Tariff
# from sqlalchemy.ext.asyncio import AsyncSession
# from sqlalchemy import select
#
# db = get_db()
#
#
# async def get_all_model_values(db: AsyncSession, model):
#     result = await db.execute(select(model.name))
#     return [x[0] for x in result.scalars().all()]
#
#
# class UserAdmin(ModelView, model=User):
#     name = "Пользователь"
#     name_plural = "Пользователи"
#     icon = "fa-solid fa-user-tie"
#     column_list = [User.email, User.name, User.surname, User.phone, User.user_type, User.notification_status,
#                    User.notifications]
#     column_searchable_list = [User.email, User.name, User.surname, User.user_type]
#     column_filters = [User.user_type]
#     column_sortable_list = [User.email, User.name, User.surname, User.user_type]
#     column_details_exclude_list = [User.hashed_password, User.id]
#     column_labels = dict(name="Имя", email="Email", surname="Фамилия", phone="Номер телефона", user_type="Роль",
#                          notification_status="Статус уведомлений", user_referral_code="Реферальный код пользователя",
#                          others_referral_code="Сторонний реферальный код", is_active="Активен",
#                          is_superuser="Является админом", clients="Клиенты", contracts="Контракты",
#                          hashed_password="Пароль", notifications="Уведомления")
#     form_edit_rules = ['name', 'surname', 'phone', 'user_type', 'notification_status', 'user_referral_code',
#                        'others_referral_code', 'is_superuser', 'clients', 'contracts', 'notifications']
#     form_create_rules = ['email', 'name', 'surname', 'phone', 'user_type', 'notification_status', 'user_referral_code',
#                          'others_referral_code', 'is_superuser', 'clients', 'contracts', 'hashed_password']
#     can_create = True
#     can_edit = True
#     can_delete = True
#
#     form_widget_args = {
#         "name": {
#             'placeholder="Пользователь пока не ввел имя"': True,
#         },
#         "surname": {
#             'placeholder="Пользователь пока не ввел фамилию"': True,
#         },
#         "phone": {
#             'pattern': "[0-9]",  # TODO: add pattern for phone number
#             'placeholder="Пользователь пока не ввел номер телефона"': True,
#         },
#         "others_referral_code": {
#             'placeholder="Пользователь пока не ввел сторонний реферальный код"': True,
#         },
#         "email": {
#             'placeholder="Введите email пользователя"': True,
#         },
#         "hashed_password": {
#             'placeholder="Введите пароль пользователя"': True,
#         },
#     }
#
#     async def on_model_change(self, data, model, is_created, request):
#         if is_created:
#             if not data.get('hashed_password'):
#                 raise ValueError("Password cannot be None")
#             model.hashed_password = get_password_hash(data['hashed_password'])
#             model.user_type = db.query(UserType).filter_by(name=data['user_type']).first()
#         return Future().set_result(None)
#
#
#
# class ContractAdmin(ModelView, model=Contract):
#     name = "Контракт"
#     name_plural = "Контракты"
#     icon = "fa-solid fa-file-signature"
#     column_list = [Contract.id, Contract.object, Contract.tariff, Contract.location, Contract.total_cost,
#                    Contract.current_stage, Contract.user_id]
#     column_searchable_list = [Contract.object]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(object="Объект", tariff="Тариф", location="Местоположение", total_cost="Общая стоимость",
#                          current_stage="Текущий этап", user_id="ID пользователя")
#
#
# class PostAdmin(ModelView, model=Post):
#     name = "Пост"
#     name_plural = "Посты"
#     icon = "fa-solid fa-newspaper"
#     column_list = [Post.title, Post.post_type, Post.content, Post.images]
#     column_searchable_list = [Post.title]
#     column_filters = [Post.post_type]
#     column_sortable_list = [Post.id, Post.title]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(title="Заголовок", post_type="Тип поста", content="Содержание", images="Изображения")
#
#     form_overrides = {
#         'images': FileField,
#     }
#
#     column_formatters_detail = {
#         'images': lambda m, p: Markup(
#             ''.join(
#                 f'<img src="data:image/png;base64,{image}" width="100" />'
#                 for image in m.images
#             )
#         ) if m.images else 'ERROR'
#     }
#
#     column_formatters = {
#         'images': lambda m, p: Markup(
#             ''.join(
#                 f'<img src="data:image/png;base64,{image}" width="100" />'
#                 for image in m.images
#             )
#         ) if m.images else 'ERROR'
#     }
#
#     async def on_model_change(self, data, model, is_created, request):
#         if 'images' in data:
#             images = []
#             file = data['images']
#             content = await file.read()
#             images.append(base64.b64encode(content).decode('utf-8') if content else None)
#
#             post_data = schemas.PostCreate(
#                 title=data['title'],
#                 post_type=data['post_type'],
#                 content=data['content'],
#                 images=images
#             )
#
#             for db_session in get_db():
#                 await create_post(post_data, db_session)
#
#
# class WorkAdmin(ModelView, model=Work):
#     name = "Портфолио"
#     name_plural = "Портфолио"
#     icon = "fa-solid fa-building-circle-check"
#
#     column_list = [Work.title, Work.project_type, Work.deadline, Work.cost, Work.square, Work.task,
#                    Work.description, Work.images]
#     column_searchable_list = [Work.title]
#     column_filters = [Work.project_type]
#     column_sortable_list = [Work.id, Work.title, Work.cost, Work.square, Work.deadline]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(title="Заголовок", project_type="Тип проекта", deadline="Дедлайн", cost="Стоимость",
#                          square="Площадь", task="Задача", description="Описание", images="Изображения")
#
#     form_overrides = {
#         'images': FileField
#     }
#
#     column_formatters = {
#         'images': lambda m, p: Markup(
#             ''.join(
#                 f'<img src="data:image/png;base64,{image}" width="100" />'
#                 for image in m.images
#             )
#         ) if m.images else 'ERROR'
#     }
#
#     column_formatters_detail = {
#         'images': lambda m, p: Markup(
#             ''.join(
#                 f'<img src="data:image/png;base64,{image}" width="100" />'
#                 for image in m.images
#             )
#         ) if m.images else 'ERROR'
#     }
#
#     async def on_model_change(self, data, model, is_created, request):
#         if 'images' in data:
#             images = []
#             file = data['images']
#             content = await file.read()
#             images.append(base64.b64encode(content).decode('utf-8') if content else None)
#             data['images'] = images
#             work_data = schemas.WorkCreate(
#                 title=data['title'],
#                 project_type=data['project_type'],
#                 deadline=data['deadline'],
#                 cost=data['cost'],
#                 square=data['square'],
#                 task=data['task'],
#                 description=data['description'],
#                 images=images
#             )
#
#             for db_session in get_db():
#                 await create_work(work_data, db_session)
#
#
# class NotificationAdmin(ModelView, model=Notification):
#     name = "Уведомление"
#     name_plural = "Уведомления"
#     icon = "fa-solid fa-bell"
#
#     column_list = [Notification.message_type, Notification.content, Notification.user_id,
#                    Notification.attachment]
#     column_searchable_list = [Notification.content]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(message_type="Тип сообщения", content="Содержание", user_id="ID пользователя",
#                          attachment="Вложение", user="Пользователь")
#
#     column_details_exclude_list = [Notification.id]
#
#     form_overrides = {
#         'attachment': FileField
#     }
#
#     column_formatters_detail = {
#         'attachment': lambda m, p: Markup(
#             f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>'
#         ) if m.attachment else 'ERROR'
#     }
#
#     column_formatters = {
#         'attachment': lambda m, p: Markup(
#             f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>'
#         ) if m.attachment else 'ERROR'
#     }
#
#     async def on_model_change(self, data, model, is_created, request):
#         if 'attachment' in data:
#             file_data = await data['attachment'].read()
#             user_id = data['user']
#             notification_data = schemas.NotificationCreate(
#                 user_id=user_id,
#                 message_type=data['message_type'],
#                 content=data['content'],
#                 attachment=file_data,
#             )
#
#             for db_session in get_db():
#                 await create_notification(notification_data, db_session)
#
#
# class FlatAdmin(ModelView, model=Flat):
#     name = "Квартира"
#     name_plural = "Квартиры"
#     icon = "fa-solid fa-building"
#     column_list = [Flat.square, Flat.address, Flat.number_of_rooms, Flat.number_of_doors, Flat.number_of_wc,
#                    Flat.demolition, Flat.wall_build, Flat.liquid_floor, Flat.ceiling_stretching, Flat.tariff_id,
#                    Flat.style_id]
#     column_searchable_list = [Flat.address]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(square="Площадь", address="Адрес", number_of_rooms="Количество комнат",
#                          number_of_doors="Количество дверей", number_of_wc="Количество санузлов", demolition="Снос",
#                          wall_build="Постройка стен", liquid_floor="Жидкий пол", ceiling_stretching="Натяжной потолок",
#                          tariff_id="Тариф", style_id="Стиль")
#
#
# class TariffAdmin(ModelView, model=Tariff):
#     name = "Тариф"
#     name_plural = "Тарифы"
#     icon = "fa-solid fa-money-bill"
#     category = "Ремонт квартир"
#     column_list = [Tariff.name, Tariff.description]
#     column_searchable_list = [Tariff.name]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(name="Название", description="Описание")
#
#
# class StyleAdmin(ModelView, model=Style):
#     name = "Стиль"
#     name_plural = "Стили"
#     icon = "fa-solid fa-paint-brush"
#     category = "Ремонт квартир"
#     column_list = [Style.name, Style.description]
#     column_searchable_list = [Style.name]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(name="Название", description="Описание")
#
#
# class AdditionalOptionAdmin(ModelView, model=AdditionalOption):
#     name = "Дополнительная опция"
#     name_plural = "Дополнительные опции"
#     category = "Ремонт квартир"
#     icon = "fa-solid fa-plus"
#     column_list = [AdditionalOption.name, AdditionalOption.description]
#     column_searchable_list = [AdditionalOption.name]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(name="Название", description="Описание")
#
#
# class ProjectTypeAdmin(ModelView, model=ProjectType):
#     name = "Тип проекта"
#     name_plural = "Типы проектов"
#     icon = "fa-solid fa-building"
#     column_list = [ProjectType.name]
#     column_searchable_list = [ProjectType.name]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(name="Название")
#
#
# class PostTypeAdmin(ModelView, model=PostType):
#     name = "Тип поста"
#     name_plural = "Типы постов"
#     icon = "fa-solid fa-newspaper"
#     column_list = [PostType.name]
#     column_searchable_list = [PostType.name]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(name="Название")
#
#
# class UserTypeAdmin(ModelView, model=UserType):
#     name = "Тип пользователя"
#     name_plural = "Типы пользователей"
#     icon = "fa-solid fa-user"
#     column_list = [UserType.name]
#     column_searchable_list = [UserType.name]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(name="Название")
#
#
# class NotificationTypeAdmin(ModelView, model=NotificationType):
#     name = "Тип уведомления"
#     name_plural = "Типы уведомлений"
#     icon = "fa-solid fa-bell"
#     column_list = [NotificationType.name]
#     column_searchable_list = [NotificationType.name]
#     can_create = True
#     can_edit = True
#     can_delete = True
#     column_labels = dict(name="Название")
#


from asyncio import Future
from sqladmin.fields import FileField
from src.database.cruds import create_post, create_portfolio_post
import base64
from markupsafe import Markup
from src.database import schemas
from src.database.db import get_db
from src.database.models import User, Flat, Style, AdditionalOption, Tariff, Contract, Post, Work, Notification, \
    ProjectType, PostType, UserType, NotificationType, Paragraph, FAQ, WorkStatus, PlatformNews
from src.auth.auth_routes import get_password_hash
from wtforms import SelectField
from sqladmin import ModelView
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
    column_details_exclude_list = [User.hashed_password, User.id]
    column_labels = dict(name="Имя", email="Email", surname="Фамилия", phone="Номер телефона", user_type="Роль",
                         notification_status="Статус уведомлений", user_referral_code="Реферальный код пользователя",
                         others_referral_code="Сторонний реферальный код", is_active="Активен",
                         is_superuser="Является админом", contracts="Контракты", hashed_password="Пароль",
                         notifications="Уведомления")
    form_edit_rules = ['name', 'surname', 'phone', 'user_type', 'notification_status', 'user_referral_code',
                       'others_referral_code', 'is_superuser', 'contracts', 'notifications']
    form_create_rules = ['email', 'name', 'surname', 'phone', 'user_type', 'notification_status', 'user_referral_code',
                         'others_referral_code', 'is_superuser', 'contracts', 'hashed_password']
    can_create = True
    can_edit = True
    can_delete = True

    form_widget_args = {
        "name": {'placeholder': "Пользователь пока не ввел имя"},
        "surname": {'placeholder': "Пользователь пока не ввел фамилию"},
        "phone": {'pattern': "[0-9]", 'placeholder': "Пользователь пока не ввел номер телефона"},
        "others_referral_code": {'placeholder': "Пользователь пока не ввел сторонний реферальный код"},
        "email": {'placeholder': "Введите email пользователя"},
        "hashed_password": {'placeholder': "Введите пароль пользователя"},
    }

    async def on_model_change(self, data, model, is_created, request):
        if is_created:
            if not data.get('hashed_password'):
                raise ValueError("Password cannot be None")
            model.hashed_password = get_password_hash(data['hashed_password'])
            model.user_type = db.query(UserType).filter_by(name=data['user_type']).first()
        return Future().set_result(None)


class ContractAdmin(ModelView, model=Contract):
    name = "Контракт"
    name_plural = "Контракты"
    icon = "fa-solid fa-file-signature"
    column_list = [Contract.id, Contract.object, Contract.tariff_type, Contract.location, Contract.total_cost,
                   Contract.current_stage, Contract.client_id]
    column_searchable_list = [Contract.object]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(object="Объект", tariff_type="Тариф", location="Местоположение", total_cost="Общая стоимость",
                         current_stage="Текущий этап", client_id="ID пользователя")


class PostAdmin(ModelView, model=Post):
    name = "Пост"
    name_plural = "Посты"
    icon = "fa-solid fa-newspaper"
    column_list = [Post.title, Post.post_type, Post.paragraphs, Post.image1, Post.image2, Post.image3]
    column_searchable_list = [Post.title]
    column_filters = [Post.post_type]
    column_sortable_list = [Post.id, Post.title]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(title="Заголовок", post_type="Тип поста", paragraphs="Параграфы", image1="Изображение 1",
                         image2="Изображение 2", image3="Изображение 3")

    form_overrides = {
        'image1': FileField,
        'image2': FileField,
        'image3': FileField,
    }

    column_formatters_detail = {
        'image1': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image1}" width="100" />') if m.image1 else 'ERROR',
        'image2': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image2}" width="100" />') if m.image2 else 'ERROR',
        'image3': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image3}" width="100" />') if m.image3 else 'ERROR',
    }

    column_formatters = {
        'image1': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image1}" width="100" />') if m.image1 else 'ERROR',
        'image2': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image2}" width="100" />') if m.image2 else 'ERROR',
        'image3': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image3}" width="100" />') if m.image3 else 'ERROR',
    }

    async def on_model_change(self, data, model, is_created, request):
        if 'image1' in data:
            file = data['image1']
            content = await file.read()
            data['image1'] = base64.b64encode(content).decode('utf-8') if content else None
        if 'image2' in data:
            file = data['image2']
            content = await file.read()
            data['image2'] = base64.b64encode(content).decode('utf-8') if content else None
        if 'image3' in data:
            file = data['image3']
            content = await file.read()
            data['image3'] = base64.b64encode(content).decode('utf-8') if content else None
        post_data = schemas.PostCreate(
            title=data['title'],
            post_type=data['post_type'],
            paragraphs=data['paragraphs'],
            image1=data['image1'],
            image2=data['image2'],
            image3=data['image3']
        )
        for db_session in get_db():
            await create_post(post_data, db_session)


class WorkAdmin(ModelView, model=Work):
    name = "Портфолио"
    name_plural = "Портфолио"
    icon = "fa-solid fa-building-circle-check"
    column_list = [Work.title, Work.project_type, Work.deadline, Work.cost, Work.square, Work.task, Work.description,
                   Work.image1, Work.image2, Work.image3, Work.image4, Work.image5, Work.video_link,
                   Work.video_duration]
    column_searchable_list = [Work.title]
    column_filters = [Work.project_type]
    column_sortable_list = [Work.id, Work.title, Work.cost, Work.square, Work.deadline]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(title="Заголовок", project_type="Тип проекта", deadline="Дедлайн", cost="Стоимость",
                         square="Площадь", task="Задача", description="Описание", image1="Изображение 1",
                         image2="Изображение 2", image3="Изображение 3", image4="Изображение 4", image5="Изображение 5",
                         video_link="Ссылка на видео", video_duration="Длительность видео")

    form_overrides = {
        'image1': FileField,
        'image2': FileField,
        'image3': FileField,
        'image4': FileField,
        'image5': FileField,
    }

    column_formatters = {
        'image1': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image1}" width="100" />') if m.image1 else 'ERROR',
        'image2': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image2}" width="100" />') if m.image2 else 'ERROR',
        'image3': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image3}" width="100" />') if m.image3 else 'ERROR',
        'image4': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image4}" width="100" />') if m.image4 else 'ERROR',
        'image5': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image5}" width="100" />') if m.image5 else 'ERROR',
    }

    column_formatters_detail = {
        'image1': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image1}" width="100" />') if m.image1 else 'ERROR',
        'image2': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image2}" width="100" />') if m.image2 else 'ERROR',
        'image3': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image3}" width="100" />') if m.image3 else 'ERROR',
        'image4': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image4}" width="100" />') if m.image4 else 'ERROR',
        'image5': lambda m, p: Markup(
            f'<img src="data:image/png;base64,{m.image5}" width="100" />') if m.image5 else 'ERROR',
    }

    async def on_model_change(self, data, model, is_created, request):
        for image_field in ['image1', 'image2', 'image3', 'image4', 'image5']:
            if image_field in data:
                file = data[image_field]
                content = await file.read()
                data[image_field] = base64.b64encode(content).decode('utf-8') if content else None
        work_data = schemas.WorkCreate(
            title=data['title'],
            project_type=data['project_type'],
            deadline=data['deadline'],
            cost=data['cost'],
            square=data['square'],
            task=data['task'],
            description=data['description'],
            image1=data['image1'],
            image2=data['image2'],
            image3=data['image3'],
            image4=data['image4'],
            image5=data['image5'],
            video_link=data['video_link'],
            video_duration=data['video_duration']
        )
        for db_session in get_db():
            await create_portfolio_post(work_data, db_session)


class NotificationAdmin(ModelView, model=Notification):
    name = "Уведомление"
    name_plural = "[BUG] Уведомления"
    icon = "fa-solid fa-bell"
    column_list = [Notification.notification_status, Notification.title, Notification.date, Notification.attachment,
                   Notification.contract_id, Notification.user_id]
    column_searchable_list = [Notification.title]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(notification_status="Статус уведомления", title="Заголовок", date="Дата",
                         attachment="Вложение", contract_id="ID контракта", user_id="ID пользователя")

    form_overrides = {
        'attachment': FileField
    }

    column_formatters_detail = {
        'attachment': lambda m, p: Markup(
            f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>') if m.attachment else 'ERROR'
    }

    column_formatters = {
        'attachment': lambda m, p: Markup(
            f'<a href="data:application/pdf;base64,{base64.b64encode(m.attachment).decode("utf-8")}" download="attachment.pdf">Скачать PDF</a>') if m.attachment else 'ERROR'
    }

    # async def on_model_change(self, data, model, is_created, request):
    #     if 'attachment' in data:
    #         file_data = await data['attachment'].read()
    #         user_id = data['user']
    #         notification_data = schemas.NotificationCreate(
    #             user_id=user_id,
    #             notification_status=data['notification_status'],
    #             title=data['title'],
    #             date=data['date'],
    #             attachment=file_data,
    #         )
    #         for db_session in get_db():
    #             await create_notification(notification_data, db_session)


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


class PlatformNewsAdmin(ModelView, model=PlatformNews):
    name = "Новости платформы"
    name_plural = "Новости платформы"
    icon = "fa-solid fa-newspaper"
    column_list = [PlatformNews.id, PlatformNews.title, PlatformNews.date, PlatformNews.label]
    column_searchable_list = [PlatformNews.title]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(id="ID", title="Заголовок", date="Дата", label="Метка")


class WorkStatusAdmin(ModelView, model=WorkStatus):
    name = "Статус работы"
    name_plural = "Статусы работы"
    icon = "fa-solid fa-tasks"
    column_list = [WorkStatus.id, WorkStatus.title, WorkStatus.document, WorkStatus.status, WorkStatus.contract_id]
    column_searchable_list = [WorkStatus.title]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(id="ID", title="Название", document="Документ", status="Статус", contract_id="ID контракта")


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


class ParagraphAdmin(ModelView, model=Paragraph):
    name = "Параграф"
    name_plural = "Параграфы"
    icon = "fa-solid fa-paragraph"
    column_list = [Paragraph.id, Paragraph.title, Paragraph.body]
    column_searchable_list = [Paragraph.title]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(id="ID", title="Заголовок", body="Содержание")


class FAQAdmin(ModelView, model=FAQ):
    name = "Часто задаваемый вопрос"
    name_plural = "Часто задаваемые вопросы"
    icon = "fa-solid fa-question"
    column_list = [FAQ.id, FAQ.heading, FAQ.label]
    column_searchable_list = [FAQ.heading]
    can_create = True
    can_edit = True
    can_delete = True
    column_labels = dict(id="ID", title="Вопрос", label="Ответ")


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
