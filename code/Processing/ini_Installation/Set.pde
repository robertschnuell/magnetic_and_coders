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
  public ArrayList <MLayer> mLayers;

  protected Set() {
    layers = new ArrayList<Layer>();
    mLayers = new ArrayList<MLayer>();
  }

  protected void update() {


    for ( int i = 0; i< layers.size(); i++) {
      if (layers.get(i).update()) {
        // layers.add(new L_FillUp(int(random(0, view.getCubeCount())), int(random(100,1000))));
      }
    }

    for ( int i = 0; i< mLayers.size(); i++) {
      mLayers.get(i).update();
    }
  }

  protected void addLayer(String type) {
    if (type.equals("FILL_CUBE_RIGHT")) {
      layers.add(new L_FillUp(int(random(0, view.getCubeCount())), 1000));
    } else if (type.equals("SINUS")) {

      //ML_Sinus(int duration, int from, int to, float speed, float amp)
    }
  }

  protected void addMLayer(String type, int from, int to) {
    int[] tmp = new int[to-from];
    for ( int i = 0; i < tmp.length;i++) {
      tmp[i] = from+i;
    }
    if (type.equals("SINUS")) {
      mLayers.add(new ML_Sinus(tmp,10000, .075, 75) );
    }
  }
}