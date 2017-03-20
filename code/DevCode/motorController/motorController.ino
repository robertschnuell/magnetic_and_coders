#include <Stepper.h>

const int stepsPerRevolution = 200;
Stepper m1(stepsPerRevolution, 8, 9, 10, 11);

const byte ledPin = 13;
const byte interruptPin = 3;
volatile boolean limitSwitch = false;


int currentPos = 0;
int targetPos = 0;
int homePos = 0;

int startPos = 1000;
int endPos = 2000;

unsigned long lastStatus = 0;




boolean ini = false;

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(interruptPin, CHANGE);
  attachInterrupt(digitalPinToInterrupt(interruptPin), inter, CHANGE);

  m1.setSpeed(60);
  Serial.begin(9600);

  limitSwitch = false;
  ini_();

  Serial.print("Home is : ");
  Serial.println(homePos);

}

void ini_() {
  currentPos = 0;
  targetPos = 0;
  homePos = 0;
  
  while (!ini) {
    m1.step(-1);
    homePos++;
    if (limitSwitch) {
      ini = true;
      limitSwitch = false;
    }

  }

  delay(2000);
  Serial.println("going to StartPos");
  m1.step(startPos);
  delay(5000);
  Serial.println("ini finished");

}

void loop() {
  if (limitSwitch) {
    Serial.println("bing");
    stopMotor();
  }

  if( (lastStatus + 300) < millis()) {
    lastStatus = millis();
    showStatus();
  }
  

  if (targetPos != currentPos) {
    if (currentPos < targetPos) {
      m1.step(1);
      currentPos++;
    }
    if (currentPos > targetPos) {
      m1.step(-1);
      currentPos--;
    }
    
  } else {
    targetPos = random (startPos, endPos);
    Serial.print("new Target: ");
    Serial.println(targetPos);
  }

}

void showStatus() {
  Serial.print( "Home: ");
  Serial.print(homePos);
  
  Serial.print("\t Start");
  Serial.print(startPos);

  Serial.print("\t \t Current");
  Serial.print(currentPos);

  Serial.print("\t \t Target");
  Serial.print(targetPos);

  Serial.print("\t End");
  Serial.println(endPos);
}

void stopMotor() {
  delay(500);

  m1.step(-1000);
  delay(500);
  ini = false;
  ini_();
}

void inter() {
  limitSwitch = !limitSwitch;

}
