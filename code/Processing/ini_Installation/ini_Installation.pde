
Square s1;

Side s;



void setup() {

  size(1280, 720);
  background(0);

  s1 = new Square(300, 300, 50);

  s1.addState(300, 500, 75);
  s1.addState(300, 600, 75);

  s1.editStatePos(1, 0, 253, 520);
  s1.editStatePos(2, 2, 350, 620);


  s = new Side(4, width/2, 100);




  //println(squares.length);
}



void draw() {
  background(0);
  s1.setPerc(map(mouseY, 0, height, 0, 100));
  s1.update();

  s.update();
}

public void keyPressed()
{
  if (key == '1' )
  {
    println(1);
  } else if (key == '2' ) {
    println(2);
  }
}


void mousePressed() {
  s.checkMouse();
}