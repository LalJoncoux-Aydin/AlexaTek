from fastapi import APIRouter
from app import database, schemas, models
from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status
from app.repository.user import UserRepository
from app import token
from typing import List

router = APIRouter(
    prefix="/user",
    tags=['Users']
)

get_db = database.get_db


@router.post('/', response_model=schemas.ShowUser)
def create_user(request: schemas.User, db: Session = Depends(get_db)):
    return UserRepository.create(request, db)

@router.get('/get', response_model=schemas.ShowUser)
def get_user(db: Session = Depends(get_db), user = Depends(token.get_current_user)):
    return user

@router.get('/getAll', response_model=List[schemas.ShowUser])
def get_all_user(db: Session = Depends(get_db), user = Depends(token.get_current_user)):
    return UserRepository.get_all(db, user)

@router.delete('/{email}')
def delete_user(email: str, db: Session = Depends(get_db), user = Depends(token.get_current_user)):
    return UserRepository.delete_user(email, db, user)

@router.put('/{email}')
def update_user(email: str, request: schemas.UserUpdateAdmin, db: Session = Depends(get_db), user = Depends(token.get_current_user)):
    return UserRepository.update_user(email, request, db, user)