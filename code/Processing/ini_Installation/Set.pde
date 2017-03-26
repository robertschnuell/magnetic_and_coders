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
      }
    }

    // ToDo : validate for() algorithm
    for ( int i = removeCandidates.size()-1; i >= 0; i++) { // reverse deleating -> no inter stepping
      layers.remove(i);
    }
  }
}