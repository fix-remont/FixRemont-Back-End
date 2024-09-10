import random
import string


def generate_unique_id():
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=16))


# src/database/utils.py
import jwt
from fastapi import HTTPException

SECRET_KEY = "your_secret_key"  # Replace with your actual secret key
ALGORITHM = "HS256"  # Replace with your actual algorithm


def decode_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id: str = payload.get("sub")
        if user_id is None:
            raise HTTPException(status_code=401, detail="Invalid token")
        return user_id
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Invalid token")
