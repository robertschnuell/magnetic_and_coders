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
unsigned int speed;
bool status;
bool limit;
 unsigned int accel;

 unsigned long sendTimer = 0;
 int timeing = 50;

 boolean iniV  = false;

 double lastCurrent = 0;

////// Stepper library //////

const uint16_t motorFullStPerRev = 200;
kissStepper mot(
    kissPinAssignments(3,4),
    kissMicrostepConfig(FULL_STEP)
);


////// Network and MQTT ////////
byte mac[] = {
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};
IPAddress ip(192, 168, 0, 177);
IPAddress server(192, 168, 0, 102);

EthernetClient ethClient;
PubSubClient client(ethClient);

char message_buff[100];
unsigned long time;




void setup() {
  ini();
  //Serial.begin(9600);
  mot.begin(FULL_STEP, 200);


  mot.setMaxSpeed(speed);
  mot.setAccel(speed/2);

  client.setServer(server, 1883);
  client.setCallback(callback);

  Ethernet.begin(mac, ip);


  delay(2500);
  printIPAddress();

}

void ini() {
  min  = -1800;
  max = 0;
  current = 0;
  target = 0;
  speed = 100;
  status = false;
  limit = false;
  accel = 400;
}

double fmap (double sensorValue, double sensorMin, double sensorMax, double outMin, double outMax)
{
  return (sensorValue - sensorMin) * (outMax - outMin) / (sensorMax - sensorMin) + outMin;
}


void loop() {
  mot.work();

  client.loop();



  if (!client.connected())
{
    if ( client.connect("testusr") ) {
      Serial.println("connected");
    }
    String tmp = "a0 online ";
    tmp += random(0,1000);
    char temp[tmp.length() + 1];
    tmp.toCharArray(temp, tmp.length() + 1);

  //  Serial.println(tmp);

    client.publish("a0/main", temp);
    client.subscribe("a0/target");
  }



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


}


void callback(char* topic, byte* payload, unsigned int length) {

  int i = 0;

  for (i = 0; i < length; i++) {
    message_buff[i] = payload[i];
  }
  message_buff[i] = '\0';

  String msgString = String(message_buff);


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
