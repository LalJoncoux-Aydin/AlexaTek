from typing import List, Optional
from pydantic import BaseModel



class User(BaseModel):
    name:str
    surname: str
    email:str
    password:str
    group: int
    acq: Optional[str]
    contract: Optional[str]
    sup: Optional[str]
    
class UserUpdateAdmin(BaseModel):
    name:str
    surname: str
    email:str
    group: int
    acq: Optional[str]
    contract: Optional[str]
    sup: Optional[str]

class ShowUser(BaseModel):
    name:str
    surname: str
    email:str
    group: int
    acq: Optional[str]
    contract: Optional[str]
    sup: Optional[str]
    
    class Config():
        orm_mode = True

class LoginSchema(BaseModel):
    email:str
    password:str

class Token(BaseModel):
    token           :str
    refresh_token   :str
    expire_at       :int
    refresh_expire  :int
    user_id         :int

class ShowToken(BaseModel):
    token:str

    class Config():
        orm_mode = True
