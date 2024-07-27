from fastapi import APIRouter

from . import api
from .services import services
from .partnership import partnerships
from .portfolio import portfolios
from .blog import blogs


def meta() -> APIRouter:
    meta_router = APIRouter()

    meta_router.include_router(api.router)
    meta_router.include_router(services.router)
    meta_router.include_router(partnerships.router)
    meta_router.include_router(portfolios.router)
    meta_router.include_router(blogs.router)

    return meta_router
