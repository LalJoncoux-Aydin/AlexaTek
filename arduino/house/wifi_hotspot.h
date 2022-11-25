/*
 * Simple WiFiManager usage
 * https://www.mischianti.org/
 *
 * The MIT License (MIT)
 * written by Renzo Mischianti <www.mischianti.org>
 */
 
#include <ESP8266WiFi.h>        
 
//needed for library
#include <DNSServer.h>
#include <ESP8266WebServer.h>
#include "WiFiManager.h"          //https://github.com/tzapu/WiFiManager
 
void configModeCallback (WiFiManager *myWiFiManager) {
  Serial.println("Entered config mode");
  Serial.println(WiFi.softAPIP());
  //if you used auto generated SSID, print it
  Serial.println(myWiFiManager->getConfigPortalSSID());
}
 
void setupWifiHotspot() {
   
  WiFiManager wifiManager;
  wifiManager.setAPCallback(configModeCallback);
 
  if(!wifiManager.autoConnect("esp8266 hotspot")) {
    Serial.println("failed to connect and hit timeout");
    ESP.reset();
    delay(1000);
  } 
 
  Serial.println(F("WIFIManager connected!"));
 
  Serial.print(F("IP --> "));
  Serial.println(WiFi.localIP());
  Serial.print(F("GW --> "));
  Serial.println(WiFi.gatewayIP());
  Serial.print(F("SM --> "));
  Serial.println(WiFi.subnetMask());
 
  Serial.print(F("DNS 1 --> "));
  Serial.println(WiFi.dnsIP(0));
 
  Serial.print(F("DNS 2 --> "));
  Serial.println(WiFi.dnsIP(1));
  
}