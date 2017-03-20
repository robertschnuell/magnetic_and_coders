class Column {


  //Lists
  private ArrayList<Square> squaresList = null;
  private Square[] squares  = null;

  //Bools
  private boolean editable = true;
  private boolean active = false;

  private float iniX, iniY;
  
  private float perc = 0;

  //


  //Constructors
  protected Column() {
    squaresList = new ArrayList<Square>();
  }
  protected Column(int count) {
    squares = new Square[count];
    for ( int i = 0; i < count; i++) {
      squares[i] = new Square();
    }
  }
  protected Column(int count, float x1, float y1, float x2, float y2, float s) {
    squares = new Square[count];
    float stepsX = (x2-x1)/count;
    float stepsY = (y2-y1)/count;
    for ( int i = 0; i < count; i++) {
      float tmpX = x1+ stepsX*i;
      float tmpY = y1+ stepsY*i;
      squares[i] = new Square(tmpX, tmpY, s);
    }
  }
  protected Column(int count, float x1, float y1, float s) {
    squares = new Square[count];
    for ( int i = 0; i < count; i++) {

      float tmpY = y1+ s*i;
      squares[i] = new Square(x1, tmpY, s);
    }
    this.iniX = x1;
    this.iniY = y1;
  }

  void update() {



    if (squares != null) {
      drawGui();
      noFill();
      stroke(0, 255, 0);
      for ( int i = 0; i < squares.length; i++) {
        squares[i].update(perc);  // DONT FORGET TO CHANGE FOR MOVEMENT
      }
    } else if ( squaresList != null) {
      for ( int i = 0; i < squaresList.size(); i++) {
      }
    }
  }

  private void drawGui() {
    if (editable) {
      if (active) {

        fill(255, 25);
        noStroke();
        beginShape();
        vertex(squares[0].getXStatePos(0, 0), squares[0].getYStatePos(0, 0));
        vertex(squares[0].getXStatePos(0, 0), squares[squares.length-1].getYStatePos(squares[squares.length-1].getStatesCount()-1, 1));
        vertex(squares[squares.length-1].getXStatePos(squares[squares.length-1].getStatesCount()-1, 2), squares[squares.length-1].getYStatePos(squares[squares.length-1].getStatesCount()-1, 2));
        vertex(squares[squares.length-1].getXStatePos(squares[squares.length-1].getStatesCount()-1, 2), squares[0].getYStatePos(0, 0));
        endShape(CLOSE);


        fill(255, 100);
        noStroke();
        beginShape();
        vertex(squares[0].getXPointPos(0), squares[0].getYPointPos(0));
        vertex(squares[0].getXPointPos(0), squares[squares.length-1].getYPointPos(1));
        vertex(squares[squares.length-1].getXPointPos(2), squares[squares.length-1].getYPointPos(2));
        vertex(squares[squares.length-1].getXPointPos(2), squares[0].getYPointPos(0));
        endShape(CLOSE);
      } else {
        for ( int i = 0; i < squares.length; i++) {
          for ( int j = 0; j < squares[i].getStatesCount(); j++) {
            squares[i].setStateActive(j, false);
          }
        }
      }
    }
  }

  protected boolean checkMouseClick() {
    if (
      ( (mouseX> squares[0].getXStatePos(0, 0)) && ( mouseX < squares[squares.length-1].getXStatePos(squares[squares.length-1].getStatesCount()-1, 2) ) ) 
      &&
      ( (mouseY> squares[0].getYStatePos(0, 0) ) && ( mouseY < squares[squares.length-1].getYStatePos(squares[squares.length-1].getStatesCount()-1, 2) ))
      ) {

      return true;
    } else {
      return false;
    }
  }


  public void checkStateClick() {
    if (active) {
      if ( squares != null) {

        for ( int i = 0; i < squares.length; i++) {
          for ( int j = 0; j < squares[i].getStatesCount(); j++) {
            if (squares[i].checkClick(j)) {
              squares[i].setStateActive(j, true);
            } else {
              squares[i].setStateActive(j, false);
            }
          }
        }
      }
    }
  }

  protected void checkKey(int k) {
    if (active) {

      for ( int i = 0; i < squares.length; i++) {

        for ( int j = 0; j < squares[i].getStatesCount(); j++) {
          if (squares[i].getStateActive(j)) {
            switch (k) {
            case 0:
              squares[i].changeState(j, squares[i].getStateActivePoint(j), 0, -1);
              break;
            case 1:
              squares[i].changeState(j, squares[i].getStateActivePoint(j), 0, 1);
              break;
            case 2:
              squares[i].changeState(j, squares[i].getStateActivePoint(j), -1, 0);
              break;
            case 3:
              squares[i].changeState(j, squares[i].getStateActivePoint(j), 1, 0);
              break;
            default:
            }
          }
        }
        /*
        if(squares[i].getActive()) {
         println("bing" + i );     
         squares[i].checkKey(k);
         break;
         }
         */
      }
    }
  }



  protected void setActive(boolean a) {
    active = a;
  }
  protected boolean getActive() {
    return this.active;
  }

  protected void addSquareState(int id, float x, float y, float s) {
    squares[id].addState(x, y, s);
  }

  protected int getSquareAmount() {
    if (squares != null) {
      return squares.length;
    } else if ( squaresList != null) {
      return squaresList.size();
    } else {
      return 0;
    }
  }

  protected void showStates( boolean s) {
    for ( int i = 0; i< squares.length; i++) {
      squares[i].showStates(s);
    }
  }
  
  protected float getPerc() {
    return this.perc;
  }
  protected void setPerc(float p) {
    this.perc = p;
  }






  void addSquare(float x, float y, float size) {
    if (squaresList != null) {
      squaresList.add(new Square(x, y, size));
    }
  }
}