class Mode {


  int min, max, current, target;
  float speed;



  int time= 0;
  float beginning= 0;
  float change = 390;
  float duration = 200;

  Mode(int min, int max, float speed) {
    this.min = min;
    this.max = max;
    this.current = min;
    this.target = min;
    this.speed = speed;
  }


  boolean update() {


    if (target != current) {

      if ( target > current) {
        int dist = target-current;
        // println(dist);
        current += speed;
        println(easeInOut(time, beginning, change, duration));
        time++;
        //current = int(easeInOut(time, beginning, change, duration)*100);
        if (target < current) {
          current = target;
        }
      } else if ( target < current) {
        current -= speed;
        if (target > current) {
          current = target;
        }
      }

      return false;
    } else {

      return true;
    }
  }

  boolean easeUpdate() {

    //if (current < target) {
    current =  int(easeInOut(time, beginning, change, target));
    if (time < target) {
      time++;
    } else {
  
    }
    return false;
    //  } else {
    //   return true;
    // }
  }

  int getC() {
    return current;
  }

  void setT(int t) {
    this.target = t;


    beginning= current;
    change = 390;
    duration = target;
    time = 0;
  }

  public float  easeInOut(float t, float b, float c, float d) {
    if ((t/=d/2) < 1) return c/2*t*t + b;
    return -c/2 * ((--t)*(t-2) - 1) + b;
  }



  /*
  float targetX = mouseX;
   float dx = targetX - x;
   x += dx * easing;
   */
}