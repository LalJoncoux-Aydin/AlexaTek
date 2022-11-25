#include <PubSubClient.h>
#include "wifi_hotspot.h"

WiFiClientSecure espClient;
PubSubClient client(espClient);
char *mqtt_server = "mqtt.agrothink.tech";
int mqttPort = 8883;

static const char *fingerprint PROGMEM = "38 D1 32 A3 86 D0 B4 F9 6F F6 B1 30 C6 CF BD 5A B1 F3 55 FB";

void callback(char* topic, byte *payload, unsigned int length) {
   Serial.println("-------Nouveau message du broker mqtt-----");
   Serial.print("Canal:");
   Serial.println(topic);
   Serial.print("donnee:");
   Serial.write(payload, length);
   Serial.println();
   //protocol.deserializeMQTT((char*)payload);
   if ((char)payload[0] == '1') {
     Serial.println("LED ON");
     
   } else {
     Serial.println("LED OFF");
     
   }
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
  client.subscribe("lolosson");//souscription au topic led pour commander une led
  Serial.println("Subscribed to topic lolosson");
}


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  setupWifiHotspot();
  espClient.setFingerprint(fingerprint);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
   client.setServer(mqtt_server, mqttPort);
   client.setCallback(callback);//Déclaration de la fonction de souscription
   reconnect();
   client.publish("testtopic/lolosson", "Hello from ESP8266");

}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  // put your main code here, to run repeatedly:
  client.loop();

}
