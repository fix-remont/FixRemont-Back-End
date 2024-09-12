from typing import Any
from sqladmin.fields import FileField
from src.database import schemas
from src.database.crud import create_post, create_work
import base64
from markupsafe import Markup
from fastapi_storages import FileSystemStorage
from sqladmin import Admin, ModelView
from starlette.middleware.sessions import SessionMiddleware
from fastapi.middleware.cors import CORSMiddleware
from sqladmin.authentication import AuthenticationBackend
from src.database.models import User, Client, Contract, Post, Work
from src import routes
from src.database import user_routes
from src.database.db import get_db, engine, Base
from src.database.models import User
from src.database.schemas import UserCreate, UserResponse, Token
from src.database.crud import create_user
from src.auth.auth_routes import verify_password, create_access_token, decode_token
from fastapi import FastAPI, Depends, HTTPException, status
from sqlalchemy.orm import Session
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi import Request
from src.database.crud import get_user_by_email


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
    secret_key="09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"))


# Add views and routes as needed


class UserAdmin(ModelView, model=User):
    column_list = [User.email]
    column_searchable_list = [User.email]
    can_create = True
    can_edit = True
    can_delete = True

    async def on_model_change(self, data, model, is_created, request):
        # Remove the UUID field from the data dictionary to prevent modification
        data.pop('id', None)
        # Update the model with the remaining data
        for key, value in data.items():
            setattr(model, key, value)


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
                post_type=schemas.PostType(data['post_type']),
                content=data['content'],
                images=images
            )

            for db_session in get_db():
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

app.include_router(user_routes.router)
app.include_router(routes.meta())


# main.py


# Register Route
@app.post("/register", response_model=UserResponse)
def register(user: UserCreate, db: Session = Depends(get_db)):
    db_user = get_user_by_email(db, user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="email already registered")
    return create_user(db, user)


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
