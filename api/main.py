from fastapi import FastAPI
from app import  models
from app.database import engine
from app.routers import user, authentication
from fastapi.middleware.cors import CORSMiddleware
from fastapi_mqtt import FastMQTT, MQTTConfig

app = FastAPI()

origins = [
    "http://localhost:3000",
    "http://localhost:8080",
    "http://localhost:8081",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

mqtt_config = MQTTConfig()

mqtt = FastMQTT(
    config=MQTTConfig(host = "broker.emqx.io", port = 1883, username = "", password = "")
)

mqtt.init_app(app)
#mqtt.publish("testtopic/lolosson", "Hello World")

models.Base.metadata.create_all(engine)

app.include_router(authentication.router)
app.include_router(user.router)





@mqtt.on_connect()
def connect(client, flags, rc, properties):
    mqtt.client.subscribe("/mqtt") #subscribing mqtt topic
    print("Connected: ", client, flags, rc, properties)

@mqtt.on_message()
async def message(client, topic, payload, qos, properties):
    print("Received message: ",topic, payload.decode(), qos, properties)

@mqtt.subscribe("testtopic/lolosson")
async def message_to_topic(client, topic, payload, qos, properties):
    print("Received message to specific topic: ", topic, payload.decode(), qos, properties)

@mqtt.on_disconnect()
def disconnect(client, packet, exc=None):
    print("Disconnected")

# @mqtt.publish("testtopic/lolosson", "Hello World")
# def publish(client, topic, payload, qos, properties):

@mqtt.on_subscribe()
def subscribe(client, mid, qos, properties):
    print("subscribed", client, mid, qos, properties)