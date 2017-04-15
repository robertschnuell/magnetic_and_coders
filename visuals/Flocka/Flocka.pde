import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus - Chuchu
boolean midiInput = false;


int objectPoints = 4;
float objectRadius = 0;
float objectRR = 0;
float objectSpeed = 0;
float objectForce = 0;

Flock flock;

void setup() {
  size(1280, 720);
  myBus = new MidiBus(this, "MIDI Mix", "");
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

  fill(0, 40);
  rect(-10, -10, width+15, height+15);
  //background(255);
  flock.run();
}

void controllerChange(int channel, int number, int value) {


  for ( int i = 0; i < flock.boids.size(); i++) {
    flock.boids.get(i).setEllipse(objectPoints, objectRadius, objectRR, objectSpeed, objectForce);
  }


  if ( number == 18) {
    objectRadius = value;
    //objectRR = value;
  }

  if ( number == 22) {
    objectSpeed = value/10;
    objectForce = value;
    println("speed "+objectSpeed);
  }

  if ( number == 26) {
    objectForce = value/10;
    println("force "+objectForce);
  }
  
    if ( number == 30) {
    objectPoints = value/10;
    println("points "+objectPoints);
  }
  
  if (number == 48) {
   objectRR = value*2; 
    println("objectRR "+objectRR);
  }
 
}


// Add a new boid into the System
void mouseClicked() {
  flock.addBoid(new Boid(mouseX, mouseY));
}

void mouseDragged() {
  flock.addBoid(new Boid(mouseX, mouseY));
}