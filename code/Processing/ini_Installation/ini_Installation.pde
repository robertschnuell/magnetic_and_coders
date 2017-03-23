import themidibus.*; 

import mqtt.*;

MQTTClient client;

MidiBus testMidi; 


Installation installation;



void setup() {

  size(1280, 720);
  background(0);


  testMidi = new MidiBus(this, "LPD8", -1); 

  //MQTT 
  client = new MQTTClient(this);
  client.connect("mqtt://localhost");



  //INI INSTALLATION
  float pos[][] = new float[2][2];
  pos[0][0] = width/4;
  pos[0][1] = 100;
   pos[1][0] = width/4*2;
  pos[1][1] = 100;
  installation = new Installation(2, pos, 2, 1);
}



void draw() {
  background(0);

  installation.update();


  // client.publish("topic/state", str(installation.getCubeCoordinates(0,0,0)[0][1]));



  //println(tmp[0][0]);

  //left.update();
  //right.update();
}

void messageReceived(String topic, byte[] payload) { 
  String tmp = new String(payload); 
  //installation.setColumnPerc(0, 0, float(tmp));

  for ( int i = 0; i< installation.getTotalColumnsCount(); i++) {

    String id = topic.substring(0, topic.indexOf("/"));
    println(id);
    if (id.equals( "a"+ i)) {
      println(int(id.substring(1)));
      installation.setTotalColumnPerc(int(id.substring(1)), float(tmp));
    }
  }
}

public void keyPressed()
{

  //

  if (key == CODED) {
    if (keyCode == UP) {
      //send up
      client.publish("a0/target", str(random(0, 100)));
      // left.checkKey(0);
      // right.checkKey(0);
    } else if (keyCode == DOWN) {
      client.publish("a1/target", str(random(0, 100)));
      //send down
      // left.checkKey(1);
      // right.checkKey(1);
    } else if (keyCode == LEFT) {
      client.publish("a2/target", str(random(0, 100)));
      //send left
      // left.checkKey(2);
      // right.checkKey(2);
    } else if (keyCode == RIGHT) {
      client.publish("a3/target", str(random(0, 100)));
      //send right
      // left.checkKey(3);
      // right.checkKey(3);
    }
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