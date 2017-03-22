class Installation {

  private Side sides [];

  protected Installation( int sideCount, float sidesPos[][], int colCount) {
    sides = new Side[sideCount];

    if (sideCount == sidesPos.length) {
      for ( int i = 0; i < sidesPos.length; i++) {
        sides[i] = new Side(colCount, sidesPos[i][0], sidesPos[i][1]);
      }
    }
  }
  
  public void update() {
    for ( int i = 0; i < sides.length;i++) {
      sides[i].update();
    }
  }

  protected float[][] getCubeCoordinates( int side, int col, int pos) {
    return sides[side].getCubeCords(col, pos);
  }
  
  protected void setColumnPerc( int side, int col, float val) {
    sides[side].setPerc(col,val);
  }
  
  protected void checkMouse() {
    for( int i = 0; i< sides.length; i++) {
      sides[i].checkMouse();
    }
  }

}