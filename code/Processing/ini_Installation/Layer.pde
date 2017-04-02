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
  protected String type;
  protected Layer(long duration) {
    this.start = millis();
    this.duration = duration;
  }

  protected boolean update() {

    if ( (start + duration) < millis() ) {
      return true;
    } else {
      //do 
      return false;
    }
  }

  protected void selfdestuction() {
    set.layers.remove(this);
  }
}