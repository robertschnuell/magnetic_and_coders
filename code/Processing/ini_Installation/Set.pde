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


  public String mColumnUse[];

  protected Set() {
    layers = new ArrayList<Layer>();
    mLayers = new ArrayList<MLayer>();

    mColumnUse = new String[installation.getColumns()];
  }

  protected void update() {


    for ( int i = 0; i< layers.size(); i++) {
      if (layers.get(i).update()) {
        // layers.add(new L_FillUp(int(random(0, view.getCubeCount())), int(random(100,1000))));
      }
    }


    for ( int i = 0; i< mLayers.size(); i++) {
      ArrayList<Integer> tmp = new ArrayList<Integer>();

      for ( int j = 0; j < mColumnUse.length; j++) {
        if ( (mLayers.get(i).getId()).equals(mColumnUse[j]) ) {

          tmp.add(j);
        }



        mLayers.get(i).update(tmp);
      }
    }
  }



  /*

   protected void addMLayer(String type, int from, int to) {
   ArrayList<Integer> tmp = new ArrayList<Integer>;
   for ( int i = 0; i < (to-from); i++) {
   tmp.add(i);
   }
   if (type.equals("SINUS")) {
   mLayers.add(new ML_Sinus(tmp, 10) );
   }
   }
   
   protected void addMLayer(String type) {
   int[] tmp = new int[installation.getColumns()];
   for ( int i = 0; i < tmp.length; i++) {
   tmp[i] = i;
   }
   if (type.equals("HOME")) {
   
   mLayers.add(new ML_Home(tmp, 50) );
   }
   }
   
   
   protected void addMLayer(String type, int c, float p) {
   int[] tmp = new int[1];
   for ( int i = 0; i < tmp.length; i++) {
   tmp[i] = c;
   }
   if (type.equals("POSITION")) {
   mLayers.add(new ML_Position(tmp, p, 100) );
   }
   }
   
   
   protected void sendMLayerData(String type, boolean a) {
   for ( int i = 0 ; i < columnUse.length;i++) {
   if(type.equals(columnUse[i])) {
   for( int j = 0; j < mLayers.size(); j++) {
   if(mLayers.get(j).getId().equals(columnUse[i]) {
   mLayers.get(j).setActive(i);
   }
   }
   
   }
   }
   */



  protected void addMLayerData(String type, int from, int to, float p) {
    println(mLayers.size());
    if (type.equals("POSITION")) {
      ArrayList <Integer> tmp = new ArrayList<Integer>();
      for ( int i = 0; i < (to-from); i++) {
        tmp.add(i);
      }
      mLayers.add(new ML_Position(tmp, p, 10));
      for (int i = from; i < to; i++) {
        mColumnUse[i] = mLayers.get(mLayers.size()-1).getId();
      }
    }
  }

  protected void removeMLayer(int id) {
    if ( id < mLayers.size()) {
      mLayers.remove(id);
    }
  }

  protected void addLayer(String type) {
    if (type.equals("FILL_CUBE_RIGHT_LEFT")) {
      layers.add(new L_Fill(int(random(0, view.getCubeCount())), 1000, "TOP"));
    } else if (type.equals("FILL_CUBE_TOP_DOWN")) {
      layers.add(new L_Fill(int(random(0, view.getCubeCount())), 1000, "RIGHT"));
    } else if (type.equals("FILL_CUBE_LEFT_RIGHT")) {
      layers.add(new L_Fill(int(random(0, view.getCubeCount())), 1000, "BOTTOM"));
    } else if (type.equals("FILL_CUBE_DOWN_TOP")) {
      layers.add(new L_Fill(int(random(0, view.getCubeCount())), 1000, "LEFT"));
    } else if (type.equals("OUTLINE_CUBE_LEFT_RIGHT")) {
      layers.add(new L_Outline(int(random(0, view.getCubeCount())), 1000, 7));
    } else if (type.equals("OUTLINE_CUBE_RIGHT_LEFT")) {
      layers.add(new L_Outline(int(random(0, view.getCubeCount())), 1000, 1));
    } else if (type.equals("OUTLINE_CUBE_TOP_DOWN")) {
      layers.add(new L_Outline(int(random(0, view.getCubeCount())), 1000, 2));
    } else if (type.equals("OUTLINE_CUBE_DOWN_TOP")) {
      layers.add(new L_Outline(int(random(0, view.getCubeCount())), 1000, 3));
    }
  }

  protected void setColumnMapping(int c, float xPercent, float yPercent, float size) {
    int startCube = c*installation.getCubeCount(); 
    int endCube = startCube + installation.getCubeCount();
    for ( int i = startCube; i < endCube; i++) {
      view.cubes.get(i).setMapping(true);
      view.cubes.get(i).setMidXPercent(constrain(xPercent, 0, 100));
      view.cubes.get(i).setMidYPercent(constrain(yPercent, 0, 100));
      view.cubes.get(i).setMappingPercent(constrain(size, 0, 100));
    }
  }

  protected void setColumnMappingXPercent(int c, float xPercent) {
    int startCube = c*installation.getCubeCount(); 
    int endCube = startCube + installation.getCubeCount();
    for ( int i = startCube; i < endCube; i++) {
      view.cubes.get(i).setMapping(true);
      view.cubes.get(i).setMidXPercent(constrain(xPercent, 0, 100));
    }
  }
  protected void setColumnMappingYPercent(int c, float yPercent) {
    int startCube = c*installation.getCubeCount(); 
    int endCube = startCube + installation.getCubeCount();
    for ( int i = startCube; i < endCube; i++) {
      view.cubes.get(i).setMapping(true);
      view.cubes.get(i).setMidYPercent(constrain(yPercent, 0, 100));
    }
  }
  protected void setColumnMappingSize(int c, float size) {
    int startCube = c*installation.getCubeCount(); 
    int endCube = startCube + installation.getCubeCount();
    for ( int i = startCube; i < endCube; i++) {
      view.cubes.get(i).setMapping(true);
      view.cubes.get(i).setMappingPercent(constrain(size, 0, 100));
    }
  }
}