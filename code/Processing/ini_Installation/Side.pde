class Side {
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

  private ArrayList<Column>columns;

  private boolean showStates = true;


  protected Side(int amount, int cubes, float x, float y) {
    columns = new ArrayList<Column>();

    for ( int i = 0; i < amount; i++) {
      Column c = new Column(cubes, x+ 75*i, y, 50);
      columns.add(c);
    }

    ini(x, y, 50, 100);
  }

  protected void  update() {
    for ( int i = 0; i< columns.size(); i++) {
      columns.get(i).update();
    }
  }

  private void ini(float x_, float y_, float s_, float yOff) {

    for ( int i = 0; i < columns.size(); i++) {
      Column tmpC =  columns.get(i);
      for ( int j = 0; j < tmpC.getSquareAmount(); j++) {
        tmpC.addSquareState(j, x_+ 75*i, y_+ s_*j + yOff, s_);
      }
    }
  }

  protected void checkKey(int k) {
    for ( int i = 0; i < columns.size(); i++) {
      if (columns.get(i).getActive()) {
        columns.get(i).checkKey(k);
      }
    }
  }


  protected void checkMouse() {
    Integer tmpId = null;
    for ( int i = 0; i < columns.size(); i++) {
      if (columns.get(i).checkMouseClick()) {
        tmpId = i;
        break;
      }
    }

    if (tmpId != null) {
      columns.get(tmpId).setActive(true);
      columns.get(tmpId).checkStateClick();
      for ( int i = 0; i < columns.size(); i++) {
        if (i != tmpId) {
          columns.get(i).setActive(false);
        }
      }
    } else {
      for ( int i = 0; i < columns.size(); i++) {
        columns.get(i).setActive(false);
      }
    }
  }

  protected void showStates( boolean s) {
    showStates = !showStates;
    for ( int i = 0; i < columns.size(); i++) {
      columns.get(i).showStates(showStates);
    }
  }

  protected float[][] getCubeCords(int col, int pos) {
    return columns.get(col).getCubeCords(pos);
  }

  protected float getPerc(int col) {
    return columns.get(col).getPerc();
  }

  protected boolean getShowStates() {
    return showStates;
  }
  protected void setPerc(int c, float p) {

    columns.get(c).setPerc(p);
  }

  protected float[][][][] getSquareStates() {
    //float[][][][] tmp = new float [2];
    // [][][cubes][states][stateCoords]
    //[columns][cubes each column][states][stateCoords]
    // 8 for 4 x and y coordinates
    float tmp [][][][] = new float [columns.size()][columns.get(0).getCubeCount()][columns.get(0).getStatesCount()][8];

    for ( int i = 0; i < columns.size(); i++) {
      tmp[i] = columns.get(i).getSquareStates();
      for( int j = 0; j < 8; j++) {
     // println(tmp[0][0][0][j]);
      }
    }
    //println("-------");

    return tmp;
  }
  
  protected void jsonToData(int column, int cube, int state, int p, int x, int y) {
    /*
    void jsonToData(int cube, int state, int p , int x, int y) {
    squares[cube].changeState(state,p,x,y);
    */
    columns.get(column).jsonToData(cube,state,p,x,y);
    
    
    
    
    
  }
  
  
  
}