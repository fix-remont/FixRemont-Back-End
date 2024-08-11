from fastapi import APIRouter, Depends
from users.db import User
from users.users import current_active_user

router = APIRouter()


@router.get("/main")
async def main_page(user: User = Depends(current_active_user)):
    return {"message": f"Welcome to the main page, {user.email}!"}


@router.get("/wallet")
async def wallet_page(user: User = Depends(current_active_user)):
    return {"message": f"Wallet page for {user.email}, User Type: {user.user_type}"}


@router.get("/contracts")
async def contracts_page(user: User = Depends(current_active_user)):
    return {"message": f"Contracts page for {user.email}, User Type: {user.user_type}"}


@router.get("/profile")
async def profile_page(user: User = Depends(current_active_user)):
    return {"message": f"Profile page for {user.email}, User Type: {user.user_type}"}


@router.get("/news")
async def news_page(user: User = Depends(current_active_user)):
    return {"message": f"News page for {user.email}, User Type: {user.user_type}"}


@router.get("/support")
async def support_page(user: User = Depends(current_active_user)):
    return {"message": f"Support page for {user.email}, User Type: {user.user_type}"}


@router.get("/partnership")
async def partnership_page(user: User = Depends(current_active_user)):
    return {"message": f"Partnership page for {user.email}, User Type: {user.user_type}"}
