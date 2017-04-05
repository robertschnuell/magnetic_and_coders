
float[][] coordinates = new float [4][2];

float cX, cY, cR;

float midX, midY;


ArrayList<Ball> balls = new ArrayList<Ball>();

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

  midX = calcMid(coordinates[0][0], coordinates[1][0], coordinates[2][0], coordinates[3][0]);
  midY = calcMid(coordinates[0][1], coordinates[1][1], coordinates[2][1], coordinates[3][1]);

  balls.add(new Ball(midX,midY,10,10));
}

void draw() {
  background(0);


  noFill();
  stroke(100);
  beginShape();
  ellipseMode(CENTER);

  cX = mouseX;
  cY = mouseY;

  midX = calcMid(coordinates[0][0], coordinates[1][0], coordinates[2][0], coordinates[3][0]);
  midY = calcMid(coordinates[0][1], coordinates[1][1], coordinates[2][1], coordinates[3][1]);


  for ( int i = 0; i < 4; i++) {
    vertex(coordinates[i][0], coordinates[i][1]);
  }
  endShape(CLOSE);

  for ( int i = 0; i < 4; i++) {

    Integer tmp = checkColusion(i, cX, cY, cR/2);
    if (tmp != null) {
      fill(255, 0, 0);
      break;
    } else {
      noFill();
    }
  }

  ellipse(cX, cY, cR, cR);

  fill(255, 255, 0);



  ellipse(midX, midY, 5, 5);






  noFill();




  /*
  line(coordinates[1][0],coordinates[1][1],coordinates[2][0],coordinates[2][1]);
   
   if(circleLineIntersect(coordinates[1][0],coordinates[1][1],coordinates[2][0],coordinates[2][1],mouseX,mouseY,cR/2)){
   fill(255,0,0);
   } else {
   noFill();
   }
   ellipseMode(CENTER);
   ellipse(mouseX,mouseY,cR,cR);
   
   */
   
   for ( int i = 0; i < balls.size();i++) {
     balls.get(i).update();
   }
}

float calcMid(float c1, float c2, float c3, float c4) {

  float m1 = (( (c2-c1)/2)+c1);
  float m2 = ( ( (c4-c3)/2)+c3) ;

  return (m2-m1)/2+ m1;
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