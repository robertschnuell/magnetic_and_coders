// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2009

// Boid class
// Methods for Separation, Cohesion, Alignment added

class Boid {

  PVector location;
  PVector velocity;
  PVector acceleration;


  float[] px, py, cx, cy, cx2, cy2;
  int points;

  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  int strokeW = 1;

  Boid(float x, float y) {
    points = 4;
    //r = this.r;

    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = new PVector(x, y);

    //maxspeed = this.maxspeed;
    //maxforce = this.maxforce;

    maxspeed = 1;
    maxforce = 0.1;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    pushMatrix();
    translate(location.x, location.y);
    render();
    popMatrix();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    
  }

  // Method to update location
  void update() {

    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    
    
  }

  void drawCircle() {
    strokeWeight(1);
    stroke(255);
    noFill();

    // create ellipse
    for (int i=0; i < points; i++) {
      if (i==points-1) {
        bezier(px[i], py[i], cx[i], cy[i], cx2[i], cy2[i], px[0], py[0]);
      } else {
        bezier(px[i], py[i], cx[i], cy[i], cx2[i], cy2[i], px[i+1], py[i+1]);
      }
    }
  }

  void setEllipse(int pointsS, float radius, float controlRadius, float speed, float force) {
    points = pointsS;
    r = radius;
    maxspeed = speed;
    maxforce = force;
    
    
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



  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    pushMatrix();
    translate(-width/2, -height/2);
    //setEllipse(points, r, r, maxspeed);
    setEllipse(points, r, r, maxspeed, maxforce);
    //setEllipse(int(random(3, 12)), random(-100, 150), random(-100, 150), random(-100, 150), random(-100, 150));
    drawCircle();
    popMatrix();
  }

  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } else {
      return new PVector(0, 0);
    }
  }
}