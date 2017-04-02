# Cube function overview
magnetic and coders installation

## Hierarchy
the last named function overlaps the aforementioned functions
- fill()
- stroke()
- drawFill()
- animateStroke()
- outline()
- drawOutline()



## General | static

### protected void setFill( boolean f)
  - f: true | false   : activate fill and draws this in update()

### protected void setStroke( boolean s)
  - s: true | false   : activate fill and draws this in update()


## Fill Color | static

### protected void setFillColor(color c)
  - c: (0-255,0-255,0-255)   : defines the fill color and draws this in update()

### protected void setFillColor(int r, int g, int b)
  - r: (0-255)   : defines the fill red color channel and draws this in update()
  - g: (0-255)   : defines the fill green color channel and draws this in update()
  - b: (0-255)   : defines the fill blue color channel and draws this in update()

### protected void setFillColor( int r, int g, int b, int a)
  - r: (0-255)   : defines the fill red color channel and draws this in update()
  - g: (0-255)   : defines the fill green color channel and draws this in update()
  - b: (0-255)   : defines the fill blue color channel and draws this in update()
  - a: (0-255)   : defines the fill transparent color channel and draws this in update()

### protected void setFillColor(int c, int a)
  - c: (0-255,0-255,0-255)   : defines the fill color and draws this in update()
  - a: (0-255)   : defines the fill transparent color channel and draws this in update()


## Stroke Color | static

### protected void setStrokeColor(color c)
  - c: (0-255,0-255,0-255)   : defines the stroke color and draws this in update()

### protected void setStrokeColor(int r, int g, int b)
  - r: (0-255)   : defines the stroke red color channel and draws this in update()
  - g: (0-255)   : defines the stroke green color channel and draws this in update()
  - b: (0-255)   : defines the stroke blue color channel and draws this in update()

### protected void setStrokeColor( int r, int g, int b, int a)
  - r: (0-255)   : defines the stroke red color channel and draws this in update()
  - g: (0-255)   : defines the stroke green color channel and draws this in update()
  - b: (0-255)   : defines the stroke blue color channel and draws this in update()
  - a: (0-255)   : defines the stroke transparent color channel and draws this in update()

### protected void setStrokeColor(int c, int a)
  - c: (0-255,0-255,0-255)   : defines the stroke color and draws this in update()
  - a: (0-255)   : defines the stroke transparent color channel and draws this in update()

## Animate Stroke | animated

### protected void setAnimateStroke( boolean s)
  - s: true | false   : activate animateStroke and draws this in update()

### protected void setAnimateStroke(boolean s, float p, int t, color c)
  - s: true | false   : activate animateStroke and draws this in update()
  - p: (0.00-100.00)   : current progress of the animation given in percent
  - t: (0-1)   : different kinds of the animation type
    - 0 :  clockwise
    - 1 :  anti clockwise
  - c: (0-255,0-255,0-255)   : defines the animateStroke color and draws this in update()

### protected void setAnimateStrokePercent( float p)
  - p: (0.00-100.00)   : current progress of the animation given in percent

### protected void setAnimateStrokeType(int  t)
  - t: (0-1)   : different kinds of the animation type
    - 0 :  clockwise
    - 1 :  anti clockwise

## Outline | static

### protected void setOutline( boolean s)
  - s: true | false   : activate Outline and draws this in update()

### protected void setOutline(boolean s, int t, color c)
  - s: true | false   : activate Outline and draws this in update()
  - t: (0-3)   : different kinds of the positions of the outline
    - 0 :  top
    - 1 :  left
    - 2 : bottom
    - 3 : right
  - c: (0-255,0-255,0-255)   : defines the Outline color and draws this in update()

### protected void setOutlineType( int t)
  - t: (0-3)   : different kinds of the positions of the outline
    - 0 :  top
    - 1 :  left
    - 2 : bottom
    - 3 : right


## Draw Fill | animated

### protected void setDrawFill( boolean s)
  - s: true | false   : activate DrawFill and draws this in update()

### protected void setDrawFill(boolean s, float p, String t, color c)
  - s: true | false   : activate DrawFill and draws this in update()
  - p: (0.00-100.00)   : current progress of the animation given in percent
  - t: (String)   : different kinds of the animation type
    - "LEFT" :  from left to right
    - "RIGHT" :  from right to left
    - "BOTTOM" : from bottom to top
    - "TOP" : from top to bottom
  - c: (0-255,0-255,0-255)   : defines the drawFill color and draws this in update()

### protected void setDrawFillPercent( float p)
  - p: (0.00-100.00)   : current progress of the animation given in percent

### protected void setDrawFillType ( String t)
  - t: (String)   : different kinds of the animation type
    - "LEFT" :  from left to right
    - "RIGHT" :  from right to left
    - "BOTTOM" : from bottom to top
    - "TOP" : from top to bottom


## draw Outline | animated

### protected void setDrawOutline(boolean s)
  - s: true | false   : activate DrawOutline and draws this in update()

### protected void setDrawOutline(boolean s, float p, int t, boolean st, color c)
  - s: true | false   : activate DrawOutline and draws this in update()
  - p: (0.00-100.00)   : current progress of the animation given in percent
  - t: (0-7)   : different kinds of the animation type
    - 0 :  TOP left to right
    - 1 :  LEFT top to bottom
    - 2 :  BOTTOM left to right
    - 3 :  RIGHT bottom to top
    - 4 :  TOP right to left
    - 5 :  LEFT bottom to top
    - 6 :  BOTTOM right to left
    - 7 :  RIGHT top to bottom
  -st: true | false : if activated the opposite side is drawn simultaneously
  - c: (0-255,0-255,0-255)   : defines the drawFill color and draws this in update()

### protected void setDrawOutlinePercent( float p)
  - p: (0.00-100.00)   : current progress of the animation given in percent

### protected void setDrawOutlineType( int t)
- t: (0-7)   : different kinds of the animation type
  - 0 :  TOP left to right
  - 1 :  LEFT top to bottom
  - 2 :  BOTTOM left to right
  - 3 :  RIGHT bottom to top
  - 4 :  TOP right to left
  - 5 :  LEFT bottom to top
  - 6 :  BOTTOM right to left
  - 7 :  RIGHT top to bottom

### protected void setDrawOutlineSubtype( boolean s)
  - s: true | false : if activated the opposite side is drawn simultaneously
