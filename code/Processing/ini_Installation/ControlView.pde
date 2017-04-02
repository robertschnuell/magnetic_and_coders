class ControlView {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */


  int x, y;
  int cubeSize = 15;
  int size;

  float[] targets;
  float[] currents;

  protected ControlView(int x, int y, int s) {
    this.x = x;
    this.y = y;
    this.size = s;

    this.targets = new float[installation.getColumnsPerSideCount()*installation.getSideCount()];
    this.currents = new float[installation.getColumnsPerSideCount()*installation.getSideCount()];
  }

  protected void update() {

    stroke(255, 0, 0);
    noFill();
    rect(x, y, size*2, size);
    drawColumns(x+20, y+ size/4);
  }




  private void drawColumns(int x_, int y_) {

     stroke(255,0,0);
     line(x,y_,x+size*2,y_);
     int c = 0;
    for ( int i = 0; i< installation.getSideCount(); i++) {
      for ( int j = 0; j < installation.getColumnsPerSideCount(); j++) {

        for ( int k = 0; k < installation.getCubeCount(); k++) {
          noFill();
          stroke(255);
          rect(x_ + (cubeSize+ cubeSize/2)*j*1.5, y_+map(currents[c], 0, 100, 0, y_-y) + (cubeSize+ cubeSize/2)*k, cubeSize, cubeSize);
        }
        
        
        float t_ = map(targets[c], 0, 100, 0, y_-y);
        float c_ = map(currents[c],0,100,0,y_-y);
        
        stroke(255,0,0);
        strokeWeight(map(abs(targets[c]-currents[c]),0,100,0.0f,10.0f));
        line(x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+t_,x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+c_);
        strokeWeight(1);
        ellipseMode(CENTER);
        noFill();
        stroke(255, 255, 0);
        ellipse(x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+t_, 5, 5);

        noStroke();
        fill(255, 255, 0);
        ellipse(x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+c_, 5, 5);
        
        c++;
      }
      x_ += 300;
      
    }
    
  }


  protected void setTarget(int c, float p) {
    this.targets[c] = p;
  }
  protected void setCurrent(int c, float p) {
    this.currents[c] = p;
  }
}