


Mode m;

void setup() {
  size(1280,720);
  background(0);
  
  
  m = new Mode(50,width-50,10);
}

void draw() {
  
  m.easeUpdate();
  
  background(0);
  
  ellipse(m.getC(),height/2,10,10);
  
  
}

void keyPressed() {
  m.setT(int(random(50,width-50)));
}