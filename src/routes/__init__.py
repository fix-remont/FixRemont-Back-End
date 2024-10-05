from fastapi import APIRouter

from . import additional_options, contracts, faqs, flat_additional_options, flats, notification_types, paragraphs, \
    platform_news, posts, project_types, styles, tariffs, user_types, users, work_statuses, works, api


def meta() -> APIRouter:
    meta_router = APIRouter()
    meta_router.include_router(api.router)

    # meta_router.include_router(additional_options.router)
    # meta_router.include_router(contracts.router)
    # meta_router.include_router(faqs.router)
    # meta_router.include_router(flat_additional_options.router)
    # meta_router.include_router(flats.router)
    # meta_router.include_router(notification_types.router)
    # meta_router.include_router(paragraphs.router)
    # meta_router.include_router(platform_news.router)
    # meta_router.include_router(posts.router)
    # meta_router.include_router(project_types.router)
    # meta_router.include_router(styles.router)
    # meta_router.include_router(tariffs.router)
    # meta_router.include_router(user_types.router)
    # meta_router.include_router(users.router)
    # meta_router.include_router(work_statuses.router)
    # meta_router.include_router(works.router)

    return meta_router
