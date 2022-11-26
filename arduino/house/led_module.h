#include "module.h"
#include <ArduinoJson.h>

#define TURN_ON_LED 1
#define TURN_OFF_LED 2
#ifndef LED_MODULE
#define LED_MODULE

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