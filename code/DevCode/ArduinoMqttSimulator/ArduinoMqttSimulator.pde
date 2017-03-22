
import mqtt.*;

MQTTClient client;


ColumnArduino a1;

void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://localhost");

  a1 = new ColumnArduino("a1", 100, 1000, 1);
  client.subscribe("a1/target");
}

void draw() {
  a1.update();
}

void messageReceived(String topic, byte[] payload) {
  //println("new message: " + topic + " - " + new String(payload));

  String tmp = new String(payload);

println(tmp);

  a1.goTo(float(tmp));
}