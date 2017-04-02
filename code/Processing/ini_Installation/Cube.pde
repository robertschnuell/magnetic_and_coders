class Cube {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */
  private float[][] coordinates = new float [4][2];
  private float[][] fCoordinates = new float [4][2];

  private boolean fill = false;
  private boolean stroke = true;

  private color fillColor = color(255, 255, 255);
  private color strokeColor = color(255, 255, 255);

  private int strokeWidth = 1;

  //animated stroke and outlines
  private boolean animateStroke = false;
  private int animateStrokeType = 0; 
  private float animateStrokePercent = 0;
  private color animateStrokeColor = strokeColor;

  private boolean outline = false;
  private int outlineType = 0;
  private color outlineColor = strokeColor;

  private boolean drawFill = false;
  private float drawFillPercent = 0;
  private String drawFillType ="";
  private color drawFillColor = strokeColor;

  private boolean drawOutline = false;
  private float drawOutlinePercent = 0;
  private int drawOutlineType = 0;
  private boolean drawOutlineSubtype = false;
  private color drawOutlineColor = strokeColor;





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

    if (drawFill) {
      drawFill(drawFillType, drawFillPercent, fillColor);
    }
    if (animateStroke) {
      animateStroke(animateStrokeType, animateStrokePercent, strokeColor);
    }
    if (outline) {
      outline(outlineType, strokeColor);
    }
    if (drawOutline) {
      drawFill(drawFillType, drawFillPercent, fillColor);
      drawOutline(drawOutlineType, drawOutlineSubtype, drawOutlinePercent, strokeColor);
    }
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


  protected void setAnimateStroke( boolean s) {
    this.animateStroke = s;
    this.animateStrokeColor = strokeColor;
  }
  protected void setAnimateStroke(boolean s, float p, int t, color c) {
    this.animateStroke = s;
    this.animateStrokeColor = c;
    this.animateStrokePercent = p;
    this.animateStrokeType = t;
    if ( p >= 100) {
      this.animateStroke = false;
      //  this.stroke = true;
      //  this.strokeColor = c;
    }
    if ( p <= 0) {
      this.animateStroke = false;
    }
  }
  protected void setAnimateStrokePercent( float p) {
    this.animateStrokePercent = p;
  }
  protected void setAnimateStrokeType(int  t) {
    this.animateStrokeType = t;
  }


  protected void setOutline( boolean s) {
    this.outline = s;
    this.outlineColor = strokeColor;
  }
  protected void setOutline(boolean s, int t, color c) {
    this.outline = s;
    this.outlineColor = c;
    this.outlineType = t;
  }
  protected void setOutlineType( int t) {
    this.outlineType = t;
  }


  protected void setDrawFill( boolean s) {
    this.drawFill = s;
    this.drawFillColor = fillColor;
  }
  protected void setDrawFill(boolean s, float p, String t, color c) {
    this.drawFill = s;
    this.drawFillColor = c;
    this.drawFillPercent = p;
    this.drawFillType = t;
    if (p >= 100) {
      this.drawFill = false;
      //  this.fill = true;
      //  this.fillColor = c;
    }
    if ( p <= 0) {
      this.drawFill = false;
    }
  }
  protected void setDrawFillPercent( float p) {
    this.drawFillPercent = p;
  }
  protected void setDrawFillType ( String t) {
    this.drawFillType = t;
  }


  protected void setDrawOutline(boolean s) {
    this.drawOutline = s;
    this.drawOutlineColor = strokeColor;
  }
  protected void setDrawOutline(boolean s, float p, int t, boolean st, color c) {
    this.drawOutline = s;
    this.drawOutlineColor = c;
    this.drawOutlinePercent = p;
    this.drawOutlineType = t;
    this.drawOutlineSubtype = st;
    if (p >= 100) {
      this.drawOutline = false;
      // this.stroke = true;
      // this.strokeColor = c;
    }
    if ( p <= 0) {
      this.drawOutline = false;
    }
  }
  protected void setDrawOutlinePercent( float p) {
    this.drawOutlinePercent = p;
  }
  protected void setDrawOutlineType( int t) {
    this.drawOutlineType = t;
  }
  protected void setDrawOutlineSubtype( boolean s) {
    this.drawOutlineSubtype = s;
  }



  /*
    private boolean animateStroke = false;
   private int animateStrokeType = 0; 
   private float animateStrokePercent = 0;
   
   private boolean outline = false;
   private int outlineType = 0;
   
   private boolean drawFill = false;
   private float drawFillPercent = 0;
   private String drawFillType ="";
   
   private boolean drawOutline = false;
   private float drawOutlinePercent = 0;
   private int drawOutlineType = 0;
   private boolean drawOutlineSubtype = false;
   
   */


  /////////////////////USER GETTER/ SETTER END  ///////////////////

  /////////////////////STOKE ANIMATION ///////////////////

  private void animateStroke(int type, float percent, color c) {

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

  private void outline(int type, color c) {
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


  private void drawOutline(int type, boolean subtype, float percent, color c) {

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



  private void drawFill(String type, float percent, color c) {
    calcFillCoords(type, percent);
    fill(c);
    noStroke();
    beginShape();
    for ( int i = 0; i < 4; i++) {
      vertex(fCoordinates[i][0], fCoordinates[i][1]);
    }
    endShape(CLOSE);
  }

  private void calcFillCoords(String type, float percent) {
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

  /////////////////////STOKE ANIMATION END ///////////////////
}