class MLayer {
  /*
 magnetic and coders - engine
   by 
   Jannik Bussmann
   Dirk Erdmann
   Robert Schnüll
   
   @author Robert Schnüll <@robertschnuell>
   */

  private int[] usedColumns;
  private boolean active;

  protected MLayer(int[] usedColumns) {
    this.usedColumns = usedColumns;
    this.active = true;
  }


  protected boolean update() {
    if (!active) {
      return true;
    } else {
      return false;
    }
  }

  protected void selfdestuction() {
    set.mLayers.remove(this);
  }

  protected int[] getUsedColumns() {
    return this.usedColumns;
  }

  protected Integer getUsedColumnId(int p) {
    if ( p < usedColumns.length ) {
      return usedColumns[p];
    } else {
      return null;
    }
  }
  protected int getUsedColumnsCount() {
    return usedColumns.length;
  }
}