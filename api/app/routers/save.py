from fastapi import APIRouter, HTTPException
from app import database, schemas, models
from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status
from app.repository.user import UserRepository
from app import token
from typing import List

router = APIRouter(
    prefix="/save",
    tags=['Save']
)

get_db = database.get_db


@router.post('/', response_model=schemas.ShowSave)
def create_user(request: schemas.Save,  user = Depends(token.get_current_user), db: Session = Depends(get_db)):
    re = db.query(models.Save).filter(models.Save.user_id == user.id).one_or_none()
    if re:
        db.delete(re)
        db.commit()
    new_save = models.Save(
        user_id=user.id,
        led=request.led, r=request.r, g=request.g, b=request.b,
        servo=request.servo)
    db.add(new_save)
    db.commit()
    db.refresh(new_save)
    return new_save

@router.get('/get', response_model=schemas.ShowSave)
def get_save(db: Session = Depends(get_db), user = Depends(token.get_current_user)):
    re = db.query(models.Save).filter(models.Save.user_id == user.id).one_or_none()
    if not re:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="No saves found")
    return re

@router.delete('/delete')
def delete_save(db: Session = Depends(get_db), user = Depends(token.get_current_user)):
    re = db.query(models.Save).filter(models.Save.user_id == user.id).all()
    if not re:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    for save in re:
        db.delete(save)
        db.commit()
    return {"msg": "delete saves"}
