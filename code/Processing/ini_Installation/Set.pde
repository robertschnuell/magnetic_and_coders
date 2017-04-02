class Set {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */

  public ArrayList <Layer> layers;

  protected Set() {
    layers = new ArrayList<Layer>();
 
  }

  protected void update() {

  
    for ( int i = 0; i< layers.size(); i++) {
     if(layers.get(i).update()) {
      // layers.add(new L_FillUp(int(random(0, view.getCubeCount())), int(random(100,1000))));
     }
    }

  }

  protected void addLayer(String type) {
    if (type.equals("FILL_CUBE_RIGHT")) {
      layers.add(new L_FillUp(int(random(0, view.getCubeCount())), 1000));
    }
  }
}