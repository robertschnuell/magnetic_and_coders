class ML_Sinus extends Layer {

  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   based on "Sine Wave" example by Daniel Shiffman 
   */


  int from, to;
  float speed, amp;

  int xspacing = 75;  
  int w;             

  float theta = 0.0; 

  float period = 500.0; 
  float dx;  
  float[] yvalues;  


  long lastCall = 0;
  long interv;



  protected ML_Sinus(int duration, int from, int to, float speed, float amp) {
    super(duration);
    this.from = from;
    this.to = to;
    this.speed = speed;
    this.amp = amp;

    this.dx = (TWO_PI / period) * xspacing;
    this.yvalues = new float[installation.getSideCount()*installation.getColumnsPerSideCount()];


    this.interv = int(duration/(6/speed));
  }


  protected boolean update() {
    boolean response =      super.update();


    if ( (lastCall + interv) < millis()) {
      calcSin();
      sendTargets();
      lastCall = millis();
    }



    if ( response) {
      println("killed");
      super.selfdestuction();
    }
    return response;
  }
  
  private void sendTargets() {
   
    for( int i = this.from; i < this.to+1;i++) {
      installation.setTarget(i,map(constrain(yvalues[i],-amp,amp),-amp,amp,0,100));
    }
    println("bing");
  }


  private void calcSin() {

    theta += speed;
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*amp;
      x+=dx;
    }
  }
}