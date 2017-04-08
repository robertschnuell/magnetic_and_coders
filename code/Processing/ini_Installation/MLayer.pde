class MLayer {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */


  private float currentSpeed;
  private float maxSpeed;
  private String id;
  protected ArrayList<Integer> usedColumns;

  protected MLayer(ArrayList usedColumns) {
    this.usedColumns = usedColumns;

    this.id = UUID.randomUUID().toString();
  }

  protected MLayer(ArrayList usedColumns, float speed) {
    this.usedColumns = usedColumns;
    this.currentSpeed = speed;

    this.id = UUID.randomUUID().toString();
  }


  protected boolean update() {
    if (usedColumns.size() == 0) {
      return true;
    } else {
      return false;
    }
  }
  protected boolean update(ArrayList tmp) {

    this.usedColumns = tmp;

printStatus();
   // if (usedColumns.size() == 0) {

   //   return true;
  //  } else {
      return false;
 //   }
  }

  protected void selfdestuction() {
    set.mLayers.remove(this);
  }

  protected String getId() {
    return this.id;
  }

  /*
  protected void setActive(int c, boolean a) {
   for (int i = 0; i < usedColumns.length; i++) {
   if (usedColumns[i] == c) {
   this.active[i] = a;
   }
   }
   }
   */

  protected ArrayList getUsedColumns() {
    return this.usedColumns;
  }


  protected int getUsedColumnsCount() {
    return usedColumns.size();
  }
  
  private void  printStatus() {
    for( int i = 0; i< usedColumns.size();i++) {
      print(i+ ": " +usedColumns.get(i) + "\t");
    }
    println();
  }
  
  
}