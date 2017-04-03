class SquareState {
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

  private float x1, x2, x3, x4, y1, y2, y3, y4;
  private boolean active = false;
  private int activePoint;

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

  protected int checkDist() {
    int tmpId = 4;

    float tmpA[] = new float [4];

    tmpA[0] = dist(mouseX, mouseY, x1, y1);
    tmpA[1] = dist(mouseX, mouseY, x2, y2);
    tmpA[2] = dist(mouseX, mouseY, x3, y3);
    tmpA[3] = dist(mouseX, mouseY, x4, y4);

    float tmpVal = 99999;
    for ( int i = 0; i < tmpA.length; i++) {
      if ( tmpA[i] < tmpVal) {
        tmpVal = tmpA[i];
        tmpId = i;
      }
    }
    if (tmpVal != 99999) {
      return tmpId;
    } else {
      return 4;
    }
  }

  protected void setActive(boolean a) {
    this.active = a;
  }
  protected boolean getActive() {
    return this.active;
  }
  protected int getActivePoint() {
    return this.activePoint;
  }
  protected void setActivePoint(int p) {
    this.activePoint = p;
  }
}