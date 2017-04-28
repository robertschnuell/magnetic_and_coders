import themidibus.*; 
import mqtt.*;

import java.util.UUID;

/*
 magnetic and coders - engine
 by 
 Jannik Bussmann
 Dirk Erdmann
 Robert Schnüll
 
 license: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 - https://creativecommons.org/licenses/by-nc-sa/4.0/
 
 */

/////////////////////INSTANCES /////////////////// 
MQTTClient client;
MidiBus testMidi; 

Installation installation;
View view;
Set set;
ControlView controlView;
/////////////////////INSTANCES END ///////////////////



void setup() {
  size(1080, 1920);
  //fullScreen(SPAN);
  println(width);
  println(height);

  //testMidi = new MidiBus(this, "LPD8", -1); 
  testMidi = new MidiBus(this, "Port A", -1); 


  //MQTT 
  client = new MQTTClient(this);
  client.connect("mqtt://localhost");

  //INI INSTALLATION
  float pos[][] = new float[2][2];
  pos[0][0] = 930;
  pos[0][1] = 750;
  pos[1][0] = width/4*3;
  pos[1][1] = 100;

  pos[0][0] = 300;
  pos[0][1] = 100;
  installation = new Installation(2, pos, 4, 6);

  view = new View(installation.getSquareCount());
  set  = new Set();


  controlView = new ControlView(100, 700, 400);

  staticDev();

  //exportDataToJson();
}



void draw() {
  background(0);
  installation.update();
  view.newData(installation.getAllCoordinates());
  view.update();
  set.update();

  controlView.update();
}

void staticDev() {
  installation.setColumnPerc(0, 0, 0);
  installation.setColumnPerc(0, 1, 0);
  installation.setColumnPerc(0, 2, 0);
  installation.setColumnPerc(0, 3, 0);
  installation.setColumnPerc(1, 0, 0);
  installation.setColumnPerc(1, 1, 0);
  installation.setColumnPerc(1, 2, 0);
  installation.setColumnPerc(1, 3, 0);
}


/////////////////////MQTT ///////////////////
void messageReceived(String topic, byte[] payload) { 
  if (topic.charAt(0) == 'a') {
    installation.parseMqttMsg(topic, payload);
  }
}
/////////////////////MQTT END ///////////////////




/////////////////////INPUT LISTENER ///////////////////

public void keyPressed()
{

  //

  if (key == CODED) {
    if (keyCode == UP) {
      //send up
      //installation.setTarget(int(random(1, 8)), random(0, 100));  be aware of devcode!!
      installation.checkKey(0);
      // right.checkKey(0);
    } else if (keyCode == DOWN) {
      //client.publish("a1/target", str(random(0, 100)));
      installation.checkKey(1);
      //send down
      // left.checkKey(1);
      // right.checkKey(1);
    } else if (keyCode == LEFT) {
      //client.publish("a2/target", str(random(0, 100)));
      installation.checkKey(2);
      //send left
      // left.checkKey(2);
      // right.checkKey(2);
    } else if (keyCode == RIGHT) {
      //client.publish("a3/target", str(random(0, 100)));
      installation.checkKey(3);
      //send right
      // left.checkKey(3);
      // right.checkKey(3);
    }
  }

  if (key == 'e') {
    // set.addMLayer("SINUS", 1, 4);
  }
  if (key == 'r') {
    // set.addMLayer("SINUS", 4, 8);
  }
  if (key == 'h') {
    //  set.addMLayer("HOME");
  }
  if (key == 'q') {
   // testExport();
   expJson();
  }
  if(key == 'a') {
    importJsonToData();
  }
  if (key == 'w') {
    for ( int i = 0; i < installation.getColumns(); i++) {
      installation.setTarget(i, 0);
      delay(15);
    }
  }
  if (key == 's') {
    for ( int i = 0; i < installation.getColumns(); i++) {
      installation.setTarget(i, 100);
      delay(15);
    }
  }


  installation.checkKey(key);
}


void mousePressed() {
  installation.checkMouse();
  controlView.checkMouse();
}




//MIDI

void controllerChange(int channel, int number, int value) {
  float tmpPerc = map(value, 0, 127, 0.1, 100);

  println(number);
  switch(number) {
  case 28:

    break;
  case 21:
    set.setColumnMappingXPercent(0, map(value, 0, 127, 0, 100));
    break;
  case 22:
    set.setColumnMappingYPercent(0, map(value, 0, 127, 0, 100));
    break;
  case 23:
    set.setColumnMappingSize(0, map(value, 0, 127, 0, 100));
    break;
  case 24:
    set.setMappingToMid(true, true, map(value, 0, 127, 0, 100));
    break;
  case 25:
    set.setAllMappingSize(map(value, 0, 127, 0, 100));
    if (value == 0) {
      set.setAllMapping(false);
    } else {
      set.setAllMapping(true);
    }
    break;
  case 26:
    set.setAllMappingMidX(map(value, 0, 127, 0, 100));
    break;
  case 27:
    set.setAllMappingMidY(map(value, 0, 127, 0, 100));
    break;

  default:
  }

  /*
  switch(number) {
   case 1:
   installation.setColumnPerc(0, 0, tmpPerc);
   break;
   case 2: 
   installation.setColumnPerc(0, 1, tmpPerc);
   break;
   case 3:
   installation.setColumnPerc(0, 2, tmpPerc);
   break;
   case 4: 
   installation.setColumnPerc(0, 3, tmpPerc);
   break;
   case 5:
   installation.setColumnPerc(1, 0, tmpPerc);
   break;
   case 6:
   installation.setColumnPerc(1, 1, tmpPerc);
   break;
   case 7: 
   installation.setColumnPerc(1, 2, tmpPerc);
   break;
   case 8:
   installation.setColumnPerc(1, 3, tmpPerc);
   break;
   default:
   }
   
   */
}

void noteOn(int channel, int pitch, int velocity) {

  println(pitch);

  /*
  if (pitch == 41) {
   set.addLayer("FILL_CUBE_RIGHT", velocity);
   } 
   if (pitch == 41) {
   // set.addMLayer("SINUS", 0, 8);
   }  
   
   if (pitch == 40) {
   set.addLayer("FILL_CUBE_RIGHT_LEFT", velocity);
   println("FILL_CUBE_RIGHT_LEFT");
   }
   if (pitch == 20) {
   set.addLayer("FILL_CUBE_TOP_DOWN", velocity);
   println("FILL_CUBE_TOP_DOWN");
   }
   if (pitch == 42) {
   set.addLayer("FILL_CUBE_LEFT_RIGHT", velocity);
   println("FILL_CUBE_LEFT_RIGHT");
   } 
   if (pitch == 43) {
   set.addLayer("FILL_CUBE_DOWN_TOP", velocity);
   println("FILL_CUBE_DOWN_TOP");
   } 
   if (pitch == 36) {
   set.addLayer("OUTLINE_CUBE_LEFT_RIGHT ", velocity);
   println("OUTLINE_CUBE_LEFT_RIGHT ");
   }
   if (pitch == 37) {
   set.addLayer("OUTLINE_CUBE_RIGHT_LEFT", velocity);
   println("OUTLINE_CUBE_RIGHT_LEFT ");
   }
   if (pitch == 38) {
   set.addLayer("OUTLINE_CUBE_TOP_DOWN", velocity);
   println("OUTLINE_CUBE_TOP_DOWN");
   }
   if (pitch == 39) {
   set.addLayer("OUTLINE_CUBE_DOWN_TOP ", velocity);
   println("OUTLINE_CUBE_DOWN_TOP");
   }
   if (pitch == 48) {
   set.addLayer("FILL_TO_MID", velocity);
   println("v" + velocity);
   }
   if (pitch == 49) {
   set.addLayer("FILL_TO_MID_RIGHT", velocity);
   println("v" + velocity);
   }
   if (pitch == 50) {
   set.addLayer("FILL_TO_MID_SIDES", velocity);
   println("v" + velocity);
   }
   if (pitch == 51) {
   set.addLayer("FILL_TO_MID_SIDES_RIGHT", velocity);
   println("v" + velocity);
   }
   */

  //  CHANNEL A 51-39      //
  if (pitch == 51) {
    set.addLayer("FILL_TO_MID", velocity);
  }
  if (pitch == 50) {
    set.addLayer("FILL_TO_MID_SIDES_RIGHT", velocity);
  }
  if (pitch == 49) {
    set.addLayer("FILL_TO_MID_RIGHT", velocity);
  }
  if (pitch == 48) {
    set.addLayer("FILL_TO_MID_SIDES", velocity);
  }

  if (pitch == 47) {
    set.addLayer("FILL_CUBE_TOP_DOWN", velocity);
  }
  if (pitch == 46) {
    set.addLayer("FILL_CUBE_TOP_DOWN_R", velocity);
  }
  if (pitch == 45) {
    set.addLayer("FILL_CUBE_DOWN_TOP_R", velocity);
  }
  if (pitch == 44) {
    set.addLayer("FILL_CUBE_DOWN_TOP", velocity);
  }

  if (pitch == 43) {
    ArrayList<Integer> rows = controlView.getSelectedRows(0);
    for ( int i = 0; i < rows.size(); i++) {
      set.updateRowPointer(rows.get(i), "LEFT", velocity, "LEFT");
    }
    //updateRowPointer(int row, String side, int val, String type)
  }
  if (pitch == 42) {

    ArrayList<Integer> rows = controlView.getSelectedRows(1);
    for ( int i = 0; i < rows.size(); i++) {
      set.updateRowPointer(rows.get(i), "RIGHT", velocity, "LEFT");
    }
  }
  if (pitch == 41) {
    ArrayList<Integer> rows = controlView.getSelectedRows(0);
    for ( int i = 0; i < rows.size(); i++) {
      set.updateRowPointer(rows.get(i), "LEFT", velocity, "LEFT");
    }
    rows = controlView.getSelectedRows(1);
    for ( int i = 0; i < rows.size(); i++) {
      set.updateRowPointer(rows.get(i), "RIGHT", velocity, "LEFT");
    }
  }
  if (pitch == 40) {
  }

  if (pitch == 39) {
  }
  if (pitch == 38) {
  }
  if (pitch == 37) {
  }
  if (pitch == 36) {
  }

  //  CHANNEL A END        //

  //  CHANNEL B 64-55      //

  //  CHANNEL B END        //

  //  CHANNEL C 80-71      //

  //  CHANNEL C END        //

  //  CHANNEL D 96-87      //

  //  CHANNEL D END        //
}


/////////////////////INPUT LISTENER END ///////////////////

/////////////////////SETTINGS IMPORT / EXPORT VIA JSON ///////////////////

void testExport() {
  float  [][][][][] tmp = installation.getStates();
  //sides][columns][cubes each column][states][stateCoords]
  // i       j            k              l       m

  String t = "";
  for ( int i = 0; i < tmp.length; i++) { 
    for (int j = 0; j < tmp[i].length; j++) {
      for (int k = 0; k < tmp[i][j].length; k++) {
        for ( int l = 0; l < tmp[i][j][k].length; l++) {
          for (int m = 0; m < tmp[i][j][k][l].length; m++) {

            t += tmp[i][j][k][l][m];

            t += ", ";
          }
        }
        t += "\n";
      }
    }
  }
  println(t);
}

void expJson() {

  float  [][][][][] tmp = installation.getStates();
  //sides][columns][cubes each column][states][stateCoords]
  // i       j            k              l       m

  String t = "";
  JSONArray jsonExport = new JSONArray();

  for ( int i = 0; i < tmp.length; i++) { 
    JSONArray columns = new JSONArray();
    for (int j = 0; j < tmp[i].length; j++) {
      JSONArray cubes = new JSONArray();
      for (int k = 0; k < tmp[i][j].length; k++) {
        JSONArray states = new JSONArray();
        for ( int l = 0; l < tmp[i][j][k].length; l++) {

          JSONObject squareState = new JSONObject();


          squareState.setInt("x0", int(tmp[i][j][k][l][0]));
          squareState.setInt("x1", int(tmp[i][j][k][l][1]));
          squareState.setInt("x2", int(tmp[i][j][k][l][2]));
          squareState.setInt("x3", int(tmp[i][j][k][l][3]));

          squareState.setInt("y0", int(tmp[i][j][k][l][4]));
          squareState.setInt("y1", int(tmp[i][j][k][l][5]));
          squareState.setInt("y2", int(tmp[i][j][k][l][6]));
          squareState.setInt("y3", int(tmp[i][j][k][l][7]));

          states.setJSONObject(l, squareState);



          //t += tmp[i][j][k][l][m];
         // t += ", ";
        }
        cubes.setJSONArray(k, states);
        t += "\n";
      }
      columns.setJSONArray(j, cubes);
    }
    jsonExport.setJSONArray(i, columns);
  }
   println(jsonExport);
   saveJSONArray(jsonExport, "data/mapping.json");
}

void importJsonToData() {
    JSONArray jsonImport;

  jsonImport = loadJSONArray("mapping.json");
  //aka sides
  for ( int i = 0; i < jsonImport.size(); i++) {
    JSONArray columns = jsonImport.getJSONArray(i); 
    for( int j = 0; j < columns.size();j++) {
     JSONArray cubes = columns.getJSONArray(j);
     for(int k = 0; k < columns.size();k++) {
      JSONArray states = cubes.getJSONArray(k);
      for ( int l = 0; l < states.size();l++) {
        //states here
        //jsonToData(int side, int column, int cube, int state, int p, int x, int y)
        
        JSONObject state = states.getJSONObject(l);
        int x0 = state.getInt("x0");
        int x1 = state.getInt("x1");
        int x2 = state.getInt("x2");
        int x3 = state.getInt("x3");
        
        int y0 = state.getInt("y0");
        int y1 = state.getInt("y1");
        int y2 = state.getInt("y2");
        int y3 = state.getInt("y3");
        
   
        installation.jsonToData(i,j,k,l,0,x0,y0);
        installation.jsonToData(i,j,k,l,1,x1,y1);
        installation.jsonToData(i,j,k,l,2,x2,y2);
        installation.jsonToData(i,j,k,l,3,x3,y3);
      }
     }
    }
  
  }

}

/*

void importDataToJson() {
  JSONArray jsonImport;

  jsonImport = loadJSONArray("settings.json");


  if (jsonImport.size() == motors.size() ) {
    for ( int i = 0; i < motors.size(); i++) {
      JSONObject motor = jsonImport.getJSONObject(i);

      if (motor.getInt("id") == i) {
        motors.get(i).setMin(motor.getInt("min"));
        motors.get(i).setMax(motor.getInt("max"));
        motors.get(i).setCurrentPos(motor.getInt("current"));
      }
    }
  }
}

*/

void exportDataToJson() {
  JSONArray jsonExport = new JSONArray();


  for ( int k = 0; k < 10; k++) {
    JSONArray cube = new JSONArray();


    for ( int i = 0; i < 2; i++) {
      JSONArray squareStates = new JSONArray();



      for ( int j = 0; j < 4; j++) {
        JSONObject squareState = new JSONObject();

        squareState.setFloat("x"+int(j+1), 10);
        squareState.setFloat("y"+int(j+1), 11);

        squareStates.setJSONObject(j, squareState);
      }


      cube.setJSONArray(i, squareStates);
    }
    jsonExport.setJSONArray(k, cube);
  }

  println(jsonExport);
  //saveJSONArray(jsonExport, "data/settings.json");
}

/////////////////////END SETTINGS IMPORT / EXPORT VIA JSON ///////////////////