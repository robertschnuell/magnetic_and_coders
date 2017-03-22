
import mqtt.*;

MQTTClient client;
float noisePos = 0.0;

void setup() {
    client = new MQTTClient(this);
  client.connect("mqtt://localhost");
}

void draw() {
 
  noisePos = noisePos + .01;
  float pos = noise(noisePos)*100;
   client.publish("C1/pos", str(pos));
}