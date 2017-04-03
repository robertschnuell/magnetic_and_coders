class L_Fill extends Layer {

  private int id; 
  private float fill; 
  private String type;
  
  protected L_Fill(int cubeId, long duration, String type) {
    super(duration);
    this.id = cubeId;
    this.fill = 0;
    this.type = type;
  }
 
  protected boolean update() {
    boolean response = super.update();
    fill = map(millis(), start, start+duration, 0, 100);
    view.cubes.get(id).setDrawFill(true, fill, type, color(255, 0, 0));

    if ( response) {
      view.cubes.get(id).setDrawFill(false);
      
      super.selfdestuction();
    }
    return response;
  }
}