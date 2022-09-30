from sqlalchemy.orm import Session
from app import models
from fastapi import  HTTPException, status
from fastapi.security import APIKeyHeader
import os
import time
from datetime import datetime
import binascii
TOKEN_LIFE_DURATION = 3600


api_key = APIKeyHeader(name="X-API-KEY")


def generate_key():
    return binascii.hexlify(os.urandom(20)).decode()

def get_session(user_id: int, db: Session):
    token = db.query(models.Token).filter(models.Token.user_id == user_id).one_or_none()
    if not token:
        return None
    return token

def create_session(user_id: int, db: Session):
    ttoken = get_session(user_id, db)
    if ttoken:
        print("Token already exists")
        delete_session(ttoken.token, db)
    ts = int(time.time()) + TOKEN_LIFE_DURATION# Timestamp + 1 hour
    nts = ts + (3 * TOKEN_LIFE_DURATION)
    ts2 = datetime.fromtimestamp(ts)
    nts2 = datetime.fromtimestamp(nts)
    new_token = models.Token(token=generate_key(),refresh_token=generate_key(),expire_at=ts2, refresh_expire=nts2,user_id=user_id)
    db.add(new_token)
    db.commit()
    db.refresh(new_token)
    return new_token

def delete_session(ttoken: str, db : Session):
    token = db.query(models.Token).filter(models.Token.token == ttoken).delete()
    if not token:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Token not found")
    db.commit()
    return {"message": "Token deleted"}

def check_token(ttoken: str, db : Session):
    token = db.query(models.Token).filter(models.Token.token == ttoken).first()
    if not token:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Token not found")
    if datetime.timestamp(token.expire_at) < int(time.time()):
        raise HTTPException(status_code=status.HTTP_426_UPGRADE_REQUIRED, detail="Token expired")
    return db.query(models.User).filter(models.User.id == token.user_id).first()


def refresh_token(ttoken: str, db : Session):
    token = db.query(models.Token).filter(models.Token.refresh_token == ttoken).first()
    if not token:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Token not found")
    if datetime.timestamp(token.refresh_expire) < int(time.time()):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="_removetoken")
    db.query(models.Token).filter(models.Token.token == ttoken).update(token=generate_key(),expire_at=int(time.time()) + TOKEN_LIFE_DURATION)
    db.commit()
    return token
