/*
 magnetic and coders - engine
 by 
 Jannik Bussmann
 Dirk Erdmann
 Robert Schnüll
 
 license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 - https://creativecommons.org/licenses/by-nc-sa/4.0/
 
 */
import mqtt.*;

MQTTClient client;

ArrayList<ColumnArduino> arduinos;

int totalAmountOfColumns;



void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://localhost");

  arduinos = new ArrayList<ColumnArduino>();

  totalAmountOfColumns = 8;  // <- corresponding to engine (sides*columCount)

  for ( int i = 0; i < totalAmountOfColumns; i++) { 
    ColumnArduino tmp = new ColumnArduino("a"+ i, 100, 1000, 3);

    arduinos.add(tmp);
  }
}

void draw() {
  for ( int i = 0; i< arduinos.size(); i++) {
    arduinos.get(i).update();
  }
}

void messageReceived(String topic, byte[] payload) {
  String tmp = new String(payload);

  for ( int i = 0; i< arduinos.size(); i++) {

    if (topic.substring(0, topic.indexOf("/")).equals( arduinos.get(i).getName())) {
      arduinos.get(i).goTo(float(tmp));
    }
  }
}