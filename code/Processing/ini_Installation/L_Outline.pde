class L_Outline extends Layer {

  private int id; 
  private float fill; 
  private int type;
  
  protected L_Outline(String name, int cubeId, long duration, int type) {
    super(duration,name);
    this.id = cubeId;
    this.fill = 0;
    this.type = type;
  }
 
  protected boolean update() {
    boolean response = super.update();
    fill = map(millis(), start, start+duration, 0, 100);
    view.cubes.get(id).setDrawOutline(true, fill, type, true, color(255, 0, 0));
    
    if ( response) {
      view.cubes.get(id).setDrawOutline(false);
      
      super.selfdestuction();
    }
    return response;
  }
}