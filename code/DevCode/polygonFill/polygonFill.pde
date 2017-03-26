
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