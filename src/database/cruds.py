from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from src.database import models
from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from src.database import models, schemas


async def get_portfolio_posts(db: AsyncSession):
    result = db.execute(select(models.Work))
    all_works = result.scalars().all()

    portfolio_posts = []
    for work in all_works:
        portfolio_posts.append({
            "id": work.id,
            "title": work.title,
            "deadline": work.deadline,
            "cost": work.cost,
            "square": work.square,
            "video_link": work.video_link,
            "video_duration": int(work.video_duration),
            "project_type": work.project_type,
            "images": [work.image1, work.image2, work.image3, work.image4, work.image5],
            "articles": work.description
        })

    return portfolio_posts


from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from src.database import models, schemas

async def create_portfolio_post(portfolio_post: schemas.PortfolioPostSchema, db: AsyncSession):
    # Fetch the ProjectType instance from the database
    result = db.execute(select(models.ProjectType).filter_by(name=portfolio_post.project_type.name))
    project_type_instance = result.scalars().first()
    # Convert articles to a list of dictionaries
    articles = [f"{article.title}: {article.body}" for article in portfolio_post.articles] if portfolio_post.articles else []

    new_portfolio_post = models.Work(
        title=portfolio_post.title,
        deadline=portfolio_post.deadline,
        cost=portfolio_post.cost,
        square=portfolio_post.square,
        video_link=portfolio_post.video_link,
        video_duration=str(portfolio_post.video_duration),
        project_type_id=project_type_instance.id,
        image1=portfolio_post.images[0] if portfolio_post.images else None,
        image2=portfolio_post.images[1] if len(portfolio_post.images) > 1 else None,
        image3=portfolio_post.images[2] if len(portfolio_post.images) > 2 else None,
        image4=portfolio_post.images[3] if len(portfolio_post.images) > 3 else None,
        image5=portfolio_post.images[4] if len(portfolio_post.images) > 4 else None,
        description=articles
    )

    db.add(new_portfolio_post)
    db.commit()
    db.refresh(new_portfolio_post)

    # Convert the SQLAlchemy model instance to a Pydantic model instance
    return schemas.PortfolioPostSchema.from_orm(new_portfolio_post)