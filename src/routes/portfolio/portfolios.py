from fastapi import APIRouter

router = APIRouter()


@router.get("/portfolio")
async def portfolio():
    return {"message": "Portfolio"}


@router.get("/portfolio/work1")
async def work1():
    return {"message": "Work1"}
