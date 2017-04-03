class ML_Home extends MLayer {

  int usedColumns;
  protected ML_Home(int [] usedColumns, float pos) {
    super(usedColumns);
println("home");
    set.mLayers.clear();
    set.mLayers.add(this);

    for ( int i = 0; i < installation.getColumns(); i++) {
      installation.setTarget(i, constrain(pos, 0, 100));
    }
    
    set.mLayers.clear();
    
  }

  protected boolean update() {
    boolean response = super.update();



    return response;
  }
}