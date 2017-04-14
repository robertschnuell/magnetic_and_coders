class ControlView {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   
   license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
   - https://creativecommons.org/licenses/by-nc-sa/4.0/
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

    drawFonts();
        noFill();
    rect(x, y, size*2, size);
    drawColumns(x+20, y+ size/4);
  }
  
  void drawFonts() {
    fill(255);
     textSize(32);
    text("magnetic and coders", x+ size/2,y+ 60); 
    
    textSize(16);
    text("Layers", x+ size*1.2,y+ 85);
    
    textSize(10);
    for( int i = 0; i < constrain(set.layers.size(),0,10); i++) {
      text(set.layers.get(i).getName(),x+ size*1.2,y+ 100 + 10*i);
      
      text(int(set.layers.get(i).getDuration()),x+ size*1.2+ 140,y+ 100 + 10*i);
    }
    
    
    noFill();
  }




  private void drawColumns(int x_, int y_) {

    stroke(255, 0, 0);
    line(x, y_, x+size*1.1, y_);
    line(x, y_+y_-y, x+size*1.1, y_+y_-y);
    int c = 0;
    for ( int i = 0; i< installation.getSideCount(); i++) {
      for ( int j = 0; j < installation.getColumnsPerSideCount(); j++) {

        for ( int k = 0; k < installation.getCubeCount(); k++) {
          noFill();
          stroke(255);
          rect(x_ + (cubeSize+ cubeSize/2)*j*1.5, y_+map(currents[c], 0, 100, 0, y_-y) + (cubeSize+ cubeSize/2)*k, cubeSize, cubeSize);
        }


        float t_ = map(targets[c], 0, 100, 0, y_-y);
        float c_ = map(currents[c], 0, 100, 0, y_-y);

        stroke(255, 0, 0);
        strokeWeight(map(abs(targets[c]-currents[c]), 0, 100, 0.0f, 10.0f));
        line(x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+t_, x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+c_);
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
  protected float getCurrent(int c) {
    return currents[c];
  }
}