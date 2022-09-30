from sqlalchemy.orm import Session
from app import models
from fastapi import HTTPException, status
from app.repository import token as devToken
from app.hashing import Hash

def check_user(username, password, db : Session):
    user = db.query(models.User).filter(models.User.email == username).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"User with the email {username} is not available")
    if not Hash.verify(user.password, password):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail="Incorrect email or password")
    # To do - create token
    return devToken.create_session(user.id, db)

def logout(id, db: Session):
    user_token = db.query(models.Token).filter(models.Token.user_id== id).one_or_none()
    if not user_token:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    
    devToken.delete_session(user_token.token, db)
    return {"message": "Logged out"}

def refresh(user, db):
    user_token = db.query(models.Token).filter(models.Token.user_id== user.id).one_or_none()
    if not user_token:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    return devToken.refresh_token(user_token.token, db)
    