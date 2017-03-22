class Installation {

  private Side sides [];

  private ArrayList<Character> keyList;

  protected Installation( int sideCount, float sidesPos[][], int colCount, int cubeCount) {
    sides = new Side[sideCount];

    if (sideCount == sidesPos.length) {
      for ( int i = 0; i < sidesPos.length; i++) {
        sides[i] = new Side(colCount, cubeCount, sidesPos[i][0], sidesPos[i][1]);
      }
    }

    keyList = new ArrayList<Character>();
  }

  public void update() {
    for ( int i = 0; i < sides.length; i++) {
      sides[i].update();
    }
  }

  protected float[][] getCubeCoordinates( int side, int col, int pos) {
    return sides[side].getCubeCords(col, pos);
  }

  protected void setColumnPerc( int side, int col, float val) {
    sides[side].setPerc(col, val);
  }

  protected void checkMouse() {
    for ( int i = 0; i< sides.length; i++) {
      sides[i].checkMouse();
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
}