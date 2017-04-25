class Installation {

  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   @date 03/04/2017
   
   Simulation available via: ../simulation/ArduinoMqttSimulator/ArduinoMqttSimulator.pde
   
   license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
   - https://creativecommons.org/licenses/by-nc-sa/4.0/
   */

  private Side sides [];

  private int totalColumns;
  private int colCount;
  protected int cubeCount;
  protected float cPercentBuffer []; 

  protected Installation( int sideCount, float sidesPos[][], int colCount, int cubeCount) {
    sides = new Side[sideCount];

    if (sideCount == sidesPos.length) {
      for ( int i = 0; i < sidesPos.length; i++) {
        sides[i] = new Side(colCount, cubeCount, sidesPos[i][0], sidesPos[i][1]);
      }
    }

    cPercentBuffer = new float[sideCount * colCount];



    this.colCount = colCount;
    this.cubeCount = cubeCount;
    this.totalColumns = (sideCount + colCount)-1 ;
    for ( int i = 0; i < sideCount*colCount; i++) {
      client.subscribe("a"+ i +"/current");
    }
  }

  public void update() {
    for ( int i = 0; i < sides.length; i++) {
      sides[i].update();
    }
  }



  protected void checkMouse() {
    for ( int i = 0; i< sides.length; i++) {
      sides[i].checkMouse();
    }
  }

  protected int getTotalColumnsCount() {
    return this.totalColumns;
  }

  protected void checkKey(int k) {
    for ( int i = 0; i  < sides.length; i++) {
      sides[i].checkKey(k);
    }
  }



  protected void parseMqttMsg(String topic, byte[] payload) {
    String tmp = new String(payload);
    for ( int i = 0; i< colCount*sides.length; i++) {

      String id = topic.substring(0, topic.indexOf("/"));
      // println(id);
      if (id.equals( "a"+ i)) {
        //println(int(id.substring(1)));
        setTotalColumnPerc(int(id.substring(1)), float(tmp));
        controlView.setCurrent(int(id.substring(1)), float(tmp));
        cPercentBuffer[int(id.substring(1))] = float(tmp);
      }
    }
  }



  protected void checkKey(char k) {
    if (k == '1' )
    {
      for ( int i = 0; i< sides.length; i++) {
        sides[i].showStates(!sides[i].getShowStates());
      }
    }
  }

  /////////////////////USER GETTER/ SETTER ///////////////////

  protected float[][] getCubeCoordinates( int side, int col, int pos) {
    return sides[side].getCubeCords(col, pos);
  }


  protected void setColumnPerc( int side, int col, float val) {
    sides[side].setPerc(col, val);
  }

  protected void setTotalColumnPerc(int c, float val) {
    sides[c/colCount].setPerc(c%colCount, val);
  }

  protected float getCurrentPerc(int side, int col) {
    return sides[side].getPerc(col);
  }

  protected int getSquareCount() {
    return (sides.length * colCount *  cubeCount);
  }

  protected float[][][] getAllCoordinates() {
    float[][][] tmp = new float[getSquareCount()][4][2];


    int cColCount = 0;
    for ( int i = 0; i < getSquareCount(); i++) {
      if (i%cubeCount == 0 && i >0) {
        cColCount++;
      }
      float [][] sTmp = getCubeCoordinates(cColCount/colCount, cColCount%colCount, i%cubeCount);

      for ( int j = 0; j < 4; j++) {
        for ( int k = 0; k < 2; k++) {
          tmp[i][j][k] = sTmp[j][k];
        }
      }
    }

    return tmp;
  }

  protected boolean columnMoveTo( int c, float percent) {
    if ( (c > 0) && (c < sides.length*colCount) ) {
      client.publish("a"+c+"/target", str(percent));
      return true;
    } else return false;
  }

  protected int getSideCount() {
    return this.sides.length;
  }
  protected int getColumnsPerSideCount() {
    return this.colCount;
  }

  protected int getCubeCount() {
    return this.cubeCount;
  }

  protected int getColumns() {
    return getSideCount()*getColumnsPerSideCount();
  }

  protected float getColumnPercent(int c) {
    return cPercentBuffer[c];
  }
  protected boolean setSpeed( int c, float speed) {
    if ( (c > 0) && (c < sides.length*colCount) ) {
      if (speed >= 0 && speed <= 100) {
        client.publish("a"+c+"/speed", str(speed));
      }
      return true;
    } else return false;
  }



  protected void setTarget(int c, float p ) {
    client.publish("a"+ c + "/target", str(p));
    controlView.setTarget(c, p);
  }

  protected void setTarget(int c, float p, float s ) {
    client.publish("a"+ c + "/target", str(p));
    client.publish("a"+ c + "/speed", str(s));
    controlView.setTarget(c, p);
  }


  /////////////////////USER GETTER/ SETTER END ///////////////////
}