# src/auth/dependencies.py
from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from src.database.models import User
from src.database.db import get_db
from src.database.utils import decode_token

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


async def get_current_user(token: str = Depends(oauth2_scheme), session: AsyncSession = Depends(get_db)):
    # This is a placeholder function. You need to implement token verification and user retrieval.
    # For example, decode the token and get the user ID, then fetch the user from the database.
    user_id = decode_token(token)  # Implement this function to decode the token and extract user ID
    result = await session.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    if not user:
        raise HTTPException(status_code=401, detail="Invalid authentication credentials")
    return user


async def current_active_user(current_user: User = Depends(get_current_user)):
    return current_user
