class Installation {

  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   @date 23/03/2017
   
   Simulation possible via: ../simulation/ArduinoMqttSimulator/ArduinoMqttSimulator.pde
   */

  private Side sides [];

  private ArrayList<Character> keyList;
  private int totalColumns;
  private int colCount;
  protected int cubeCount;

  protected Installation( int sideCount, float sidesPos[][], int colCount, int cubeCount) {
    sides = new Side[sideCount];

    if (sideCount == sidesPos.length) {
      for ( int i = 0; i < sidesPos.length; i++) {
        sides[i] = new Side(colCount, cubeCount, sidesPos[i][0], sidesPos[i][1]);
      }
    }

    keyList = new ArrayList<Character>();

    this.colCount = colCount;
    this.cubeCount = cubeCount;
    this.totalColumns = (sideCount + colCount)-1 ;
    for ( int i = 0; i < totalColumns; i++) {
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
    for ( int i = 0; i< getTotalColumnsCount(); i++) {

      String id = topic.substring(0, topic.indexOf("/"));
      // println(id);
      if (id.equals( "a"+ i)) {
        //println(int(id.substring(1)));
        setTotalColumnPerc(int(id.substring(1)), float(tmp));
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

    for ( int i = 0; i < getSquareCount(); i++) {
      float [][] sTmp = getCubeCoordinates(0, 0, 0);

      for ( int j = 0; j < 4; j++) {
        for ( int k = 0; k < 2; k++) {
          tmp[i][j][k] = sTmp[j][k];
        }
      }
    }

    return tmp;
  }


  /////////////////////USER GETTER/ SETTER END ///////////////////
}