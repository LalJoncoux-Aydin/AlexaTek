#include "module.h"
#include <ArduinoJson.h>
#include <Servo.h> 

#define TURN_LEFT 1
#define TURN_RIGHT 2
#ifndef SERVO_MODULE
#define SERVO_MODULE

class ServoModule: public Module {
  public:
    int servoPin;
    Servo servo;
    int current_angle = 0;
    ServoModule(int id, int servoPin) {this->id = id; this->servoPin = servoPin; this->setupServo();};

  void executeAction(int method, String *args) override {
    int angle = args[0].toInt();
    if (method == TURN_LEFT) {
      this->turnLeft(angle);
    }
    if (method == TURN_RIGHT) {
      this->turnRight(angle);
    }
  }

  String getModuleInfo() {
    DynamicJsonDocument doc(1024);
    doc["methods"][0]["method_name"] = "Turn left the servo";
    doc["methods"][0]["id"] = TURN_LEFT;
    doc["methods"][0]["args"][0] = "integer";
    doc["methods"][1]["method_name"] = "Turn right the servo";
    doc["methods"][1]["id"] = TURN_RIGHT;
    doc["methods"][1]["args"][0] = "integer";
    String output;
    serializeJson(doc, output);
    return output;
  }

  int getIdModule() {
    return this->id;
  }
  void setupServo() {
    servo.attach(this->servoPin);
   // pinMode(this->ledPin, OUTPUT);
  }

 void turnLeft(int angle) {
   int angle_local = current_angle;
    for (; angle_local < current_angle + angle; angle_local++) {
      servo.write(angle_local);
    }
    current_angle = angle_local;
    Serial.println(current_angle);
  }

void turnRight(int angle) {
  Serial.write(current_angle);
    int angle_local = current_angle;
    for (; angle_local > current_angle - angle; angle_local--) {
      servo.write(angle_local);
    }
    current_angle = angle_local;
    Serial.println(current_angle);

  }
};

#endif