class Side {

  private ArrayList<Column>columns;


  protected Side(int amount, float x, float y) {
    columns = new ArrayList<Column>();

    for ( int i = 0; i < amount; i++) {
      Column c = new Column( 4, x+ 75*i, y, 50);
      columns.add(c);
    }
    
    ini(x,y,50,400);
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
        tmpC.addSquareState(j,x_+ 75*i,y_+ s_*j + yOff,s_);
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
}