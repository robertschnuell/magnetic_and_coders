class Ball {
  
  float x,y;
  float size;
  float speed;
  
  Ball(float x, float y, float size, float speed) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.speed = speed;
  }
  
  void update() {
    noFill();
    stroke(255,0,0);
    ellipse(x,y,size,size);

  }
  
  
  
  
}