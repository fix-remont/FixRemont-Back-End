import random
import string
import jwt
from fastapi import HTTPException

def generate_unique_id():
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=16))


# src/database/utils.py


SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"  # Replace with your actual secret key
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
