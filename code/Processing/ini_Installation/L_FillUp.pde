class L_FillUp extends Layer  {
  
  private int id; 
  private float fill; 
  protected L_FillUp(int cubeId, long duration) {
    super(duration);
    this.id = cubeId;
    this.fill = 0;
  }
  
  protected boolean update() {
    boolean response =      super.update();
    fill = map(millis(),start,start+duration,0,100);
    view.cubes.get(id).drawFill("RIGHT",fill,color(255,0,0));
    
    if( response) {
     
    }
    return response;
    
  }
  
  
  
}