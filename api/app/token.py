from fastapi import Depends, HTTPException, status
from fastapi.security import APIKeyHeader
from app.repository import token as devToken
from app import database
from sqlalchemy.orm import Session


get_db = database.get_db


def get_current_user(data : str = Depends(APIKeyHeader(name="X-API-KEY")), db : Session = Depends(get_db)):
    return devToken.check_token(data, db)    