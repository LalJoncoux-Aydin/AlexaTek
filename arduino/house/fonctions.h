
int pinT = 2; //D4 //ok
int pinC = 0; //D3 //ok
int pinGreen = 14; //d5
int pinRed = 12; //D6
int pinBlue = 13;
int pinLed = 5; //ok d1

#include <Servo.h>
Servo servo1;

void setupModules() {

}

int getLuminosityValue() {
  digitalWrite(pinC, HIGH);
  digitalWrite(pinT, LOW);
  delay(50);
  digitalWrite(pinC, LOW);
  Serial.println(analogRead(A0));
  return analogRead(A0);
}

int getTemperature() {
    digitalWrite(pinT, HIGH);
  digitalWrite(pinC, LOW);
  delay(50);
  Serial.println(analogRead(A0));
  digitalWrite(pinT, LOW);
  return analogRead(A0);
}

void setLedOn() {
  digitalWrite(pinLed, HIGH);
}

void setLedOff () {
   digitalWrite(pinLed, LOW);
}

void setRgb(char r, char g, char b) {
  analogWrite(pinRed, r);
  analogWrite(pinGreen, g);
  analogWrite(pinBlue, b);
}

void turnServo1(int angle) {
  if (angle > 180)
    angle = 0;
  servo1.write(angle);
}

void turnServo2(int angle) {

}