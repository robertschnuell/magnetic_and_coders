class Side {

  private ArrayList<Column>columns;

  private boolean showStates = true;


  protected Side(int amount, int cubes, float x, float y) {
    columns = new ArrayList<Column>();

    for ( int i = 0; i < amount; i++) {
      Column c = new Column( cubes, x+ 75*i, y, 50);
      columns.add(c);
    }

    ini(x, y, 50, 400);
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

  protected boolean getShowStates() {
    return showStates;
  }
  protected void setPerc(int c, float p) {

    columns.get(c).setPerc(p);
  }
}