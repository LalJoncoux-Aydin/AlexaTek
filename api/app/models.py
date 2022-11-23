from sqlalchemy import TIME, Column, Integer, String, ForeignKey, TIMESTAMP, Float
from app.database import Base



class User(Base):
    __tablename__   = 'users'
    id              = Column(Integer, primary_key=True, index=True)
    name            = Column(String)
    surname         = Column(String)
    email           = Column(String)
    password        = Column(String)
    group           = Column(Integer)



class Token(Base):
    __tablename__   = 'tokens'
    id              = Column(Integer, primary_key=True, index=True)
    token           = Column(String)
    refresh_token   = Column(String)
    expire_at       = Column(TIMESTAMP)
    refresh_expire  = Column(TIMESTAMP)
    user_id         = Column(Integer, ForeignKey('users.id'))


