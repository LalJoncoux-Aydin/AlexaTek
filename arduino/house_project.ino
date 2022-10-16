const char* ssid = "Honolulu_EXT"; //Replace with your own SSID
const char* password = "AnemoneGalata"; //Replace with your own password#include <ESPAsyncTCP.h>

#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include "led_module.h"
#include "protocol.h"

const int ledPin = 14;
WiFiClient espClient;
PubSubClient client(espClient);
char *mqtt_server = "broker.emqx.io";
int mqttPort = 1883;
//auto lm = LedModule(14);
auto protocol = HouseProtocol();

void callback(char* topic, byte *payload, unsigned int length) {
   Serial.println("-------Nouveau message du broker mqtt-----");
   Serial.print("Canal:");
   Serial.println(topic);
   Serial.print("donnee:");
   Serial.write(payload, length);
   Serial.println();
   protocol.deserializeMQTT((char*)payload);
   if ((char)payload[0] == '1') {
     Serial.println("LED ON");
     
   } else {
     Serial.println("LED OFF");
     
   }
 }
 
void reconnect(){
  while (!client.connected()) {
    Serial.println("Connection au serveur MQTT ...");
    if (client.connect("ESP32Client")) {
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
  WiFi.begin(ssid, password);
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
