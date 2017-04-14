class L_Fill extends Layer {
  
   /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Jannik Bussmann <@jannikbussmann>
   @author Robert Schnüll <@robertschnuell>
   
   license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
   - https://creativecommons.org/licenses/by-nc-sa/4.0/
   */

  private int id; 
  private float fill; 
  private String type;
  private boolean reverse;

  protected L_Fill(String name, int cubeId, long duration, String type, boolean reverse) {
    super(duration,name);
    this.id = cubeId;
    this.fill = 0;
    this.type = type;
    this.reverse = reverse;
  }

  protected boolean update() {
    boolean response = super.update();
    fill = map(millis(), start, start+duration, 0, 100);
    if (reverse) {
      view.cubes.get(id).setDrawFill(true, 100-fill, type, color(255, 0, 0));
    } else {
  view.cubes.get(id).setDrawFill(true, fill, type, color(255, 0, 0));
}

if ( response) {
  if (reverse) {
    view.cubes.get(id).setDrawFill(false);
  } else {
    view.cubes.get(id).setDrawFill(true);
  }

  super.selfdestuction();
}
return response;
}
}