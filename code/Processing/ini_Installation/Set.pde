class Set {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */

  protected ArrayList <Layer> layers;

  protected Set() {
    layers = new ArrayList<Layer>();
 
  }

  protected void update() {

  
    for ( int i = 0; i< layers.size(); i++) {
     layers.get(i).update();
    }

  }

  protected void addLayer(String type) {
    if (type.equals("FILL_CUBE_RIGHT")) {
      layers.add(new L_FillUp(int(random(0, view.getCubeCount())), 1000));
    }
  }
}