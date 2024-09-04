from contextlib import asynccontextmanager
from sqladmin.fields import FileField
from src.database import schemas
from src.database.crud import create_post, create_work
from src.database.db import engine, get_db
from users.db import create_db_and_tables, User, Client, Contract
from src.database.models import Post, Work
from users.schemas import UserCreate, UserRead, UserUpdate
from users.users import auth_backend, fastapi_users
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from src import routes
from users.routes import router as user_router
from sqladmin import Admin
import base64
from sqladmin import ModelView
from markupsafe import Markup
from fastapi_storages import FileSystemStorage


@asynccontextmanager
async def lifespan(app: FastAPI):
    await create_db_and_tables()
    yield


app = FastAPI(lifespan=lifespan)

admin = Admin(app, engine)


class UserAdmin(ModelView, model=User):
    column_list = [User.id, User.name, User.surname, User.email, User.phone, User.user_type,
                   User.user_referral_code, User.others_referral_code, User.clients, User.contracts]
    column_searchable_list = [User.name, User.email]
    can_create = True
    can_edit = True
    can_delete = True


class ClientAdmin(ModelView, model=Client):
    column_list = [Client.id, Client.object, Client.tariff, Client.location, Client.rate, Client.current_stage,
                   Client.user_id]
    column_searchable_list = [Client.object]
    can_create = True
    can_edit = True
    can_delete = True


class ContractAdmin(ModelView, model=Contract):
    column_list = [Contract.id, Contract.object, Contract.tariff, Contract.location, Contract.total_cost,
                   Contract.current_stage, Contract.user_id]
    column_searchable_list = [Contract.object]
    can_create = True
    can_edit = True
    can_delete = True


class PostAdmin(ModelView, model=Post):
    column_list = [Post.id, Post.title, Post.post_type, Post.content, Post.images]
    column_searchable_list = [Post.title]
    column_filters = [Post.post_type]
    column_sortable_list = [Post.id, Post.title]
    can_create = True
    can_edit = True
    can_delete = True

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

    async def on_model_change(self, data, model, is_created, request):
        if 'images' in data:
            images = []
            file = data['images']
            content = await file.read()
            images.append(base64.b64encode(content).decode('utf-8') if content else None)

            post_data = schemas.PostCreate(
                title=data['title'],
                post_type=schemas.PostType(data['post_type'].lower()),
                content=data['content'],
                images=images
            )

            async for db_session in get_db():
                await create_post(post_data, db_session)


storage = FileSystemStorage(path="/tmp")


class WorkAdmin(ModelView, model=Work):
    column_list = [Work.id, Work.title, Work.project_type, Work.deadline, Work.cost, Work.square, Work.task,
                   Work.description, Work.images]
    column_searchable_list = [Work.title]
    column_filters = [Work.project_type]
    column_sortable_list = [Work.id, Work.title, Work.cost, Work.square, Work.deadline]
    can_create = True
    can_edit = True
    can_delete = True

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

    async def on_model_change(self, data, model, is_created, request):
        if 'images' in data:
            images = []
            file = data['images']
            content = await file.read()
            images.append(base64.b64encode(content).decode('utf-8') if content else None)

            work_data = schemas.WorkCreate(
                title=data['title'],
                project_type=schemas.ProjectType(data['project_type'].lower()),
                deadline=data['deadline'],
                cost=data['cost'],
                square=data['square'],
                task=data['task'],
                description=data['description'],
                images=images
            )

            async for db_session in get_db():
                await create_work(work_data, db_session)


admin.add_view(UserAdmin)
admin.add_view(ClientAdmin)
admin.add_view(ContractAdmin)
admin.add_view(PostAdmin)
admin.add_view(WorkAdmin)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(
    fastapi_users.get_auth_router(auth_backend), prefix="/auth/jwt", tags=["auth"]
)
app.include_router(
    fastapi_users.get_register_router(UserRead, UserCreate),
    prefix="/auth",
    tags=["auth"],
)
app.include_router(
    fastapi_users.get_reset_password_router(),
    prefix="/auth",
    tags=["auth"],
)
app.include_router(
    fastapi_users.get_verify_router(UserRead),
    prefix="/auth",
    tags=["auth"],
)
app.include_router(
    fastapi_users.get_users_router(UserRead, UserUpdate),
    prefix="/users",
    tags=["users"],
)
app.include_router(routes.meta())
app.include_router(user_router, prefix="/user", tags=["user"])
