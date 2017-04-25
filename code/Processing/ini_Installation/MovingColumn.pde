class MovingColumn {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   
   license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
   - https://creativecommons.org/licenses/by-nc-sa/4.0/
   */

  private float lastBeginPos;
  private float targetPos;
  private float speed;
  private boolean easing;
  private String currentMLayerId;
  private int id;
  private float easingSpeed;
  private long lastSpeedSend = 0;
  private long speedSendInterv = 70;
  private long lastCurrentPosTimer = 0;
  private float lastCurrentPos = 0;
  private long lastCurrentInterv = 100;
  private float maxSpeed = 100;

  protected MovingColumn(int id) {
    this.lastBeginPos = 0;
    this.targetPos = 0;
    this.speed = 50;
    this.easing = true;
    this.id = id;

    this.lastCurrentPos = installation.getColumnPercent(id);
  }

  private void sendTarget() {

    installation.setTarget(id, constrain(targetPos, 0, 100));
  }
  protected void setTarget(float target) {
    //println("targetPos " + targetPos + "\t target: " + target);
    // println(calcEasing());

    if (  (lastCurrentPos  != installation.getColumnPercent(id))) {
      lastCurrentPosTimer = millis();
      lastCurrentPos = installation.getColumnPercent(id);
    } 

    if ( (lastCurrentInterv + lastCurrentPosTimer) < millis()) {
      if (!getMoving()) {




        println("new Target: " + target);

        lastBeginPos = targetPos;
        targetPos = target;
        sendTarget();
      }
    }
  }
  protected void sendSpeed() {
    if ( (lastSpeedSend + speedSendInterv) < millis() ) {
      lastSpeedSend = millis();
      if (easing) {
        float tmp = map(constrain(calcEasing(),1,50),1,50,1,maxSpeed);
        println(tmp);
        installation.setSpeed(id, tmp);

      }
    }
  }

  protected boolean getMoving() {

    if ( abs(targetPos - installation.getColumnPercent(id)) < 1  ) {
      return false;
    } else {
      return true;
    }
  }


  private float calcEasing() {
    float tmpEasing = 0;
    float result = 100;

    tmpEasing = abs(installation.getColumnPercent(id) - abs(lastBeginPos-targetPos) );

    /*
    if (tmpEasing < 20 && tmpEasing > 80) {
     if (tmpEasing < 20) {
     result = map(abs(0-tmpEasing), 0, 20, min(speed, 10), speed);
     } else if (tmpEasing > 80) {
     result = map(abs(100-tmpEasing), 0, 20, min(speed, 10), speed);
     }
     } else {
     result = tmpEasing;
     }
     */
    result = tmpEasing;
    result = abs(installation.getColumnPercent(id) - targetPos);
    if ( abs(installation.getColumnPercent(id) - targetPos) <  abs(installation.getColumnPercent(id) - lastBeginPos)  ) {
      result = abs(installation.getColumnPercent(id) - targetPos);
    } else {
      result = abs(installation.getColumnPercent(id) - lastBeginPos);
    }
    return result;
  }
}