class Square {
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
  private  ArrayList<SquareState> states;

  private  SquareState master;

  private  boolean showStates = true;
  private  boolean showMaster = true;
  private  boolean active = false;



  //Constructors
  protected Square(float x, float y, float s) {
    states = new ArrayList<SquareState>();
    master = new SquareState();
    SquareState tmp = new SquareState(x-s/2, y-s/2, x-s/2, y+s/2, x+s/2, y+s/2, x+s/2, y-s/2);
    states.add(tmp);
  }
  protected Square() {
    states = new ArrayList<SquareState>();
    master = new SquareState();
    setPerc(0);
  }

  protected void update() {

    if (active) {
      fill(255, 100);
    } else {
      noFill();
    }

    if (showStates) {

      stroke(125);
      strokeWeight(1);
      for ( int i = 0; i < states.size(); i++) {
        if (states.get(i).getActive() ) {




          int selectedPoint = states.get(i).checkDist();
          if ( (selectedPoint >= 0 ) && (selectedPoint <=3 ) ) {
            fill(255);
            ellipse(states.get(i).getX(selectedPoint), states.get(i).getY(selectedPoint), 5, 5);
            states.get(i).setActivePoint(selectedPoint);
          }
          fill(255, 0, 0, 100);
        } else {

          noFill();
        }
        beginShape();
        for ( int j = 0; j < 4; j++) {
          vertex(states.get(i).getX(j), states.get(i).getY(j));
        }
        endShape(CLOSE);
      }
    }

    if (showMaster) {
      strokeWeight(1);
      stroke(0, 255, 0);
      beginShape();
      for ( int i = 0; i < 4; i++) {
        vertex(master.getX(i), master.getY(i));
      }
      endShape(CLOSE);
    }
  }

  protected void update(float p) {
    setPerc(p);
    update();
  }

  private void setPerc(float pos) {
    if (states.size() > 1) {
      float step = 100/(states.size()-1);

      float start = 0;
      float end = 0;
      int tmpPos = 0;
      int counter = 0;

      float percentStart = 0;
      float percentEnd = 0;
      while ( end < pos) {
        if (start < pos) {
          start = tmpPos-step;
        }
        end = tmpPos;
        tmpPos += step;
        counter++;
      }
      float percent = ((pos-start) * 100) / (end - start);
      percentStart = 0 + (100-percent);
      percentEnd = 100 - (100-percent);

      for ( int i = 0; i < 4; i++) {
        float startX = states.get(constrain(counter-2, 0, states.size())).getX(i);
        float endX = states.get(constrain(counter-1, 0, states.size())).getX(i);
        startX = startX * (percentStart/ 100); 
        endX = endX * (percentEnd/100);
        master.setX(i, ((startX + endX)) );


        float startY = states.get(constrain(counter-2, 0, states.size())).getY(i);
        float endY = states.get(constrain(counter-1, 0, states.size())).getY(i);
        startY = startY * (percentStart/ 100); 
        endY = endY * (percentEnd/100);
        master.setY(i, ((startY + endY)) );
      }
    } else {
      master = states.get(0);
    }
  }

  protected boolean checkClick(int s) {
    if (
      ( (mouseX > states.get(s).getX(0) ) && ( mouseX < states.get(s).getX(2)) )&&
      ( (mouseY > states.get(s).getY(0) ) && ( mouseY < states.get(s).getY(2) ) ) 
      ) {
      return true;
    } else {
      return false;
    }
  }




  protected void addState(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    SquareState tmp = new SquareState(x1, y1, x2, y2, x3, y3, x4, y4);
    states.add(tmp);
  }

  protected void addState(float x, float y, float s) {
    SquareState tmp = new SquareState(x-s/2, y-s/2, x-s/2, y+s/2, x+s/2, y+s/2, x+s/2, y-s/2);
    states.add(tmp);
  }

  protected void editStatePos(int s, int p, int x, int y) {
    states.get(s).setX(p, x);
    states.get(s).setY(p, y);
  }
  protected float getXPointPos(int p) {
    return master.getX(p);
  }
  protected float getYPointPos(int p) {
    return master.getY(p);
  }

  protected float getXStatePos(int s, int p) {
    return states.get(s).getX(p);
  }
  protected float getYStatePos(int s, int p) {
    return states.get(s).getY(p);
  }

  protected boolean getActive() {
    return active;
  }

  protected void changeState(int s, int p, int x_, int y_) {
    states.get(s).change(p, x_, y_);
  }

  protected void setStateActive(int s, boolean a) {
    states.get(s).setActive(a);
  }
  protected boolean getStateActive(int s) {
    return states.get(s).getActive();
  }
  protected int getStateActivePoint(int s) {
    return states.get(s).getActivePoint();
  }

  protected void showStates(boolean s) {
    showStates = s;
  }
  protected float[][] getCords() {
    float[][] cords = new float[4][2];
    for ( int i = 0; i < 4; i++) {

      cords[i][0] = master.getX(i);
      cords[i][1] = master.getY(i);
    }
    return cords;
  }



  protected int getStatesCount() {
    return states.size();
  }
}