class Set {
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

  public ArrayList <Layer> layers;

  protected Set() {
    layers = new ArrayList<Layer>();
  }

  protected void update() {


    for ( int i = 0; i< layers.size(); i++) {
      if (layers.get(i).update()) {
        // layers.add(new L_FillUp(int(random(0, view.getCubeCount())), int(random(100,1000))));
      }
    }
  }

  protected void addLayer(String type) {
    if (type.equals("FILL_CUBE_RIGHT")) {
      layers.add(new L_FillUp(int(random(0, view.getCubeCount())), 1000));
    } else if (type.equals("SINUS")) {
      layers.add(new ML_Sinus(10000, 1, 7, .075, 75) );
      //ML_Sinus(int duration, int from, int to, float speed, float amp)
    }
  }
}