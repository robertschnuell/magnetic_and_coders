import themidibus.*; 
import mqtt.*;

/*
 magnetic and coders - engine
 by 
 Jannik Bussmann
 Dirk Erdmann
 Robert Schnüll
 
 license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 - https://creativecommons.org/licenses/by-nc-sa/4.0/
 
 */

/////////////////////INSTANCES /////////////////// 
MQTTClient client;
MidiBus testMidi; 

Installation installation;
View view;
Set set;
ControlView controlView;
/////////////////////INSTANCES END ///////////////////



void setup() {
  size(1080, 1920);
  //fullScreen(SPAN);
  println(width);
  println(height);

  testMidi = new MidiBus(this, "LPD8", -1); 

  //MQTT 
  client = new MQTTClient(this);
  client.connect("mqtt://localhost");

  //INI INSTALLATION
  float pos[][] = new float[2][2];
  pos[0][0] = 930;
  pos[0][1] = 750;
  pos[1][0] = width/4*3;
  pos[1][1] = 100;

  pos[0][0] = 300;
  pos[0][1] = 100;
  installation = new Installation(2, pos, 4, 6);

  view = new View(installation.getSquareCount());
  set  = new Set();


  controlView = new ControlView(100, 700, 300);

  //staticDev();
}



void draw() {
  background(0);
  installation.update();
  view.newData(installation.getAllCoordinates());
  view.update();
  set.update();

  controlView.update();
}

void staticDev() {
  installation.setColumnPerc(0, 0, 50);
  installation.setColumnPerc(0, 1, 50);
  installation.setColumnPerc(0, 2, 50);
  installation.setColumnPerc(0, 3, 50);
  installation.setColumnPerc(1, 0, 50);
  installation.setColumnPerc(1, 1, 50);
  installation.setColumnPerc(1, 2, 50);
  installation.setColumnPerc(1, 3, 50);
}


/////////////////////MQTT ///////////////////
void messageReceived(String topic, byte[] payload) { 
  if (topic.charAt(0) == 'a') {
    installation.parseMqttMsg(topic, payload);
  }
}
/////////////////////MQTT END ///////////////////




/////////////////////INPUT LISTENER ///////////////////

public void keyPressed()
{

  //

  if (key == CODED) {
    if (keyCode == UP) {
      //send up
      installation.setTarget(int(random(1, 8)), random(0, 100));
      installation.checkKey(0);
      // right.checkKey(0);
    } else if (keyCode == DOWN) {
      //client.publish("a1/target", str(random(0, 100)));
      installation.checkKey(1);
      //send down
      // left.checkKey(1);
      // right.checkKey(1);
    } else if (keyCode == LEFT) {
      //client.publish("a2/target", str(random(0, 100)));
      installation.checkKey(2);
      //send left
      // left.checkKey(2);
      // right.checkKey(2);
    } else if (keyCode == RIGHT) {
      //client.publish("a3/target", str(random(0, 100)));
      installation.checkKey(3);
      //send right
      // left.checkKey(3);
      // right.checkKey(3);
    }
  }

  if (key == 'e') {
    set.addMLayer("SINUS", 1, 4);
  }
  if (key == 'r') {
    set.addMLayer("SINUS", 4, 8);
  }
  if (key == 'h') {
    set.addMLayer("HOME");
  }


  installation.checkKey(key);
}


void mousePressed() {
  installation.checkMouse();
}




//MIDI

void controllerChange(int channel, int number, int value) {
  float tmpPerc = map(value, 0, 127, 0.1, 100);

  switch(number) {
  case 1:
    installation.setColumnPerc(0, 0, tmpPerc);
    break;
  case 2: 
    installation.setColumnPerc(0, 1, tmpPerc);
    break;
  case 3:
    installation.setColumnPerc(0, 2, tmpPerc);
    break;
  case 4: 
    installation.setColumnPerc(0, 3, tmpPerc);
    break;
  case 5:
    installation.setColumnPerc(1, 0, tmpPerc);
    break;
  case 6:
    installation.setColumnPerc(1, 1, tmpPerc);
    break;
  case 7: 
    installation.setColumnPerc(1, 2, tmpPerc);
    break;
  case 8:
    installation.setColumnPerc(1, 3, tmpPerc);
    break;
  default:
  }
}

void noteOff(int channel, int pitch, int velocity) {
  println(pitch);
  if (pitch == 41) {
    set.addLayer("FILL_CUBE_RIGHT");
  } else if (pitch == 42) {
    set.addLayer("SINUS");
  }
}

/////////////////////INPUT LISTENER END ///////////////////