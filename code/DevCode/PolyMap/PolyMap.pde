
float[][] coordinates = new float [4][2];
float[][] mapCoordinates = new float [4][2];


float cX, cY, cR;

float midX, midY;
float midXPercent, midYPercent;
float mapPercent;

boolean side1, side2, side3, side4, side5;
color cSide1, cSide2, cSide3, cSide4, cSide5;



void setup() {
  size(500, 500);


  coordinates[0][0] = 100;
  coordinates[0][1] = 100;

  coordinates[1][0] = 120;
  coordinates[1][1] = 300;

  coordinates[2][0] = 300;
  coordinates[2][1] = 300;

  coordinates[3][0] = 210;
  coordinates[3][1] = 110;

  cR = 50;

  midXPercent = 10;
  midYPercent = 0;

  midX = calcMid(coordinates[0][0], coordinates[1][0], coordinates[2][0], coordinates[3][0], midXPercent);
  midY = calcMid(coordinates[0][1], coordinates[1][1], coordinates[2][1], coordinates[3][1], midYPercent);


  mapPercent = 24;

  side1 = true;
  side2 = true;
  side3 = true;
  side4 = true;
  side5 = true;

  cSide1 = 255;
  cSide2 = 125;
  cSide3 = 100;
  cSide4 = 255;
  cSide5 = 50;
}

void draw() {
  background(0);


  fill(255, 255, 0);
  stroke(100);




  midXPercent = map(mouseX, 0, width, 0, 100);
  midYPercent = map(mouseY, 0, height, 0, 100);
  //  midXPercent = 50;
  // midYPercent = 50;

  midX = calcMid(coordinates[0][0], coordinates[1][0], coordinates[2][0], coordinates[3][0], midXPercent);
  midY = calcMid(coordinates[0][1], coordinates[3][1], coordinates[2][1], coordinates[1][1], midYPercent);







  // mapPercent = map(mouseY, 0, height, 0, 100);

  rectMode(CENTER);
  ellipseMode(CENTER);
  rect(midX, midY, 5, 5);

  ellipse(lerp(coordinates[0][0], midX, mapPercent*0.01), lerp(coordinates[0][1], midY, mapPercent*0.01), 5, 5);











  noFill();
  beginShape();
  for ( int i = 0; i < 4; i++) {
    vertex(coordinates[i][0], coordinates[i][1]);
  }
  endShape(CLOSE);



  calcMapCoordinates();


  noFill();
  stroke(255, 0, 0, 100);
  beginShape();
  for ( int i = 0; i < 4; i++) {
    vertex(mapCoordinates[i][0], mapCoordinates[i][1]);
  }
  endShape(CLOSE);


  stroke(255);
  for ( int i = 0; i < 4; i++) {


    line(coordinates[i][0], coordinates[i][1], mapCoordinates[i][0], mapCoordinates[i][1]);
  }

  drawSides();




  noFill();
}

void calcMapCoordinates() {
  for ( int i = 0; i < 4; i++) {
    mapCoordinates[i][0] = lerp(coordinates[i][0], midX, mapPercent*0.01);
    mapCoordinates[i][1] = lerp(coordinates[i][1], midY, mapPercent*0.01);
  }
}

void drawSides() {

  if (side1) {
    noStroke();
    fill(cSide1);
    beginShape();
    vertex(coordinates[0][0], coordinates[0][1]);
    vertex(coordinates[1][0], coordinates[1][1]);
    vertex(mapCoordinates[1][0], mapCoordinates[1][1]);
    vertex(mapCoordinates[0][0], mapCoordinates[0][1]);
    endShape(CLOSE);
  }
  if (side2) {
    noStroke();
    fill(cSide2);
    beginShape();
    vertex(coordinates[1][0], coordinates[1][1]);
    vertex(coordinates[2][0], coordinates[2][1]);
    vertex(mapCoordinates[2][0], mapCoordinates[2][1]);
    vertex(mapCoordinates[1][0], mapCoordinates[1][1]);
    endShape(CLOSE);
  }
  if (side3) {
    noStroke();
    fill(cSide3);
    beginShape();
    vertex(coordinates[2][0], coordinates[2][1]);
    vertex(coordinates[3][0], coordinates[3][1]);
    vertex(mapCoordinates[3][0], mapCoordinates[3][1]);
    vertex(mapCoordinates[2][0], mapCoordinates[2][1]);
    endShape(CLOSE);
  }
  if (side4) {
    noStroke();
    fill(cSide4);
    beginShape();
    vertex(coordinates[3][0], coordinates[3][1]);
    vertex(coordinates[0][0], coordinates[0][1]);
    vertex(mapCoordinates[0][0], mapCoordinates[0][1]);
    vertex(mapCoordinates[3][0], mapCoordinates[3][1]);
    endShape(CLOSE);
  }
  if (side5) {
    noStroke();
    fill(cSide5);
    beginShape();
    vertex(mapCoordinates[0][0], mapCoordinates[0][1]);
    vertex(mapCoordinates[1][0], mapCoordinates[1][1]);
    vertex(mapCoordinates[2][0], mapCoordinates[2][1]);
    vertex(mapCoordinates[3][0], mapCoordinates[3][1]);
    endShape(CLOSE);
  }
}




float calcMid(float c1, float c2, float c3, float c4, float p) {

  float m1 = (( (c2-c1)/2)+c1);
  float m2 = ( ( (c4-c3)/2)+c3) ;

  return (m2-m1)/(100/p)+ m1;
}

float calcMid(float c1, float c2, float p) {

  float tmpC1 = c1;
  float tmpC2 = c2;

  if (c2 < c1) {
    //float tmpSwap = tmpC1;
    //tmpC1 = tmpC2;
    //tmpC2 = tmpSwap;

    return (((tmpC2-tmpC1)-tmpC1)*(0.01*p)/2 +tmpC1 );
  } else {
    return (((tmpC2-tmpC1)+tmpC1)*(0.01*p)/2 +tmpC1 );
  }
}


Integer checkColusion(int side, float cX, float cY, float cR ) {

  Integer response = null;
  switch(side) {
  case 0:
    if ( circleLineIntersect(coordinates[3][0], coordinates[3][1], coordinates[0][0], coordinates[0][1], cX, cY, cR)) response = 0;
    break;
  case 1:
    if ( circleLineIntersect(coordinates[0][0], coordinates[0][1], coordinates[1][0], coordinates[1][1], cX, cY, cR)) response = 1;
    break;
  case 2:
    if ( circleLineIntersect(coordinates[1][0], coordinates[1][1], coordinates[2][0], coordinates[2][1], cX, cY, cR)) response = 2;
    break;
  case 3: 
    if ( circleLineIntersect(coordinates[2][0], coordinates[2][1], coordinates[3][0], coordinates[3][1], cX, cY, cR)) response = 3;
    break;
  }

  return response;
}




boolean circleLineIntersect(float x1, float y1, float x2, float y2, float cx, float cy, float cr ) {
  float dx = x2 - x1;
  float dy = y2 - y1;
  float a = dx * dx + dy * dy;
  float b = 2 * (dx * (x1 - cx) + dy * (y1 - cy));
  float c = cx * cx + cy * cy;
  c += x1 * x1 + y1 * y1;
  c -= 2 * (cx * x1 + cy * y1);
  c -= cr * cr;
  float bb4ac = b * b - 4 * a * c;
  return (bb4ac>=0);
}