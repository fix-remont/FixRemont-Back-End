# from fastapi import APIRouter, Depends, HTTPException
# from sqlalchemy.ext.asyncio import AsyncSession
# from sqlalchemy.future import select
# from src.auth.dependencies import current_active_user
# from src.database.models import User, Contract
# from src.database.schemas import ClientCreate, ClientUpdate, ContractCreate, ContractUpdate, ReferralCodeInput
# from src.database.db import get_db
#
# router = APIRouter()
#
#
# # @router.get("/clients")
# # async def get_clients(user: User = Depends(current_active_user), session: AsyncSession = Depends(get_db)):
# #     result = await session.execute(select(Client).where(Client.user_id == user.id))
# #     clients = result.scalars().all()
# #     return clients
# #
# #
# # @router.post("/clients")
# # async def create_client(client: ClientCreate, user: User = Depends(current_active_user),
# #                         session: AsyncSession = Depends(get_db)):
# #     new_client = Client(**client.dict(), user_id=user.id)
# #     session.add(new_client)
# #     await session.commit()
# #     await session.refresh(new_client)
# #     return new_client
# #
# #
# # @router.put("/clients/{client_id}")
# # async def update_client(client_id: int, client: ClientUpdate, user: User = Depends(current_active_user),
# #                         session: AsyncSession = Depends(get_db)):
# #     result = await session.execute(select(Client).where(Client.id == client_id, Client.user_id == user.id))
# #     existing_client = result.scalar_one_or_none()
# #     if not existing_client:
# #         raise HTTPException(status_code=404, detail="Client not found")
# #     for key, value in client.dict(exclude_unset=True).items():
# #         setattr(existing_client, key, value)
# #     await session.commit()
# #     await session.refresh(existing_client)
# #     return existing_client
#
#
# @router.get("/contracts")
# async def get_contracts(user: User = Depends(current_active_user), session: AsyncSession = Depends(get_db)):
#     result = await session.execute(select(Contract).where(Contract.user_id == user.id))
#     contracts = result.scalars().all()
#     return contracts
#
#
# @router.post("/contracts")
# async def create_contract(contract: ContractCreate, user: User = Depends(current_active_user),
#                           session: AsyncSession = Depends(get_db)):
#     new_contract = Contract(**contract.dict(), user_id=user.id)
#     session.add(new_contract)
#     await session.commit()
#     await session.refresh(new_contract)
#     return new_contract
#
#
# @router.put("/contracts/{contract_id}")
# async def update_contract(contract_id: int, contract: ContractUpdate, user: User = Depends(current_active_user),
#                           session: AsyncSession = Depends(get_db)):
#     result = await session.execute(select(Contract).where(Contract.id == contract_id, Contract.user_id == user.id))
#     existing_contract = result.scalar_one_or_none()
#     if not existing_contract:
#         raise HTTPException(status_code=404, detail="Contract not found")
#     for key, value in contract.dict(exclude_unset=True).items():
#         setattr(existing_contract, key, value)
#     await session.commit()
#     await session.refresh(existing_contract)
#     return existing_contract
#
#
# @router.get("/main")
# async def main_page(user: User = Depends(current_active_user)):
#     return {"message": f"Welcome to the main page, {user.email}!"}
#
#
# @router.get("/wallet")
# async def wallet_page(user: User = Depends(current_active_user)):
#     return {"message": f"Wallet page for {user.email}, User Type: {user.user_type}"}
#
#
# @router.get("/profile")
# async def profile_page(user: User = Depends(current_active_user), session: AsyncSession = Depends(get_db)):
#     contracts = await session.execute(select(Contract).where(Contract.user_id == user.id))
#     return {
#         "message": f"Profile page for {user.email}, User Type: {user.user_type}",
#         "contracts": contracts.scalars().all()
#     }
#
#
# @router.get("/news")
# async def news_page(user: User = Depends(current_active_user)):
#     return {"message": f"News page for {user.email}, User Type: {user.user_type}"}
#
#
# @router.get("/support")
# async def support_page(user: User = Depends(current_active_user)):
#     return {"message": f"Support page for {user.email}, User Type: {user.user_type}"}
#
#
# @router.get("/partnership")
# async def partnership_page(user: User = Depends(current_active_user)):
#     return {"message": f"Partnership page for {user.email}, User Type: {user.user_type}"}
#
#
# @router.get("/referral_code")
# async def get_referral_code(user: User = Depends(current_active_user)):
#     return {"referral_code": user.user_referral_code}
#
#
# @router.post("/insert_referral_code")
# async def insert_referral_code(referral_code_input: ReferralCodeInput, user: User = Depends(current_active_user),
#                                session: AsyncSession = Depends(get_db)):
#     referred_user = await session.execute(
#         select(User).where(User.user_referral_code == referral_code_input.user_referral_code))
#     referred_user = referred_user.scalar_one_or_none()
#     if not referred_user:
#         raise HTTPException(status_code=404, detail="Referral code not found")
#     user.referred_by = referral_code_input.user_referral_code
#     await session.commit()
#     await session.refresh(user)
#     return {"message": "Referral code inserted successfully"}
#
#
# @router.get("/admin")
# async def admin_page(user: User = Depends(current_active_user)):
#     return {"message": f"Admin page for {user.email}, User Type: {user.user_type}"}
