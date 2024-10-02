from fastapi import APIRouter

from . import api, blogs, partnerships, portfolios, services, flat_renovation


def meta() -> APIRouter:
    meta_router = APIRouter()

    meta_router.include_router(api.router)
    # meta_router.include_router(services.router)
    # meta_router.include_router(partnerships.router)
    # meta_router.include_router(portfolios.router)
    # meta_router.include_router(blogs.router)
    # meta_router.include_router(flat_renovation.router)

    return meta_router
