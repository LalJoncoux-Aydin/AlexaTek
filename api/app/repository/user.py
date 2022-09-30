from sqlalchemy import true
from sqlalchemy.orm import Session
from app import models, schemas
from fastapi import HTTPException, status
from app.hashing import Hash



class UserRepository:
    def create(request: schemas.User, db: Session):
        new_user = models.User(
            name=request.name, surname=request.surname, email=request.email, password=Hash.bcrypt(request.password), group=request.group, acq=request.acq, contract=request.contract, sup=request.sup)
        db.add(new_user)
        db.commit()
        db.refresh(new_user)
        return new_user


    def show(token: str, db: Session):
        user_token = db.query(models.User).filter(models.Token.token == token).first()
        if not user_token:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"User with the token {token} is not available")
        user = db.query(models.User).filter(models.User.id == user_token.id).first()
        return user
    
    
    def get_all(db: Session, user):
        if user.group != 0:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Access denied")
        return db.query(models.User).all()
    
    def delete_user(email, db: Session, user):
        if user.group != 0:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Access denied")
        user_to_delete = db.query(models.User).filter(models.User.email == email).first()
        if not user_to_delete:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
        db.delete(user_to_delete)
        db.commit()
        return {"message": "User deleted"}
    
    def update_user(email, request: schemas.User, db: Session, user):
        if user.group != 0:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Access denied")
        user = db.query(models.User).filter(models.User.email == request.email).first()
        if not user:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
        db.query(models.User).filter(models.User.email == email).update({"name": request.name, "surname": request.surname, "email": request.email, "group": request.group, "acq": request.acq, "contract": request.contract, "sup": request.sup})
        db.commit()
        return {"message": "User updated"}
    
    def check_admin(user: models.User):
        if user.group == 0:
            return True
        else:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="You are not an admin")