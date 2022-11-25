#include "module.h"
#include <ArduinoJson.h>

#define TURN_ON_LED 1
#define TURN_OFF_LED 2
#ifndef LED_MODULE
#define LED_MODULE

class LedModule: public Module {
  public:
    int ledPin;
    LedModule(int id, int led_pin) {this->id = id; this->ledPin = led_pin; this->setup_led();};

  void executeAction(int method, String *args) override {
    if (method == TURN_ON_LED) {
      this->turnOnLed();
    }
    if (method == TURN_OFF_LED) {
      this->turnOffLed();
    }
  }

  String getModuleInfo() {
    DynamicJsonDocument doc(1024);
    doc["methods"][0]["method_name"] = "Turn On Led";
    doc["methods"][0]["id"] = TURN_ON_LED;
    doc["methods"][0]["args"][0] = "";
    doc["methods"][1]["method_name"] = "Turn Off Led";
    doc["methods"][1]["id"] = TURN_OFF_LED;
    doc["methods"][1]["args"][0] = "";
    String output;
    serializeJson(doc, output);
    return output;
  }

  int getIdModule() {
    return this->id;
  }
  void setup_led() {
    pinMode(this->ledPin, OUTPUT);
  }

 void turnOnLed() {
    digitalWrite(this->ledPin, HIGH);
  }

void turnOffLed() {
    digitalWrite(this->ledPin, LOW);
  }
};

#endif