from pyexpat import model

from fastapi import Depends, APIRouter
from sqlalchemy.orm import Session
from app import database, models, hashing, schemas
from fastapi.security import OAuth2PasswordRequestForm
from app.repository import auth
from app import token

router = APIRouter(
    prefix="/auth",
    tags=['Auth']
)


get_db = database.get_db



@router.post('/login', response_model=schemas.ShowToken)
def login(request: schemas.LoginSchema, db : Session = Depends(get_db)):
    email = request.email
    password = request.password
    return auth.check_user(email, password, db)

@router.post('/logout')
def logout(db : Session = Depends(get_db),  user = Depends(token.get_current_user)):
    return auth.logout(user.id, db)

@router.post('/refresh_token', response_model=schemas.ShowToken)
def refresh(db : Session = Depends(get_db), user = Depends(token.get_current_user)):
    return auth.refresh(user, db)


