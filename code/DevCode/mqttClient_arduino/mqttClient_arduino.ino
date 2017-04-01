#include <SPI.h>
#include <Ethernet.h>

#include <PubSubClient.h>



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

  client.setServer(server, 1883);
  client.setCallback(callback);

  Ethernet.begin(mac, ip);




  Serial.begin(9600);

  delay(2500);
  printIPAddress();
}

void loop() {

  if (!client.connected())
  {
    // clientID, username, MD5 encoded password
    if ( client.connect("testusr") ) {
    Serial.println("connected");
    }
    client.publish("a1/test", "I'm alive!");
    client.subscribe("a1/test2");


  }

  if (millis() > (time + 5000)) {

    time = millis();
    String pubString = "{\"a1\":{\"test\": \"" + String(100) + "\"}}";

        Serial.println(pubString);
    pubString.toCharArray(message_buff, pubString.length() + 1);
    //Serial.println(pubString);
    client.publish("a1/test", message_buff);
  }


  client.loop();

}

void callback(char* topic, byte* payload, unsigned int length) {

  int i = 0;

  for (i = 0; i < length; i++) {
    message_buff[i] = payload[i];
  }
  message_buff[i] = '\0';

  String msgString = String(message_buff);



  Serial.print("msg: ");
  Serial.println(msgString);
}


void printIPAddress()
{
  Serial.print(F("My IP address: "));
  for (byte thisByte = 0; thisByte < 4; thisByte++)
  {

    Serial.print(Ethernet.localIP()[thisByte], DEC);
    Serial.print(".");
  }

  Serial.println();
}
