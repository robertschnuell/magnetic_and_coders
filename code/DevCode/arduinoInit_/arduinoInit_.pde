import controlP5.*;

import mqtt.*;

MQTTClient client;


ControlP5 cp5;

float startX = 80;
float startY = 100;

boolean A0_o, A1_o, A2_o, A3_o, A4_o, A5_o, A6_o, A7_o;


boolean start;


void setup() {
  size(1280, 720);
  cp5 = new ControlP5(this);

  client = new MQTTClient(this);
  client.connect("mqtt://localhost");

  client.subscribe("a0/main");
  client.subscribe("a1/main");
  client.subscribe("a2/main");
  client.subscribe("a3/main");
  client.subscribe("a4/main");
  client.subscribe("a5/main");
  client.subscribe("a6/main");
  client.subscribe("a7/main");



  cp5.addButton("A0_i")
    .setValue(0)
    .setPosition(startX*1, startY+55)
    .setSize(75, 19)
    ;
  cp5.addButton("A1_i")
    .setValue(0)
    .setPosition(startX*2, startY+55)
    .setSize(75, 19)
    ;
  cp5.addButton("A2_i")
    .setValue(0)
    .setPosition(startX*3, startY+55)
    .setSize(75, 19)
    ;
  cp5.addButton("A3_i")
    .setValue(0)
    .setPosition(startX*4, startY+55)
    .setSize(75, 19)
    ;
  cp5.addButton("A4_i")
    .setValue(0)
    .setPosition(startX*5, startY+55)
    .setSize(75, 19)
    ;
  cp5.addButton("A5_i")
    .setValue(0)
    .setPosition(startX*6, startY+55)
    .setSize(75, 19)
    ;
  cp5.addButton("A6_i")
    .setValue(0)
    .setPosition(startX*7, startY+55)
    .setSize(75, 19)
    ;
  cp5.addButton("A7_i")
    .setValue(0)
    .setPosition(startX*8, startY+55)
    .setSize(75, 19)
    ;
}

void A0_i () {
  if (start) {
    println("a0 ini");
    client.publish("a0/main", ("idle 0").toString() );
  }
}
void A1_i () {
  if (start) {
    println("a1 ini");
    client.publish("a1/main", ("idle 0").toString() );
  }
}
void A2_i () {
  if (start) {
    println("a2 ini");
    client.publish("a2/main", ("idle 0").toString() );
  }
}
void A3_i () {
  if (start) {
    println("a3 ini");
    client.publish("a3/main", ("idle 0").toString() );
  }
}
void A4_i () {
  if (start) {
    println("a4 ini");
    client.publish("a4/main", ("idle 0").toString() );
  }
}
void A5_i () {
  if (start) {
    println("a5 ini");
    client.publish("a5/main", ("idle 0").toString() );
  }
}
void A6_i () {
  if (start) {
    println("a6 ini");
    client.publish("a6/main", ("idle 0").toString() );
  }
}
void A7_i () {
  if (start) {
    println("a7 ini");
    client.publish("a7/main", ("idle 0").toString() );
  }
}

void draw() {

  background(0);

  statusSwitch();

  if (millis() > 4000) {
    start = true;
  }
}

void messageReceived(String topic, byte[] payload) {
  //println("new message: " + topic + " - " + new String(payload));

  String tmp = new String(payload);

  for ( int i = 0; i < 8; i++) {
    if (topic.substring(0, topic.indexOf("/")).equals( ("a" + i).toString() )) {


      if (topic.substring(topic.indexOf("/")+1).equals("main") ) {


        if (tmp.substring(0, 9).equals(("a"+ i + " online").toString()) ) {
          println(tmp);

          switch(i) {
          case 0:
            A0_o = true;
            break;
          case 1:
            A1_o = true;
            break;
          case 2:
            A2_o = true;
            break;           
          case 3:
            A3_o = true;
            break;
          case 4:
            A4_o = true;
            break;
          case 5:
            A5_o = true;
            break;
          case 6:
            A6_o = true;
            break;
          case 7:
            A7_o = true;
            break;
          }
        }
      }
    }
  }
}




void statusSwitch() {
  if (A0_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*1, startY, 75, 50);

  if (A1_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*2, startY, 75, 50);

  if (A2_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*3, startY, 75, 50);

  if (A3_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*4, startY, 75, 50);

  if (A4_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*5, startY, 75, 50);

  if (A5_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*6, startY, 75, 50);

  if (A6_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*7, startY, 75, 50);

  if (A7_o) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(startX*8, startY, 75, 50);
}