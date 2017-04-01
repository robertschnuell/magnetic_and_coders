

float[][] coordinates = new float [4][2];
float[][] fCoordinates = new float [4][2];

void setup() {
  size(500, 500);


  coordinates[0][0] = 100;
  coordinates[0][1] = 100;

  coordinates[1][0] = 120;
  coordinates[1][1] = 200;

  coordinates[2][0] = 200;
  coordinates[2][1] = 200;

  coordinates[3][0] = 210;
  coordinates[3][1] = 110;
}

void draw() {
  background(0);



  noFill();
  stroke(100);
  beginShape();
  for ( int i = 0; i < 4; i++) {
    vertex(coordinates[i][0], coordinates[i][1]);
  }
  endShape(CLOSE);



  //drawFill("RIGHT", map(mouseY, height, 0, 0, 100), 255);


 // drawOutline(7, false, map(mouseY, height, 0, 0, 100), 255);
  // outline(3,255);
  animateStroke(1, map(mouseX, 0, width, 0, 100), 255);
}

void animateStroke(int type, float percent, color c) {

  if ( type == 0) {
    if (percent < 25) {
      drawOutline(1, false, map(percent, 0f, 25f, 0f, 100f), c);
    } else if ( ( percent >=25 ) && (percent < 50) ) {
      outline(1, c);
      drawOutline(2, false, map(percent, 25f, 50f, 0f, 100f), c);
    } else if ( (percent >=50 ) && (percent < 75) ) {
      outline(1, c);
      outline(2, c);
      drawOutline(3, false, map(percent, 50f, 75f, 0f, 100f), c);
    } else if ( (percent >= 75) ) {
      outline(1, c);
      outline(2, c);
      outline(3, c);
      drawOutline(0, false, map(percent, 75f, 100f, 0f, 100f), c);
    }
  } else if ( type == 1) {
    if (percent < 25) {
      
      drawOutline(4, false, map(percent, 0f, 25f, 0f, 100f), c);
    } else if ( ( percent >=25 ) && (percent < 50) ) {
      outline(0, c);
      drawOutline(7, false, map(percent, 25f, 50f, 0f, 100f), c);
    } else if ( (percent >=50 ) && (percent < 75) ) {
      outline(0, c);
      outline(3, c);
      drawOutline(6, false, map(percent, 50f, 75f, 0f, 100f), c);
    } else if ( (percent >= 75) ) {
      outline(0, c);
      outline(3, c);
      outline(2, c);
      
      drawOutline(5, false, map(percent, 75f, 100f, 100f, 0f), c);
    }
  }
}

void outline(int type, color c) {
  noFill();
  stroke(c);
  switch(type) {
  case 0:
    line(coordinates[0][0], coordinates[0][1], coordinates[3][0], coordinates[3][1]);
    break;
  case 1:
    line(coordinates[0][0], coordinates[0][1], coordinates[1][0], coordinates[1][1]);
    break;
  case 2:
    line(coordinates[1][0], coordinates[1][1], coordinates[2][0], coordinates[2][1]);
    break;
  case 3:
    line(coordinates[2][0], coordinates[2][1], coordinates[3][0], coordinates[3][1]);
    break;
  default:
  }
}


void drawOutline(int type, boolean subtype, float percent, color c) {

  noFill();
  stroke(c);


  switch(type) {
  case 0: 
    calcFillCoords("RIGHT", percent);
    line(coordinates[3][0], coordinates[3][1], fCoordinates[0][0], fCoordinates[0][1]);
    if (subtype) {
      line(coordinates[2][0], coordinates[2][1], fCoordinates[1][0], fCoordinates[1][1]);
    }
    break;
  case 1:
    calcFillCoords("TOP", percent);
    line(coordinates[0][0], coordinates[0][1], fCoordinates[1][0], fCoordinates[1][1]);
    if (subtype) {
      line(coordinates[3][0], coordinates[3][1], fCoordinates[2][0], fCoordinates[2][1]);
    }
    break;
  case 2:
    calcFillCoords("LEFT", percent);
    line(coordinates[1][0], coordinates[1][1], fCoordinates[2][0], fCoordinates[2][1]);
    if (subtype) {
      line(coordinates[0][0], coordinates[0][1], fCoordinates[3][0], fCoordinates[3][1]);
    }
    break;
  case 3: 
    calcFillCoords("BOTTOM", percent);
    line(coordinates[2][0], coordinates[2][1], fCoordinates[3][0], fCoordinates[3][1]);
    if (subtype) {
      line(coordinates[1][0], coordinates[1][1], fCoordinates[0][0], fCoordinates[0][1]);
    }
    break;
  case 4: 
    calcFillCoords("LEFT", percent);
    line(coordinates[0][0], coordinates[0][1], fCoordinates[3][0], fCoordinates[3][1]);
    if (subtype) {
      line(coordinates[2][0], coordinates[2][1], fCoordinates[1][0], fCoordinates[1][1]);
    }
    break;
  case 5:
    calcFillCoords("TOP", percent);
    line(coordinates[1][0], coordinates[1][1], fCoordinates[1][0], fCoordinates[1][1]);
    if (subtype) {
      line(coordinates[2][0], coordinates[2][1], fCoordinates[1][0], fCoordinates[1][1]);
    }
    break;
  case 6:
    calcFillCoords("RIGHT", percent);
    line(coordinates[2][0], coordinates[2][1], fCoordinates[1][0], fCoordinates[1][1]);
    if (subtype) {
      line(coordinates[0][0], coordinates[0][1], fCoordinates[3][0], fCoordinates[3][1]);
    }
    break;
  case 7: 
    calcFillCoords("TOP", percent);
    line(coordinates[3][0], coordinates[3][1], fCoordinates[2][0], fCoordinates[2][1]);
    if (subtype) {
      line(coordinates[1][0], coordinates[1][1], fCoordinates[0][0], fCoordinates[0][1]);
    }
    break;

  default:
  }
}



void drawFill(String type, float percent, color c) {
  calcFillCoords(type, percent);
  fill(c);
  noStroke();
  beginShape();
  for ( int i = 0; i < 4; i++) {
    vertex(fCoordinates[i][0], fCoordinates[i][1]);
  }
  endShape(CLOSE);
}

void calcFillCoords(String type, float percent) {
  int swaps[] = new int[4];
  float steps[] = new float[4];
  if (type.equals("BOTTOM") ) {
    swaps[0] = 0;
    swaps[1] = 1;
    swaps[2] = 2;
    swaps[3] = 3;
  } else if ( type.equals("TOP") ) {
    swaps[0] = 1;
    swaps[1] = 0;
    swaps[2] = 3;
    swaps[3] = 2;
  } else if ( type.equals("LEFT") ) {
    swaps[0] = 3;
    swaps[1] = 0;
    swaps[2] = 1;
    swaps[3] = 2;
  } else if ( type.equals("RIGHT") ) {
    swaps[0] = 1;
    swaps[1] = 2;
    swaps[2] = 3;
    swaps[3] = 0;
  }

  steps[0] = fCoordinates[swaps[1]][0] - coordinates[swaps[0]][0];
  steps[1] = fCoordinates[swaps[1]][1] - coordinates[swaps[0]][1];

  steps[2] = fCoordinates[swaps[2]][0] - coordinates[swaps[3]][0];
  steps[3] = fCoordinates[swaps[2]][1] - coordinates[swaps[3]][1];

  fCoordinates[swaps[0]][0] = coordinates[swaps[1]][0] - steps[0]/100*percent;
  fCoordinates[swaps[0]][1] = coordinates[swaps[1]][1] - steps[1]/100*percent;

  fCoordinates[swaps[1]][0] =  coordinates[swaps[1]][0] ;
  fCoordinates[swaps[1]][1] =  coordinates[swaps[1]][1] ;

  fCoordinates[swaps[2]][0] =  coordinates[swaps[2]][0] ;
  fCoordinates[swaps[2]][1] =  coordinates[swaps[2]][1] ;

  fCoordinates[swaps[3]][0] = coordinates[swaps[2]][0] - steps[2]/100*percent;
  fCoordinates[swaps[3]][1] = coordinates[swaps[2]][1] - steps[3]/100*percent;
}