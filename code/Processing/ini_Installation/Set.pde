class Set {
  
  ArrayList <Layer> layers;
  ArrayList <Integer> removeCandidates;
  
  Set() {
    layers = new ArrayList<Layer>();
    removeCandidates = new ArrayList<Integer>();
  }
  
  void update() {
    removeCandidates.clear();
    for ( int i = 0; i< layers.size(); i++) {
      if(layers.get(i).update()) {
        removeCandidates.add(i);
      }
    }
    
    // ToDo : validate for() algorithm
    for( int i = removeCandidates.size()-1; i >= 0 ;i++) { // reverse deleating -> no inter stepping
      layers.remove(i);
    }
       
  }


}