class Layer {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */

  protected long start;
  protected long duration;
  protected Layer(long duration) {
    this.start = millis();
    this.duration = duration;
  }

  protected boolean update() {

    if ( (start + duration) < millis() ) {
       set.layers.remove(this);
      return true;
    } else {
      //do 
      return false;
    }
  }
}