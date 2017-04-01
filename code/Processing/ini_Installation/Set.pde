class Set {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */

  private ArrayList <Layer> layers;
  private ArrayList <Integer> removeCandidates;

  protected Set() {
    layers = new ArrayList<Layer>();
    removeCandidates = new ArrayList<Integer>();
  }

  protected void update() {

    removeCandidates.clear();
    for ( int i = 0; i< layers.size(); i++) {
      if (layers.get(i).update()) {
        removeCandidates.add(i);
       // println("re" + i);
      }
    }

    if ( (layers.size() > 1) && (removeCandidates.size() != 0)  ) {
      for ( int i = removeCandidates.size()-1; i >= 0; i++) { // reverse deleating -> no inter stepping
       // println("ls: " +layers.size());
       // println("rc size: " +removeCandidates.size());
        //println("rc real: "+removeCandidates.get(i));
        layers.remove(removeCandidates.get(i));
      }
    } else if( removeCandidates.size() == 1)  {
      layers.remove(0);
    }
   // println("layer size: " + layers.size());
   // println("remove candidats size" + removeCandidates.size() );
  }

  protected void addLayer(String type) {
    if (type.equals("FILL_CUBE_RIGHT")) {
      layers.add(new L_FillUp(int(random(0, view.getCubeCount())), 1000));
    }
  }
}