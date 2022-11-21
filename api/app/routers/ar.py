from fastapi import Depends, APIRouter
from sqlalchemy.orm import Session
from app import database, models, hashing, schemas
from app.repository import ar
from app import token


router = APIRouter(
    prefix="/arduino",
    tags=['Arduino']
)


get_db = database.get_db


@router.get('/get_module')
def get():
    return ar.get_module()


@router.get('/get_luminosity')
def get():
    return ar.get_lumos()

@router.get('/get_temperature')
def get():
    return ar.get_temp()


@router.get('/get_led/{id}')
def get(id: str):
    return ar.get_led_status(id)

@router.get('/get_rgb/{id}')
def get(id: str):
    return ar.get_rgb_status(id)

@router.post('/action')
def post(action: schemas.Action):
    return ar.put_action(action)