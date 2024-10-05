# from typing import List, Optional
#
# from fastapi import APIRouter, Depends, HTTPException
# from sqlalchemy.ext.asyncio import AsyncSession
# from src.database import crud, schemas
# from src.database.db import get_db
#
# router = APIRouter()
#
#
# # Contract routes
# @router.post("/contracts/", response_model=schemas.ContractSchema)
# async def create_contract(contract: schemas.ContractSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.create_contract(contract, db)
#
#
# @router.get("/contracts/{contract_id}", response_model=schemas.ContractSchema)
# async def get_contract(contract_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.get_contract(contract_id, db)
#
#
# @router.get("/contracts/", response_model=List[schemas.ContractSchema])
# async def get_all_contracts(db: AsyncSession = Depends(get_db)):
#     return await crud.get_all_contracts(db)
#
#
# @router.put("/contracts/{contract_id}", response_model=schemas.ContractSchema)
# async def update_contract(contract_id: int, contract: schemas.ContractSchema, db: AsyncSession = Depends(get_db)):
#     return await crud.update_contract(contract_id, contract, db)
#
#
# @router.delete("/contracts/{contract_id}", response_model=schemas.ContractSchema)
# async def delete_contract(contract_id: int, db: AsyncSession = Depends(get_db)):
#     return await crud.delete_contract(contract_id, db)
