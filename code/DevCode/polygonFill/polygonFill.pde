

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
  stroke(255);
  beginShape();
  for ( int i = 0; i < 4; i++) {
    vertex(coordinates[i][0], coordinates[i][1]);
  }
  endShape(CLOSE);


  calcFillCoords("RIGHT", map(mouseY, height, 0, 0, 100));
  fill(255);
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




/*
float[][] coordinates = new float [4][2];
 
 float[] pCoords = new float[2];
 void setup() {
 size(500, 500);
 
 
 coordinates[0][0] = 100;
 coordinates[0][1] = 100;
 
 coordinates[1][0] = 100;
 coordinates[1][1] = 200;
 
 coordinates[2][0] = 200;
 coordinates[2][1] = 200;
 
 coordinates[3][0] = 200;
 coordinates[3][1] = 100;
 }
 
 
 
 
 
 
 
 void draw() {
 background(0);
 
 calcPCoords(map(mouseY,height,0,0,100f));
 
 noFill();
 stroke(255);
 beginShape();
 for ( int i = 0; i < 4; i++) {
 vertex(coordinates[i][0], coordinates[i][1]);
 }
 endShape(CLOSE);
 
 fill(255, 100);
 noStroke();
 beginShape();
 vertex(coordinates[0][0], pCoords[0]);
 vertex(coordinates[1][0], coordinates[1][1]);
 vertex(coordinates[2][0], coordinates[2][1]);
 vertex(coordinates[3][0], pCoords[0]);
 
 endShape(CLOSE);
 }
 
 void calcPCoords(float percent) {
 float steps = coordinates[2][0] - coordinates[0][0];
 
 pCoords[0] = coordinates[2][0]- steps/100*percent;
 }
 
 
 //CASES BOTTOM - TOP - LEFT - RIGHT
 
 
 
 
 */