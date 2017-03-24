class Cube {

  float[][] coordinates = new float [4][2];

  boolean fill = true;
  boolean stroke = true;

  color fillColor = color(255, 255, 255);
  color strokeColor = color(255, 255, 255);

  int strokeWidth = 1;

  protected Cube(float[][] coords) {
    this.coordinates = coords;
  }
  protected Cube() {
  }
  
  protected void newData(float coords[][]) {
     this.coordinates = coords;
  }

  protected void update() {
   


    if (fill) {
      fill(fillColor);
    } else {
      noFill();
    }
    if (stroke) {
      strokeCap(SQUARE);
      stroke(strokeColor);
      strokeWeight(strokeWidth);
    } else {
      noStroke();
    }
    beginShape();
    for ( int i = 0; i < 4; i++) {
      vertex(coordinates[i][0], coordinates[i][1]);
    }
    endShape(CLOSE);

    strokeCap(ROUND);
  }


  /////////////////////USER GETTER/ SETTER ///////////////////

  protected void setFill( boolean f) {
    this.fill = f;
  }
  protected void setStroke( boolean s) {
    this.stroke = s;
  }
  

  protected void setFillColor(color c) {
    this.fillColor = c;
  }
  protected void setFillColor(int r, int g, int b) {
    this.fillColor = color(r, g, b);
  }
  protected void setFillColor( int r, int g, int b, int a) {
    this.fillColor = color ( r, g, b, a);
  }
  protected void setFillColor(int c, int a) {
    this.fillColor = color (c, c, c, a);
  }


  protected void setStrokeColor(color c) {
    this.strokeColor = c;
  }
  protected void setStrokeColor(int r, int g, int b) {
    this.strokeColor = color(r, g, b);
  }
  protected void setStrokeColor( int r, int g, int b, int a) {
    this.strokeColor = color ( r, g, b, a);
  }
  protected void setStrokeColor(int c, int a) {
    this.strokeColor = color (c, c, c, a);
  }


  /////////////////////USER GETTER/ SETTER END  ///////////////////
}