#include <EEPROM.h>
#include <SPI.h>
#include <Ethernet.h>
#include <PubSubClient.h>
#include <kissStepper.h>


/*
 magnetic and coders - motorcontroller
 by
 Jannik Bussmann
 Dirk Erdmann
 Robert Schnüll

 @author Robert Schnüll <@robertschnuell>
*/


////// Movement variables //////
 int _min;
 int _max;
unsigned int current;
 int target;
unsigned int speed;
bool status = false;
bool limit = false;

////// Stepper library //////

const uint16_t motorFullStPerRev = 200;
kissStepper mot(
    kissPinAssignments(3,4),
    kissMicrostepConfig(FULL_STEP)
);




void setup() {

  Serial.begin(9600);
  mot.begin(FULL_STEP, 200);

  debugIni();

}

void debugIni() {
  _min = 0;
  _max = 1000;
  current = 0;
  target = 100;
  limit = false;
  speed = 1;
}

void loop() {
  mot.work();


if(mot.getPos() == mot.getTarget()) {
  delay(200);
  target = int(random(_min,_max));
  goTo(target);
  Serial.print(target);
  Serial.print("----");
  Serial.println(mot.getTarget());
}

  /*
  if(motorControl()) {
    Serial.println("done");
    delay(4000);
    goTo(random(0,100));

  } else {

  }
  */

}

bool motorControl() {
  current = mot.getPos();
  if(target != current) {
    return false;
  } else {
    return true;
  }
}


bool checkPos() {
  if (target != current) {
      //SEND TO MQTT
      if ( target > current) {
        current += speed;
        if (target < current) {
          current = target;
        }
      } else if ( target < current) {
        current -= speed;
        if (target > current) {
          current = target;
        }
      }
      if (!status) {
        status = !status;
        //SEND TO MQTT
      }
      return false;
    } else {
      if (status) {
        status = !status;
        //SEND TO MQTT
      }
      return true;
  }
}

void goTo( float p) {
  target = int(map(p, 0, 100, _min, _max));
  mot.moveTo(target);
  //Send to MQTT

}

void setMin(int _min) {
  _min = _min;
  //Send to MQTT
}
void setMax(int max_) {
  _max = max_;
  //Send to MQTT
}
