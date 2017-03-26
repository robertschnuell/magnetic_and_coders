class Layer {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */

  private long start;
  private long duration;
  private Layer(long duration) {
    this.start = millis();
    this.duration = duration;
  }

  private boolean update() {
    if ( (start + duration) < millis() ) {
      return true;
    } else {
      //do 
      return false;
    }
  }
}