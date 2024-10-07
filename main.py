from typing import Any, List
from sqladmin import Admin, ModelView
from starlette.middleware.sessions import SessionMiddleware
from fastapi.middleware.cors import CORSMiddleware
from sqladmin.authentication import AuthenticationBackend
from sqlalchemy.ext.asyncio import AsyncSession
from src.database import crud, models
from src import routes
from src.database import user_routes
from src.database.db import engine, Base
from src.database.schemas import UserResponse, Token
from src.auth.auth_routes import verify_password, create_access_token, decode_token
from fastapi import FastAPI, Depends, HTTPException, status
from sqlalchemy.orm import Session
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi import Request
from admin import *
from src.database.db import get_db
from src.database.cruds import get_user_by_email


class CustomAuthBackend(AuthenticationBackend):
    async def login(self, request: Request) -> bool:
        form_data = await request.form()
        db = get_db()
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
                db = get_db()
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

admin.add_view(UserAdmin)
admin.add_view(ContractAdmin)
admin.add_view(PostAdmin)
admin.add_view(WorkAdmin)
admin.add_view(NotificationAdmin)
admin.add_view(FlatAdmin)
admin.add_view(TariffAdmin)
admin.add_view(StyleAdmin)
admin.add_view(AdditionalOptionAdmin)
admin.add_view(ProjectTypeAdmin)
admin.add_view(ParagraphAdmin)
admin.add_view(FAQAdmin)
admin.add_view(PlatformNewsAdmin)
admin.add_view(WorkStatusAdmin)

# app.include_router(user_routes.router)
app.include_router(routes.meta())


# Register Route
# @app.post("/register", response_model=UserResponse)
# def register(user: UserCreate, db: Session = Depends(get_db)):
#     db_user = get_user_by_email(db, user.email)
#     if db_user:
#         raise HTTPException(status_code=400, detail="Email already registered")
#     return create_user(user, db)


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
@app.post("/logout")
def logout(request: Request):
    request.session.pop("access_token", None)
    return {"message": "Successfully logged out"}
