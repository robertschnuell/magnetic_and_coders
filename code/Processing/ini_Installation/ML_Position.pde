

class ML_Position extends MLayer {

  int from, to;
  float speed;

  float position;

  protected ML_Position(ArrayList usedColumns, float position, float speed) {
    super(usedColumns, speed);
    this.position = position;

    for ( int i = 0; i < usedColumns.size(); i++) {
      installation.setTarget(i, constrain(position, 0, 100));
    }
  }

  protected boolean update(ArrayList tmp) {
    boolean response =      super.update( tmp);

    int activeCounter = 0;
    
    
    for ( int i = 0; i < usedColumns.size(); i++) {
      if(position == installation.getColumnPercent(usedColumns.get(i))) {
        activeCounter++;
      } else {
        break;
      }
    }
   // println(activeCounter);
    if(activeCounter == usedColumns.size()) {
      response = true;
    }
    

    

    if ( response) {
      println("killed");
      super.selfdestuction();
    }
    return response;
  }
  
}