import themidibus.*; 
MidiBus testMidi; 


Installation installation;



void setup() {

  size(1280, 720);
  background(0);


  testMidi = new MidiBus(this, "LPD8", -1); 
  
  
  //INI INSTALLATION
  float pos[][] = new float[1][2];
  pos[0][0] = width/4;
  pos[0][1] = 100;
 // pos[1][0] = width/4*2;
  //pos[1][1] = 100;
  installation = new Installation(1,pos,1);


}



void draw() {
  background(0);
  
  installation.update();

  //left.update();
  //right.update();
}

public void keyPressed()
{
  if (key == CODED) {
    if (keyCode == UP) {
      //send up

     // left.checkKey(0);
     // right.checkKey(0);
    } else if (keyCode == DOWN) {
      //send down
     // left.checkKey(1);
     // right.checkKey(1);
    } else if (keyCode == LEFT) {
      //send left
     // left.checkKey(2);
     // right.checkKey(2);
    } else if (keyCode == RIGHT) {
      //send right
     // left.checkKey(3);
     // right.checkKey(3);
    }
  }


  if (key == '1' )
  {
    println(1);
   // left.showStates(!left.getShowStates());
  } else if (key == '2' ) {
   // right.showStates(!right.getShowStates());
  }
}


void mousePressed() {
  installation.checkMouse();
}




//MIDI

void controllerChange(int channel, int number, int value) {
  float tmpPerc = map(value, 0, 127, 0.1, 100);

  switch(number) {
  case 1:
    installation.setColumnPerc(0,0, tmpPerc);
    break;
  case 2: 
    installation.setColumnPerc(0,1, tmpPerc);
    break;
  case 3:
    installation.setColumnPerc(0,2, tmpPerc);
    break;
  case 4: 
    installation.setColumnPerc(0,3, tmpPerc);
    break;
  case 5:
    installation.setColumnPerc(1,0, tmpPerc);
    break;
  case 6:
    installation.setColumnPerc(1,1, tmpPerc);
    break;
  case 7: 
    installation.setColumnPerc(1,2, tmpPerc);
    break;
  case 8:
    installation.setColumnPerc(1,3, tmpPerc);
    break;
  default:
  }
}