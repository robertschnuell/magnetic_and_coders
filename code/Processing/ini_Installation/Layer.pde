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
  protected String name;
  protected Layer(long duration,String name) {
    this.start = millis();
    this.duration = duration;
    this.name = name;
  }

  protected boolean update() {

    if ( (start + duration) < millis() ) {
      return true;
    } else {
      //do 
      return false;
    }
  }
  
  protected String getName() {
    return this.name;
  }
  protected long getDuration() {
    return this.duration;
  }

  protected void selfdestuction() {
    set.layers.remove(this);
  }
}