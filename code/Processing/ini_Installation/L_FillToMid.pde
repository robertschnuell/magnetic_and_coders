class L_FillToMid extends Layer {
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

  private float fill; 
  private String type;
  private boolean sides;

  private int colPointer;
  private float timeEachCol;
  private String tmpType;

  protected L_FillToMid(String name, boolean sides, long duration, String type) {
    super(duration, name);
    this.sides = sides;
    this.fill = 0;
    this.type = type;

    this.colPointer = 0;
    this.timeEachCol = duration/installation.getColumnsPerSideCount();

    println(timeEachCol);


    if (type.equals("RIGHT")) {
      tmpType = "LEFT";
    } else {
      tmpType = "RIGHT";
    }
  }

  protected boolean update() {
    boolean response = super.update();


    if ( (start +  colPointer*timeEachCol)  < millis() ) {
      colPointer = constrain(colPointer + 1, 0, installation.getColumnsPerSideCount());
    }

    float fill = constrain((millis() -start) -colPointer*timeEachCol +timeEachCol, 0, timeEachCol);


    int startCube = (colPointer-1)*installation.getCubeCount(); 
    int endCube = startCube + installation.getCubeCount();
    for ( int i = startCube; i < endCube; i++) {
      if (sides) {
        view.cubes.get(constrain(i, 0, view.cubes.size())).setDrawFill(true, map(fill, 0, timeEachCol, 0, 99.9), type, color(255, 0, 0));
      } else {
        view.cubes.get(constrain(i, 0, view.cubes.size())).setDrawFill(true, 100-map(fill, 0, timeEachCol, 0, 99.9), type, color(255, 0, 0));
      }
    }


    startCube = ( installation.getColumns()*installation.getCubeCount() ) - ((colPointer-1)*installation.getCubeCount())  ;

    endCube = startCube - installation.getCubeCount();




    for ( int i = endCube; i < startCube; i++) {
      if (sides) {
        view.cubes.get(constrain(i, 0, view.cubes.size()-1)).setDrawFill(true, map(fill, 0, timeEachCol, 0, 99.9), tmpType, color(255, 0, 0));
      } else {
        view.cubes.get(constrain(i, 0, view.cubes.size()-1)).setDrawFill(true, 100- map(fill, 0, timeEachCol, 0, 99.9), tmpType, color(255, 0, 0));
      }
    }




    //fill = map(millis(), start, start+duration, 0, 100);


    if ( response) {
      //view.cubes.get(id).setDrawFill(false);

      super.selfdestuction();
    }
    return response;
  }
}