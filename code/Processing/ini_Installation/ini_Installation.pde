import themidibus.*; 
MidiBus testMidi; 

Side left;

Side right;



void setup() {

  size(1280, 720);
  background(0);

  left = new Side(4, width/4, 100);
  right = new Side(4, width/4*2, 100);

  testMidi = new MidiBus(this, "LPD8", -1); 


  //println(squares.length);
}



void draw() {
  background(0);

  left.update();
  right.update();
}

public void keyPressed()
{
  if (key == CODED) {
    if (keyCode == UP) {
      //send up

      left.checkKey(0);
      right.checkKey(0);
    } else if (keyCode == DOWN) {
      //send down
      left.checkKey(1);
      right.checkKey(1);
    } else if (keyCode == LEFT) {
      //send left
      left.checkKey(2);
      right.checkKey(2);
    } else if (keyCode == RIGHT) {
      //send right
      left.checkKey(3);
      right.checkKey(3);
    }
  }


  if (key == '1' )
  {
    println(1);
    left.showStates(!left.getShowStates());
  } else if (key == '2' ) {
    right.showStates(!right.getShowStates());
  }
}


void mousePressed() {
  left.checkMouse();
  right.checkMouse();
}




//MIDI

void controllerChange(int channel, int number, int value) {
  float tmpPerc = map(value, 0, 127, 0.1, 100);

  switch(number) {
  case 1:
    left.setPerc(0, tmpPerc);
    break;
  case 2: 
    left.setPerc(1, tmpPerc);
    break;
  case 3:
    left.setPerc(2, tmpPerc);
    break;
  case 4: 
    left.setPerc(3, tmpPerc);
    break;
  case 5:
    right.setPerc(0, tmpPerc);
    break;
  case 6:
    right.setPerc(1, tmpPerc);
    break;
  case 7: 
    right.setPerc(2, tmpPerc);
    break;
  case 8:
    right.setPerc(3, tmpPerc);
    break;
  default:
  }
}