from fastapi import APIRouter

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


@router.get("/{path:path}")
async def page_not_found(path: str):
    return {"message": "Page Not Found"}
