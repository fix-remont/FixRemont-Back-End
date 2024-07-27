from fastapi import APIRouter

router = APIRouter()


@router.get("/blog")
async def blog():
    return {"message": "Blog"}


@router.get("/blog/calculator-guide")
async def post1():
    return {"message": "Calculator Guide"}
