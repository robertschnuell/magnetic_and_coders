/* =============== LIBRARIES =============== */
//import codeanticode.syphon.*;

/* ================= CLASS ================= */
//SyphonServer server;
theCircle theCir;

void settings() {
  size(1280, 720, P3D);
  PJOGL.profile=1;
}


void setup() {  
  //server = new SyphonServer(this, "Processing Syphon");

  theCir = new theCircle(width/2, height/2);
  smooth();

  background(0);
}

void draw() {
  //background(0);
  fill(0, 10);
  rect(-10, -10, width+15, height+15);

  theCir.startCircle();

  if (keyPressed == true) {
    if (key == 'm') {
      update();
    } else {
      /*--*/
    }
  }

  //server.sendScreen();
}

void update() {

  PVector mouse = new PVector(mouseX, mouseY);

  // Draw an ellipse at the mouse location
  noFill();
  stroke(0);
  strokeWeight(0);
  ellipse(mouse.x, mouse.y, 48, 48);


  theCir.seek(mouse);
  theCir.update();
  theCir.display();

  //theCir.drawCircle();
}

void keyPressed() {
  //theVe.interaction();
  //theCir.setEllipse(int(random(3, 12)), random(-100, 150), random(-100, 150));
}