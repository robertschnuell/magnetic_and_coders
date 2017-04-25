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

  public MovingColumn mColumns[];


  private int[][] rowPointer; 

  protected Set() {
    layers = new ArrayList<Layer>();



    rowPointer = new int[installation.getCubeCount()][installation.getSideCount()];

    mColumns = new MovingColumn[installation.getColumns()];
    for (int i = 0; i < mColumns.length; i++) {
      mColumns[i] = new MovingColumn(i);
    }
  }

  protected void update() {


    for ( int i = 0; i< layers.size(); i++) {
      if (layers.get(i).update()) {
        // layers.add(new L_FillUp(int(random(0, view.getCubeCount())), int(random(100,1000))));
      }
    }

    for ( int i= 0; i <mColumns.length; i++) {
      mColumns[i].setTarget(random(0, 100));
      mColumns[i].sendSpeed();
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







  protected void addLayer(String type) {
    if (type.equals("FILL_CUBE_RIGHT_LEFT")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), 1000, "TOP", false));
    } else if (type.equals("FILL_CUBE_TOP_DOWN")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), 1000, "RIGHT", false));
    } else if (type.equals("FILL_CUBE_LEFT_RIGHT")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), 1000, "BOTTOM", false));
    } else if (type.equals("FILL_CUBE_DOWN_TOP")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), 1000, "LEFT", false));
    } else if (type.equals("OUTLINE_CUBE_LEFT_RIGHT")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), 1000, 7));
    } else if (type.equals("OUTLINE_CUBE_RIGHT_LEFT")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), 1000, 1));
    } else if (type.equals("OUTLINE_CUBE_TOP_DOWN")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), 1000, 2));
    } else if (type.equals("OUTLINE_CUBE_DOWN_TOP")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), 1000, 3));
    } else if ( type.equals("FILL_TO_MID")) {
      layers.add(new L_FillToMid(type, false, 5000, "LEFT"));
    }
  }
  protected void addLayer(String type, int val) {
    if (type.equals("FILL_CUBE_RIGHT_LEFT")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "TOP", false));
    } else if (type.equals("FILL_CUBE_LEFT_RIGHT")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "BOTTOM", false));
    } else if (type.equals("FILL_CUBE_TOP_DOWN")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "RIGHT", false));
    } else if (type.equals("FILL_CUBE_DOWN_TOP")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "LEFT", false));
    } else if (type.equals("FILL_CUBE_RIGHT_LEFT_R")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "TOP", true));
    } else if (type.equals("FILL_CUBE_LEFT_RIGHT_R")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "BOTTOM", true));
    } else if (type.equals("FILL_CUBE_TOP_DOWN_R")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "RIGHT", true));
    } else if (type.equals("FILL_CUBE_DOWN_TOP_R")) {
      layers.add(new L_Fill(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), "LEFT", true));
    } else if ( type.equals("FILL_TO_MID")) {
      layers.add(new L_FillToMid(type, false, int(map(val, 0, 127, 3000, 100)), "LEFT"));
    } else if ( type.equals("FILL_TO_MID_RIGHT")) {
      layers.add(new L_FillToMid(type, false, int(map(val, 0, 127, 3000, 100)), "RIGHT"));
    } else if ( type.equals("FILL_TO_MID_SIDES")) {
      layers.add(new L_FillToMid(type, true, int(map(val, 0, 127, 3000, 100)), "LEFT"));
    } else if ( type.equals("FILL_TO_MID_SIDES_RIGHT")) {
      layers.add(new L_FillToMid(type, true, int(map(val, 0, 127, 3000, 100)), "RIGHT"));
    } else if (type.equals("OUTLINE_CUBE_LEFT_RIGHT")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), 7));
    } else if (type.equals("OUTLINE_CUBE_RIGHT_LEFT")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), 1));
    } else if (type.equals("OUTLINE_CUBE_TOP_DOWN")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), 2));
    } else if (type.equals("OUTLINE_CUBE_DOWN_TOP")) {
      layers.add(new L_Outline(type, int(random(0, view.getCubeCount())), int(map(val, 0, 127, 2000, 100)), 3));
    }
  }





  /////////////////////COLUMN MAPPING -CORE ///////////////////

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
  protected void setAllMappingSize(float size) {
    for ( int i = 0; i < view.getCubeCount(); i++) {
      view.cubes.get(i).setMappingPercent(constrain(size, 0, 100));
    }
  }
  protected void setAllMappingMidX(float p) {
    for ( int i = 0; i < view.getCubeCount(); i++) {
      view.cubes.get(i).setMidXPercent(constrain(p, 0, 100));
    }
  }
  protected void setAllMappingMidY(float p) {
    for ( int i = 0; i < view.getCubeCount(); i++) {
      view.cubes.get(i).setMidYPercent(constrain(p, 0, 100));
    }
  }
  protected void setAllMapping(boolean b) {
    for ( int i = 0; i < view.getCubeCount(); i++) {
      view.cubes.get(i).setMapping(true);
    }
  }


  /////////////////////ROW FILL FUNCTIONS ///////////////////


  protected void updateRowPointer(int row, String side, int val, String type) {

    if (side.equals("LEFT")) {
      layers.add(new L_Fill("ROW "+ type, installation.getCubeCount()*rowPointer[row][0]+row, int(map(val, 0, 127, 2000, 100)), type, false));

      if (rowPointer[row][0] < installation.getColumnsPerSideCount()-1 ) {
        rowPointer[row][0]++;
      } else {
        rowPointer[row][0] = 0;
      }
    } else if (side.equals("RIGHT")) {
      layers.add(new L_Fill("ROW "+ type, installation.getCubeCount()*rowPointer[row][1]+row+installation.getColumnsPerSideCount()*installation.getCubeCount(), int(map(val, 0, 127, 2000, 100)), type, false));

      if (rowPointer[row][1] > 0 ) {
        rowPointer[row][1]--;
      } else {
        rowPointer[row][1] = installation.getColumnsPerSideCount()-1;
      }
    } else if (side.equals("BOTH")) {
      layers.add(new L_Fill("ROW "+ type, installation.getCubeCount()*rowPointer[row][0]+row, int(map(val, 0, 127, 2000, 100)), type, false));
      if (rowPointer[row][0] < installation.getColumnsPerSideCount()-1 ) {
        rowPointer[row][0]++;
      } else {
        rowPointer[row][0] = 0;
      }



      String tmpType = "";
      if (type.equals("LEFT")) {
        tmpType = "RIGHT";
      } else if (type.equals("RIGHT")) {
        tmpType = "LEFT";
      } else if (type.equals("TOP")) {
        tmpType = "BOTTOM";
      } else if (type.equals("BOTTOM")) {
        tmpType = "TOP";
      }


      layers.add(new L_Fill("ROW "+ tmpType, installation.getCubeCount()*rowPointer[row][1]+row+installation.getColumnsPerSideCount()*installation.getCubeCount(), int(map(val, 0, 127, 2000, 100)), tmpType, false));
      if (rowPointer[row][1] > 0 ) {
        rowPointer[row][1]--;
      } else {
        rowPointer[row][1] = installation.getColumnsPerSideCount()-1;
      }
    }
  }
  /////////////////////ROW FILL FUNCTIONS ///////////////////


  /////////////////////COLUMN MAPPING -Sequences ///////////////////

  protected void setMappingToMid(boolean side1, boolean side2, float xPercent) {


    float colPercentStep = xPercent/(installation.getColumnsPerSideCount()+1);
    float colXPercent = xPercent;
    if (side1) {


      for ( int i = installation.getColumnsPerSideCount()-1; i >= 0; i--) {

        for (int j = i*installation.getCubeCount(); j < i*installation.getCubeCount() +installation.getCubeCount(); j++) {
          view.cubes.get(j).setMapping(true);
          view.cubes.get(j).setMidXPercent(constrain(100-colXPercent, 0, 100));
        }
        colXPercent -= colPercentStep;
      }
    }
    if (side2) {

      colPercentStep = xPercent/(installation.getColumnsPerSideCount()+1);
      colXPercent = xPercent;
      for ( int i = installation.getColumnsPerSideCount(); i < installation.getColumnsPerSideCount()*2; i++) {
        for (int j = i*installation.getCubeCount(); j < i*installation.getCubeCount() +installation.getCubeCount(); j++) {
          view.cubes.get(j).setMapping(true);
          view.cubes.get(j).setMidXPercent(constrain(colXPercent, 0, 100));
        }
        colXPercent -= colPercentStep;
      }
    }
  }


  /////////////////////COLUMN MAPPING END ///////////////////
}