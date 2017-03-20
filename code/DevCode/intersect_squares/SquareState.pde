class SquareState {

  private float x1, x2, x3, x4, y1, y2, y3, y4;
  private boolean active = false;

  protected SquareState ( float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    this.x1 = x1;
    this.y1 = y1;

    this.x2 = x2;
    this.y2 = y2;

    this.x3 = x3;
    this.y3 = y3;

    this.x4 = x4;
    this.y4 = y4;
  }

  SquareState() {
  }


  protected float getX (int p) {
    float tmp = 0;

    switch(p) {
    case 0:
      tmp = x1;
      break;
    case 1:
      tmp = x2;
      break;
    case 2:
      tmp = x3;
      break;
    case 3:
      tmp = x4;
      break;
    }
    return tmp;
  }
  protected float getY (int p) {
    float tmp = 0;

    switch(p) {
    case 0:
      tmp = y1;
      break;
    case 1:
      tmp = y2;
      break;
    case 2:
      tmp = y3;
      break;
    case 3:
      tmp = y4;
      break;
    }
    return tmp;
  }

  protected void change(int p, int x_, int y_) {
    switch(p) {
    case 0:
      x1 += x_;
      y1 += y_;
      break;
    case 1:
      x2 += x_;
      y2 += y_;
      break;
    case 2:
      x3 += x_;
      y3 += y_;
      break;
    case 3:
      x4 += x_;
      y4 += y_;
      break;
    }
  }

  protected void setX(int p, float val ) {
    switch(p) {
    case 0:
      x1 = val;
      break;
    case 1:
      x2 = val;
      break;
    case 2:
      x3 = val;
      break;
    case 3:
      x4 = val;
      break;
    }
  }
  protected void setY(int p, float val ) {
    switch(p) {
    case 0:
      y1 = val;
      break;
    case 1:
      y2 = val;
      break;
    case 2:
      y3 = val;
      break;
    case 3:
      y4 = val;
      break;
    }
  }
  
  protected int checkDist() { // To Be Continued
    int tmp = 0;
    
   float a1 = dist(mouseX,mouseY,x1,y1);
   float a2 = dist(mouseX,mouseY,x1,y2);
   float a3 = dist(mouseX,mouseY,x1,y3);
   float a4 = dist(mouseX,mouseY,x1,y4);
   
   
   
    
    
    return tmp;
  }
  
  protected void setActive(boolean a) {
    this.active = a;
  }
  protected boolean getActive() {
    return this.active;
  }
}