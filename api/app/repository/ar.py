import json
import random
from .. import schemas
import paho.mqtt.client as mqtt
import time
import os


TIMEOUT = 4
MAIN_LOGFILE = "main.log"

MODULE_LIST = [{"id": 1, "name": "led"}, {"id": 2, "name": "rgb"}, {"id": 3, "name": "servo1"}, {"id": 4, "name": "servo2"}]


def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc), flush=True)



def on_message_lumos(client, userdata, msg):
    if (msg.payload.decode()[0] != 'g'):
        try:
            with open(f"{os.environ['SEED_L']}.log", 'w') as f:
                f.write(msg.payload.decode())
                
            print(f"Received message: {msg.payload.decode()}", flush=True)
        except Exception as e:
            print(e, flush=True)

def on_message_temp(client, userdata, msg):
    if (msg.payload.decode()[0] != 'g'):
        try:
            with open(f"{os.environ['SEED_T']}.log", 'w') as f:
                f.write(msg.payload.decode())
                
            print(f"Received message: {msg.payload.decode()}", flush=True)
        except Exception as e:
            print(e, flush=True)


def on_message_led(client, userdata, msg):
    # check if not an int
    try:
        int(msg.payload.decode())
    except Exception as e:
        try:
            with open(f"{os.environ['SEED_L']}.log", 'w') as f:
                f.write(msg.payload.decode())
                
            print(f"Received message: {msg.payload.decode()}", flush=True)
        except Exception as e:
            print(e, flush=True)

def on_message_rgb(client, userdata, msg):
    try:
        int(msg.payload.decode())
    except Exception as e:
        try:
            with open(f"{os.environ['SEED_R']}.log", 'w') as f:
                f.write(msg.payload.decode())
                
            print(f"Received message: {msg.payload.decode()}", flush=True)
        except Exception as e:
            print(e, flush=True)

def on_message_action(client, userdata, msg):
    try:
        with open(f"{os.environ['SEED_A']}.log", 'w') as f:
            f.write(msg.payload.decode())
            
        print(f"Received message: {msg.payload.decode()}", flush=True)
    except Exception as e:
        print(e, flush=True)
        

def get_module():
    return {"modules": MODULE_LIST}


def get_lumos():
    seed = random.randint(0, 1000000)
    os.environ["SEED_L"] = str(seed)
    client = mqtt.Client()
    client.on_connect = on_connect
    
    client.on_message = on_message_lumos
    client.username_pw_set("iot_epitech", "llosson")
    client.tls_set()
    client.connect("mqtt.agrothink.tech", 8883, 60)
    client.loop_start()
    
    client.publish("losson/luminosité", "g", qos=0)
    client.subscribe("losson/luminosité", qos=0)
    
    time.sleep(TIMEOUT)
    client.loop_stop()
    client.disconnect()
    
    
    if os.path.exists(f"{seed}.log"):

        resp = json.loads(open(f"{seed}.log", 'r').read())["msg"]
        os.remove(f"{seed}.log")
        
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] luminosity | Success | value: {resp} \n")

        return {"data": resp}
    else:
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] luminosity | Failed | value: None \n")
        return  {"error": "no result", "debug": "no file", "seed": seed, "data": 2}


def get_temp():
    seed = random.randint(0, 1000000)
    os.environ["SEED_T"] = str(seed)
    client = mqtt.Client()
    client.on_connect = on_connect
    
    client.on_message = on_message_temp
    client.username_pw_set("iot_epitech", "llosson")
    client.tls_set()
    client.connect("mqtt.agrothink.tech", 8883, 60)
    client.loop_start()
    client.subscribe("losson/temperature", qos=0)
    
    client.publish("losson/temperature", "g", qos=0)
    time.sleep(TIMEOUT)
    client.loop_stop()
    client.disconnect()
    
    
    if os.path.exists(f"{seed}.log"):

        resp =open(f"{seed}.log", 'r').read()
        os.remove(f"{seed}.log")
        
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] temp | Success | value: {resp} \n")

        return {"data": resp}
    else:
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] temp | Failed | value: None \n")
        return  {"error": "no result", "debug": "no file", "seed": seed, "data": 2}


def put_action(data : schemas.Action):
    seed = random.randint(0, 1000000)
    os.environ["SEED"] = str(seed)
    client = mqtt.Client()
    client.on_connect = on_connect
    
    client.on_message = on_message_action
    client.username_pw_set("iot_epitech", "llosson")
    client.tls_set()
    client.connect("mqtt.agrothink.tech", 8883, 60)
    client.loop_start()
    (result,mid)= client.publish("losson/action", json.dumps({"id": data.id, "args": data.args}), qos=0)
    time.sleep(TIMEOUT)
    client.loop_stop()
    client.disconnect()
    if result == 0:
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [PUT] action | Success | value: {data} \n")
        return {"data": "ok"}
    else:
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [PUT] action | Failed | value: {data} \n")
        return {"data": "ko"}



def get_led_status(id : int):
    seed = random.randint(0, 1000000)
    os.environ["SEED_L"] = str(seed)
    client = mqtt.Client()
    client.on_connect = on_connect
    
    client.on_message = on_message_led
    client.username_pw_set("iot_epitech", "llosson")
    client.tls_set()
    client.connect("mqtt.agrothink.tech", 8883, 60)
    client.loop_start()
    client.subscribe("losson/led", qos=0)
    
    client.publish("losson/led", id, qos=0)
    time.sleep(TIMEOUT)
    client.loop_stop()
    client.disconnect()
    
    
    if os.path.exists(f"{seed}.log"):

        resp = json.loads(open(f"{seed}.log", 'r').read())
        os.remove(f"{seed}.log")
        
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] led | Success | value: {resp} \n")

        return {"data": resp}
    else:
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] led | Failed | value: None \n")
        return  {"error": "no result", "debug": "no file", "seed": seed, "data": "off"}



def get_rgb_status(id : int):
    seed = random.randint(0, 1000000)
    os.environ["SEED_R"] = str(seed)
    client = mqtt.Client()
    client.on_connect = on_connect
    
    client.on_message = on_message_rgb
    client.username_pw_set("iot_epitech", "llosson")
    client.tls_set()
    client.connect("mqtt.agrothink.tech", 8883, 60)
    client.loop_start()
    client.subscribe("losson/rgb", qos=0)
    
    client.publish("losson/rgb", id, qos=0)
    time.sleep(TIMEOUT)
    client.loop_stop()
    client.disconnect()
    
    
    if os.path.exists(f"{seed}.log"):

        resp = json.loads(open(f"{seed}.log", 'r').read())
        os.remove(f"{seed}.log")
        
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] rgb | Success | value: {resp} \n")

        return {"data": schemas.StatusRGB(on=resp["on"], r=resp["r"], g=resp["g"], b=resp["b"])}
    else:
        with open(MAIN_LOGFILE, 'a') as f:
            f.write(f"{time.time()} [ACTION] [GET] rgb | Failed | value: None \n")
        return  {"error": "no result", "debug": "no file", "seed": seed, "data": schemas.StatusRGB(on=False, r=0, g=0, b=0)}