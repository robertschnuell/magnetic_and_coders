class ControlView {
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


  int x, y;
  int cubeSize = 15;
  int size;

  float[] targets;
  float[] currents;

  boolean mouseClick;

  boolean [][] selectedRows;

  protected ControlView(int x, int y, int s) {
    this.x = x;
    this.y = y;
    this.size = s;

    this.targets = new float[installation.getColumnsPerSideCount()*installation.getSideCount()];
    this.currents = new float[installation.getColumnsPerSideCount()*installation.getSideCount()];

    this.selectedRows = new boolean[installation.getCubeCount()][installation.getSideCount()];
  }

  protected void update() {



    drawFonts();
    RowSelectorInterface(x+size*1.8, y+ 60);

    stroke(255, 0, 0);
    noFill();
    rect(x, y, size*2, size);
    drawColumns(x+20, y+ size/4);
    drawMFunctionButtons();

    mouseClick = false;
  }

  private void drawMFunctionButtons() {

    textSize(10);

    fill(255);
    text("Free", x+ 20, y+ 360);
    if (set.getMFree()) {
      fill(255);
      stroke(255);
    } else {
      stroke(255);
      noFill();
    }
    rect(x+20, y+370, 55, 25);
    if ( (mouseX > x+20) && (mouseX < x+20+55) && (mouseY > y+ 370) && (mouseY < y+ 370+25) ) {
      if (mouseClick) {
        set.setMFree(true);
      }
    }

    fill(255);
    text("Random", x+ 80, y+ 360);
    if (set.getMRandom()) {
      fill(255);
      stroke(255);
    } else {
      stroke(255);
      noFill();
    }
    rect(x+80, y+370, 55, 25);
    if ( (mouseX > x+80) && (mouseX < x+80+55) && (mouseY > y+ 370) && (mouseY < y+ 370+25) ) {
      if (mouseClick) {
        set.setMRandom(true);
      }
    }

    fill(255);
    text("Split", x+ 140, y+ 360);
    if (set.getMSplit()) {
      fill(255);
      stroke(255);
    } else {
      stroke(255);
      noFill();
    }
    rect(x + 140, y+370, 55, 25);
    if ( (mouseX > x+140) && (mouseX < x+140+55) && (mouseY > y+ 370) && (mouseY < y+ 370+25) ) {
      if (mouseClick) {
        set.setMSplit(true);
      }
    }

    fill(255);
    text("Line", x+ 200, y+ 360);
    if (set.getMLine()) {
      fill(255);
      stroke(255);
    } else {
      stroke(255);
      noFill();
    }
    rect(x + 200, y+370, 55, 25);
    if ( (mouseX > x+200) && (mouseX < x+200+55) && (mouseY > y+ 370) && (mouseY < y+ 370+25) ) {
      if (mouseClick) {
        set.setMLine(true);
      }
    }

    fill(255);
    text("V", x+ 260, y+ 360);
    if (set.getMV()) {
      fill(255);
      stroke(255);
    } else {
      stroke(255);
      noFill();
    }
    rect(x + 260, y+370, 55, 25);
    if ( (mouseX > x+260) && (mouseX < x+260+55) && (mouseY > y+ 370) && (mouseY < y+ 370+25) ) {
      if (mouseClick) {
        set.setMV(true);
      }
    }

    fill(255);
    text("Sinus", x+ 320, y+ 360);
    if (set.getMSinus()) {
      fill(255);
      stroke(255);
    } else {
      stroke(255);
      noFill();
    }
    rect(x + 320, y+370, 55, 25);
    if ( (mouseX > x+320) && (mouseX < x+320+55) && (mouseY > y+ 370) && (mouseY < y+ 370+25) ) {
      if (mouseClick) {
        set.setMSinus(true);
      }
    }

    fill(255);
    text("Reset MC", x+ 400, y+ 360);
    fill(255);
    stroke(255);
    rect(x + 400, y+370, 45, 25);
    if ( (mouseX > x+400) && (mouseX < x+400+45) && (mouseY > y+ 370) && (mouseY < y+ 370+25) ) {
      if (mouseClick) {
        set.MCReset();
      }
    }


    fill(255);
    text("0", x+ 450, y+ 360);
    stroke(255);
    rect(x + 450, y+370, 10, 10);
    if ( (mouseX > x+450) && (mouseX < x+450+10) && (mouseY > y+ 370) && (mouseY < y+ 370+10) ) {
      if (mouseClick) {
        set.MCResetToZero(0);
      }
    }
    fill(255);
    text("1", x+ 465, y+ 360);
    stroke(255);
    rect(x + 465, y+370, 10, 10);
    if ( (mouseX > x+465) && (mouseX < x+465+10) && (mouseY > y+ 370) && (mouseY < y+ 370+10) ) {
      if (mouseClick) {
        set.MCResetToZero(1);
      }
    }
    fill(255);
    text("2", x+ 480, y+ 360);
    stroke(255);
    rect(x + 480, y+370, 10, 10);
    if ( (mouseX > x+480) && (mouseX < x+480+10) && (mouseY > y+ 370) && (mouseY < y+ 370+10) ) {
      if (mouseClick) {
        set.MCResetToZero(2);
      }
    }
    fill(255);
    text("3", x+ 495, y+ 360);
    stroke(255);
    rect(x + 495, y+370, 10, 10);
    if ( (mouseX > x+495) && (mouseX < x+495+10) && (mouseY > y+ 370) && (mouseY < y+ 370+10) ) {
      if (mouseClick) {
        set.MCResetToZero(3);
      }
    }


    //

    fill(255);
    text("4", x+ 450, y+ 385);
    stroke(255);
    rect(x + 450, y+385, 10, 10);
    if ( (mouseX > x+450) && (mouseX < x+450+10) && (mouseY > y+ 385) && (mouseY < y+ 385+10) ) {
      if (mouseClick) {
        set.MCResetToZero(4);
      }
    }
    fill(255);
    text("5", x+ 465, y+ 385);
    stroke(255);
    rect(x + 465, y+385, 10, 10);
    if ( (mouseX > x+465) && (mouseX < x+465+10) && (mouseY > y+ 385) && (mouseY < y+ 385+10) ) {
      if (mouseClick) {
        set.MCResetToZero(5);
      }
    }
    fill(255);
    text("6", x+ 480, y+ 385);
    stroke(255);
    rect(x + 480, y+385, 10, 10);
    if ( (mouseX > x+480) && (mouseX < x+480+10) && (mouseY > y+ 385) && (mouseY < y+ 385+10) ) {
      if (mouseClick) {
        set.MCResetToZero(6);
      }
    }
    fill(255);
    text("7", x+ 495, y+ 385);
    stroke(255);
    rect(x + 495, y+385, 10, 10);
    if ( (mouseX > x+495) && (mouseX < x+495+10) && (mouseY > y+ 385) && (mouseY < y+ 385+10) ) {
      if (mouseClick) {
        set.MCResetToZero(7);
      }
    }


    //
  }

  private void drawFonts() {
    fill(255);
    textSize(32);
    text("magnetic and coders", x+ size/2, y+ 60); 

    textSize(16);
    text("Layers", x+ size*1.2, y+ 85);

    textSize(10);
    for ( int i = 0; i < constrain(set.layers.size(), 0, 10); i++) {
      text(set.layers.get(i).getName(), x+ size*1.2, y+ 100 + 10*i);

      text(int(set.layers.get(i).getDuration()), x+ size*1.2+ 140, y+ 100 + 10*i);
    }


    noFill();
  }

  private void RowSelectorInterface(float x_, float y_) {
    int size = 10;
    for ( int i = 0; i< installation.getSideCount(); i++) {
      for ( int j = 0; j < installation.getCubeCount(); j++) {
        float xPos = x_+ i*20;
        float yPos = y_ + 20*j;



        if ( ( mouseX > xPos) && (mouseX < xPos+size)  && (mouseY > yPos) && (mouseY < yPos + size) ) {
          if (mouseClick) {
            selectedRows[j][i] = !selectedRows[j][i];
          }
          fill(255); 
          noStroke();
        } else {
          if (selectedRows[j][i]) {
            fill(125);
          } else {
            noFill(); 
            stroke(255);
          }
        }
        rect(xPos, yPos, size, size);
      }
    }
  }




  private void drawColumns(int x_, int y_) {

    stroke(255, 0, 0);
    line(x, y_, x+size*1.1, y_);
    line(x, y_+y_-y, x+size*1.1, y_+y_-y);
    int c = 0;
    for ( int i = 0; i< installation.getSideCount(); i++) {
      for ( int j = 0; j < installation.getColumnsPerSideCount(); j++) {

        for ( int k = 0; k < installation.getCubeCount(); k++) {
          noFill();
          stroke(255);
          rect(x_ + (cubeSize+ cubeSize/2)*j*1.5, y_+map(currents[c], 0, 100, 0, y_-y) + (cubeSize+ cubeSize/2)*k, cubeSize, cubeSize);
        }


        float t_ = map(targets[c], 0, 100, 0, y_-y);
        float c_ = map(currents[c], 0, 100, 0, y_-y);

        stroke(255, 0, 0);
        strokeWeight(map(abs(targets[c]-currents[c]), 0, 100, 0.0f, 10.0f));
        line(x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+t_, x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+c_);
        strokeWeight(1);
        ellipseMode(CENTER);
        noFill();
        stroke(255, 255, 0);
        ellipse(x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+t_, 5, 5);

        noStroke();
        fill(255, 255, 0);
        ellipse(x_ + (cubeSize+ cubeSize/2)*j*1.5 + cubeSize/2+2.5, y_+c_, 5, 5);

        c++;
      }
      x_ += 300;
    }
  }

  protected void checkMouse() {
    this.mouseClick = true;
  }


  protected void setTarget(int c, float p) {
    this.targets[c] = p;
  }
  protected void setCurrent(int c, float p) {
    this.currents[c] = p;
  }
  protected float getCurrent(int c) {
    return currents[c];
  }

  protected ArrayList getSelectedRows(int side) {
    ArrayList<Integer> result = new ArrayList<Integer>();


    for ( int i = 0; i < selectedRows.length; i++) {
      if (selectedRows[i][constrain(side, 0, selectedRows[i].length)]) {
        result.add(i);
      }
    }



    return result;
  }
}