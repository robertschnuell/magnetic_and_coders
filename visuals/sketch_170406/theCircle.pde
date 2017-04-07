class theCircle {
  float[] px, py, cx, cy, cx2, cy2;
  int points;
  float r;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  theCircle(float x, float y) {
    points = 4;
    r = 1.0;
    acceleration = new PVector(0, 0);
    location = new PVector(x, y);
    velocity = new PVector(0, -2);
    maxspeed = 4;
    maxforce = 0.1;
  }

  // Method to update location
  void update() {  // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  void drawCircle() {
    strokeWeight(1);
    stroke(255);
    noFill();

    // create ellipse
    for (int i=0; i<points; i++) {
      if (i==points-1) {
        bezier(px[i], py[i], cx[i], cy[i], cx2[i], cy2[i], px[0], py[0]);
      } else {
        bezier(px[i], py[i], cx[i], cy[i], cx2[i], cy2[i], px[i+1], py[i+1]);
      }
    }
  }

  void setEllipse(int pointsS, float radius, float controlRadius) {
    points = pointsS;
    px = new float[pointsS];
    py = new float[pointsS];
    cx = new float[pointsS];
    cy = new float[pointsS];
    cx2 = new float[pointsS];
    cy2 = new float[pointsS];

    float angle = 360.0/pointsS;
    float controlAngle1 = angle/3.0;
    float controlAngle2 = controlAngle1*2.0;
    for ( int i=0; i<pointsS; i++) {
      px[i] = width/2+cos(radians(angle))*radius;
      py[i] = height/2+sin(radians(angle))*radius;
      cx[i] = width/2+cos(radians(angle+controlAngle1))* controlRadius/cos(radians(controlAngle1));
      cy[i] = height/2+sin(radians(angle+controlAngle1))* controlRadius/cos(radians(controlAngle1));
      cx2[i] = width/2+cos(radians(angle+controlAngle2))* controlRadius/cos(radians(controlAngle1));
      cy2[i] = height/2+sin(radians(angle+controlAngle2))* controlRadius/cos(radians(controlAngle1));

      //increment angle so trig functions keep chugging along
      angle+=360.0/points;
    }
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }


  void interaction() {
    if (keyPressed == true) {
      if (key == 'r' || key == 'R') {
        r = r + 1;
        //theCir.setEllipse(int(random(0, 2)), random(-10, 10), random(-10, 15));
      }
    }

    if (r > 100) {
      r = 0;
    }
  }


  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }


  void startCircle() {
    setEllipse(points, r, r);
    drawCircle();
    interaction();
  }

  void display() { 
    pushMatrix();
    translate(location.x, location.y);
    //rect(0,0,100,100);
    //fill(255);
    setEllipse(points, r, r);

    //theCir.setEllipse(int(random(3, 12)), random(-100, 150), random(-100, 150));
    drawCircle();
    popMatrix();
    interaction();
  }
}