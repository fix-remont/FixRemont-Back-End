from fastapi import APIRouter, Depends
from users.db import User
from users.users import current_active_user

router = APIRouter()


@router.get("/")
async def home():
    return {"message": "Home"}


@router.get("/contacts")
async def contacts():
    return {"message": "Contacts"}


@router.get("/feedbacks")
async def feedbacks():
    return {"message": "Feedbacks"}


@router.get("/about")
async def about():
    return {"message": "About"}


@router.get("/gratitude")
async def gratitude():
    return {"message": "Gratitude"}


@router.get("/test-authenticated-route")
async def authenticated_route(user: User = Depends(current_active_user)):
    return {"message": f"Hello {user.email}!"}

# @router.get("/{path:path}")
# async def page_not_found(path: str):
#     return {"message": "Page Not Found"}
