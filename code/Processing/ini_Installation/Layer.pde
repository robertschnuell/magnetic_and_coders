class Layer {
  
  long start;
  long duration;
  Layer(long duration) {
    this.start = millis();
    this.duration = duration;
  }
  
  boolean update() {
    if( (start + duration) < millis() ) {
      return true;
    } else {
      //do 
      return false;
    }
  }
    
}