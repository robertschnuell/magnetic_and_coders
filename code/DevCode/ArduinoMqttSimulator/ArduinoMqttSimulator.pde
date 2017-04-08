
import mqtt.*;

MQTTClient client;


ColumnArduino a1;

ArrayList<ColumnArduino> arduinos;

void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://localhost");

  arduinos = new ArrayList<ColumnArduino>();

  for ( int i = 0; i < 8; i++) {
    ColumnArduino tmp = new ColumnArduino("a"+ i, 100, 1000, 1);

    arduinos.add(tmp);
  }

  // a1 = new ColumnArduino("a1", 100, 1000, 10);
}

void draw() {
  //a1.update();

  for ( int i = 0; i< arduinos.size(); i++) {
    arduinos.get(i).update();
  }
}

void messageReceived(String topic, byte[] payload) {
  //println("new message: " + topic + " - " + new String(payload));

  String tmp = new String(payload);


  for ( int i = 0; i< arduinos.size(); i++) {

    if (topic.substring(0, topic.indexOf("/")).equals( arduinos.get(i).getName())) {

      if (topic.substring(topic.indexOf("/")+1).equals("target") ) {

        arduinos.get(i).goTo(float(tmp));
      } else if (topic.substring(topic.indexOf("/")+1).equals("speed") ) {
        arduinos.get(i).setSpeed(float(tmp));
      }
    }
  }
}