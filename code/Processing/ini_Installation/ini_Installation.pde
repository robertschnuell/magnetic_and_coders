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

  // exportDataToJson();
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
  installation.setColumnPerc(0, 0, 50);
  installation.setColumnPerc(0, 1, 50);
  installation.setColumnPerc(0, 2, 50);
  installation.setColumnPerc(0, 3, 50);
  installation.setColumnPerc(1, 0, 50);
  installation.setColumnPerc(1, 1, 50);
  installation.setColumnPerc(1, 2, 50);
  installation.setColumnPerc(1, 3, 50);
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
      installation.setTarget(int(random(1, 8)), random(0, 100));
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
    set.addMLayerData("POSITION", 0, int(random(0, 8)), random(0, 100));
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
    set.updateRowPointer(3,"LEFT",velocity,"LEFT");
    //updateRowPointer(int row, String side, int val, String type)
  }
  if (pitch == 42) {
     set.updateRowPointer(3,"RIGHT",velocity,"LEFT");
  }
  if (pitch == 41) {
     set.updateRowPointer(3,"BOTH",velocity,"LEFT");
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