class View {


  public ArrayList <Cube>cubes;

  View(int cubeCount) {
    cubes = new ArrayList <Cube>();

    for ( int i = 0; i< cubeCount; i++) {
      cubes.add(new Cube());
    }
  }

  protected void update() {
    for ( int i = 0; i < cubes.size(); i++) {
      cubes.get(i).update();
    }
  }

  protected void newData(float [][][] d) {
    for ( int i = 0; i < d.length; i++) {
      float[][] tmp = new float[4][2];
      tmp = d[i];
      cubes.get(i).newData(tmp);
    }
  }

  protected int getCubeCount() {
    return cubes.size();
  }
}