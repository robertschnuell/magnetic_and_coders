class ColumnArduino {

  String name;
  int min, max;
  float speed;

  int target;
  int current;

  boolean limitSwitch = false;

  boolean status = false;


  ColumnArduino(String name, int min, int max, float speed) {
    this.name = name;
    this.min = min;
    this.max = max;
    this.speed = speed;
    current = min;
    target = max;
    println(name);
    
    client.subscribe(name+ "/target");
  }

  boolean update() {

   // println(current + "\t" + target);
    if (target != current) {
      //SEND TO MQTT
      client.publish(name+ "/current", str(map(current,min,max,0,100)));
      if ( target > current) {
        current += speed;
        if (target < current) {
          current = target;
        }
      } else if ( target < current) {
        current -= speed;
        if (target > current) {
          current = target;
        }
      }
      if (!status) {
        status = !status;
        //SEND TO MQTT
        client.publish(name+ "/status", str(status));
      }
      return false;
    } else {
      if (status) {
        status = !status;
        //SEND TO MQTT
        client.publish(name+ "/status", str(status));
      } 
      return true;
    }
  }

  void goTo( float p) {
    target = int(map(p, 0f, 100f, min, max));
    //Send to MQTT
    //client.publish(name+ "/target", str(target));
  }

  void setMin(int min) {
    this.min = min;
    //Send to MQTT
    client.publish(name+ "/max", str(min));
  }
  void setMax(int max) {
    this.max = max;
    client.publish(name+ "/max", str(max));
    //Send to MQTT
  }

  float getPerc() {
    return map(current, min, max, 0, 100);
  }
  
  String getName() {
    return this.name;
  }
}