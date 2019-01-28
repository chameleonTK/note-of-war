class EndMenu implements IMenu{
  private int initFontSize = 20;
  private float zoomSpeed = 2;
  private int screenWidth, screenHeight;
  
  private GameState state;
  EndMenu(int w, int h, GameState state) {
    this.screenWidth = w;
    this.screenHeight = h;
    this.state = state;
  }
  
  public void draw() {
    fill(0);
    textAlign(CENTER);
    textSize(this.initFontSize);
    if (state.getState()==GameState.ENDING) {
      text("WINER", this.screenWidth/2, this.screenHeight/2);
      initFontSize += zoomSpeed;
      if (initFontSize >= 100 || initFontSize <= 20) {
        zoomSpeed *= -1;
      }
    }
    
    waiting++;
  }
  
  int waiting = 0;
  public void reset(Game g) {
    ///Waiting a bit before it can be started again
    if (waiting >= 500) {
      g.reset();
      waiting = 0;
    }
  }
}
