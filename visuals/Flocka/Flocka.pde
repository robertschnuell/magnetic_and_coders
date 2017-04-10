import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus - Chuchu
boolean midiInput = false;


Flock flock;

void setup() {
  size(1280, 720);
  myBus = new MidiBus(this, "LPD8", "");
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 1; i++) {
    Boid b = new Boid(width/2, height/2);
    flock.addBoid(b);
  }
  smooth();
  //noCursor();

  flock.run();
}

void draw() {


  int channel = 0;
  int pitch = 64;
  int velocity = 127;
  int number = 0;
  int value = 180;

  myBus.sendControllerChange(channel, number, value); // Send a controllerChange


  fill(0, 80);
  rect(-10, -10, width+15, height+15);
  //background(255);
  flock.run();

  // Instructions
  fill(0);
  //text("Drag the mouse to generate new boids.",10,height-16);
}


void controllerChange(int channel, int number, int value) {

  if ( number == 1) {

    flock.boids.get(0).setEllipse(4, value, value);
  }
}

// Add a new boid into the System
void mouseClicked() {
  flock.addBoid(new Boid(mouseX, mouseY));
}

void mouseDragged() {
  flock.addBoid(new Boid(mouseX, mouseY));
}