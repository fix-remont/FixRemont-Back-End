from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import declarative_base

SQLALCHEMY_DATABASE_URL = "postgresql+asyncpg://postgres:sdr@localhost:5432/postgres"

engine = create_async_engine(SQLALCHEMY_DATABASE_URL)
AsyncSessionLocal = async_sessionmaker(autocommit=False, class_=AsyncSession, autoflush=False, bind=engine)

Base = declarative_base()


async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)


async def get_db():
    session = AsyncSessionLocal()
    try:
        yield session
    finally:
        await session.close()
