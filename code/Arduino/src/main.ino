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

  license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 - https://creativecommons.org/licenses/by-nc-sa/4.0/
*/


////// Movement variables //////
 int min;
 int max;
unsigned int current;
 int target;
 int speed;
int maxSpeed;
int minSpeed;
bool status;
bool limit;
 unsigned int accel;

 bool idle  = true;

 unsigned long sendTimer = 0;
 int timeing = 50;


 double lastCurrent = 0;

 boolean initialization = false;

////// Stepper library //////

const uint16_t motorFullStPerRev = 200;
kissStepper mot(
    kissPinAssignments(3,4),
    kissMicrostepConfig(FULL_STEP)
);


////// Network and MQTT ////////
byte mac[] = {
  0xDE, 0xEA, 0xEE, 0xEF, 0xFF, 0xFE
};
IPAddress ip(192, 168, 0, 113);
IPAddress server(192, 168, 0, 100);

EthernetClient ethClient;
PubSubClient client(ethClient);

char message_buff[100];
unsigned long time;




void setup() {

  //ini
  min  = -1800;
  max = 400;
  current = 0;
  target = 0;
  speed = 50;
  status = false;
  limit = false;
  accel = 400;
  maxSpeed = 400;
  minSpeed = 50;


  //Serial.begin(9600);
  mot.begin(FULL_STEP, 200);


  mot.setMaxSpeed(speed);
  mot.setAccel(0);

  client.setServer(server, 1883);
  client.setCallback(callback);

  Ethernet.begin(mac, ip);


  delay(2500);
  printIPAddress();

  //limit switch
  pinMode(7,INPUT);


  delay(5000);

}



double fmap (double sensorValue, double sensorMin, double sensorMax, double outMin, double outMax)
{
  return (sensorValue - sensorMin) * (outMax - outMin) / (sensorMax - sensorMin) + outMin;
}

void ini() {
  if(!limit) {
    mot.moveTo(mot.forwardLimit);

  }

    initialization = true;
}

void loop() {
  client.loop();



  if (!client.connected()) {
    if ( client.connect("a0usr") ) {
      Serial.println("connected");
    }
    String tmp = "a0 online ";
    tmp += random(0,1000);
    char temp[tmp.length() + 1];
    tmp.toCharArray(temp, tmp.length() + 1);

  //  Serial.println(tmp);

    client.publish("a0/main", temp);
    client.subscribe("a0/target");
    client.subscribe("a0/speed");
    client.subscribe("a0/main");
  }



if(!idle) {
  if(!digitalRead(7)) {
      limit = true;
  } else {
      limit = false;
  }


  if(!limit) {
      mot.work();
  } else {
    mot.stop();

    mot.moveTo(mot.reverseLimit);
    while(!digitalRead(7)) {
      mot.work();

    }
    mot.stop();
    min = mot.getPos() - 50;
    Serial.print("min is: ");
    Serial.println(mot.getPos());
    mot.moveTo(min);
  }

  if(!initialization) {
      ini();
  } else {




    if( (sendTimer + timeing) < millis() ) {

      String tmp ;
      double val = fmap(mot.getPos(),min,max,0.000,100.000);

      if( lastCurrent != val) {
        lastCurrent = val;

        tmp += millis();
        tmp = val;

        char temp[tmp.length() + 1];
        tmp.toCharArray(temp, tmp.length() + 1);
        client.publish("a0/current",temp);
        sendTimer = millis();
      }

    }


  } // end if INI
}


}


void callback(char* topic, byte* payload, unsigned int length) {

  int i = 0;

  for (i = 0; i < length; i++) {
    message_buff[i] = payload[i];
  }
  message_buff[i] = '\0';


  String msgString = String(message_buff);
  String topicString = String(topic);


  byte limiter1 = topicString.indexOf('/');
  byte limiter2 = topicString.indexOf('/',limiter1+1);
  String lvl1 = topicString.substring(0,limiter1);
  String lvl2 = topicString.substring(limiter1+1,limiter2);

  Serial.println(topicString);
  Serial.println(msgString);

  if(lvl1.equals("a0")) {
    if(lvl2.equals("target")) {



        int newPos = int(fmap(msgString.toFloat(),0.00,100.00,min,max));
        mot.moveTo(newPos);


    } else if (lvl2.equals("speed")) {
      Serial.println("speed");
      speed = int(fmap(msgString.toFloat(),0.00,100.00,minSpeed,maxSpeed));
      Serial.println(speed);
      mot.setMaxSpeed(speed);

    } else if(lvl2.equals("main")) {
      Serial.println("main");
      Serial.println(msgString);
      if(  msgString.substring(0,msgString.indexOf(' ')).equals("ini-max")  ) {
        Serial.print("max was:\t");
        Serial.print(max);
        max += (msgString.substring(msgString.indexOf(' ')+1)).toInt();

        Serial.print("max is now:\t");
        Serial.println(max);

      } else if(msgString.substring(0,msgString.indexOf(' ')).equals("idle")) {
        if((msgString.substring(msgString.indexOf(' ')+1)).toInt() == 1) {
          idle = true;
          Serial.println("idle == 1");
        } else if( (msgString.substring(msgString.indexOf(' ')+1)).toInt() == 0) {
          idle = false;
        }
      }

    }

  }
  /*


  if(!iniV) {
    mot.moveTo(-200);
    iniV = true;
    //Serial.println("ini Done");
    max = -200;
  }  else {

    int newPos = int(fmap(msgString.toFloat(),0.00,100.00,min,max));
    mot.moveTo(newPos);


  //  Serial.println(msgString.toFloat());
    //Serial.println(int(fmap(msgString.toFloat(),0.00,100.00,min,max)));
    //Serial.print("msg: ");
    //Serial.println(topic);
    //Serial.println(mot.getPos());
  }

  */
}


void printIPAddress()
{
  //Serial.print(F("My IP address: "));
  for (byte thisByte = 0; thisByte < 4; thisByte++)
  {

  //  Serial.print(Ethernet.localIP()[thisByte], DEC);
    //Serial.print(".");
  }

  //Serial.println();
}
