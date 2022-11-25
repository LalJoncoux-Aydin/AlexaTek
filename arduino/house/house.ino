#include <PubSubClient.h>
#include "wifi_hotspot.h"
#include "fonctions.h"
#include <ArduinoJson.h>

WiFiClientSecure espClient;
PubSubClient client(espClient);
char *mqtt_server = "mqtt.agrothink.tech";
int mqttPort = 8883;
static const char *fingerprint PROGMEM = "38 D1 32 A3 86 D0 B4 F9 6F F6 B1 30 C6 CF BD 5A B1 F3 55 FB";
const char *topic_listen_luminosity = "losson/luminosity";
const char *topic_listen_temperature = "losson/temperature";
const char *topic_action = "losson/action";
char topic_char[30];

void deserializeMQTT(char *payload) {
  Serial.println(payload);
  StaticJsonDocument<200> doc;
  deserializeJson(doc, payload);

  char id = doc["id"];
  Serial.println("Print l'id batard");
  Serial.println(String(id));
  if (id == '1') {
    Serial.println("Fils dup");
    String arg1= doc["args"][0];
    Serial.println(arg1);
  }
  if (id == '2') {
    String arg1= doc["args"][0];
    String arg2= doc["args"][1];
    String arg3= doc["args"][2];
    Serial.println(arg1);
    Serial.println(arg2);
    Serial.println(arg3);
  }
  if (id == '3') {
    //servo1
  }
  if (id == '4') {
    //servo2
  }

}

void callback(char* topic, byte *payload, unsigned int length) {
   Serial.println((char *)payload);
   if (strcoll(topic, topic_listen_luminosity) == 0) {
     if (payload[0] == 'g') {
      String str = String(getLuminosityValue());
      str.toCharArray(topic_char, str.length() + 1);
      client.publish(topic_listen_luminosity, topic_char);
     }
   }
   if (strcoll(topic, topic_listen_temperature) == 0) {
     if (payload[0] == 'g') {
      //String str = String(getTemperature());
      //str.toCharArray(topic_char, str.length() + 1);
      client.publish(topic_listen_luminosity, "21");
     }
   }
   if (strcoll(topic, topic_action) == 0) {
      deserializeMQTT((char*)payload);
   }
   
   //
 }
 
void reconnect(){
  while (!client.connected()) {
    Serial.println("Connection au serveur MQTT ...");
    if (client.connect("ESP8266Client", "iot_epitech", "llosson")) {
      Serial.println("MQTT connecté");
    }
    else {
      Serial.print("echec, code erreur= ");
      Serial.println(client.state());
      Serial.println("nouvel essai dans 2s");
    delay(2000);
    }
  }
  client.subscribe(topic_listen_temperature);//souscription au topic led pour commander une led
  client.subscribe(topic_listen_luminosity);
  client.subscribe(topic_action);
  Serial.println(topic_action);
}


void setup() {
  servo1.attach(15);
  pinMode(pinT, OUTPUT);
  pinMode(pinC, OUTPUT);
  pinMode(pinBlue, OUTPUT);
  pinMode(pinRed, OUTPUT);
  pinMode(pinGreen, OUTPUT);
  pinMode(pinLed, OUTPUT);
  // put your setup code here, to run once:
  Serial.begin(115200);
  setupModules();
  //setupWifiHotspot();
  WiFi.begin("Honolulu_EXT", "AnemoneGalata");  
  espClient.setFingerprint(fingerprint);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
   client.setServer(mqtt_server, mqttPort);
   client.setCallback(callback);//Déclaration de la fonction de souscription
   reconnect();

}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  // put your main code here, to run repeatedly:
  client.loop();

}
