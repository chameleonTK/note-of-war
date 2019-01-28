class StartMenu implements IMenu{
  private int initFontSize = 20;
  private float zoomSpeed = 2;
  private int screenWidth, screenHeight;
  
  private GameState state;
  StartMenu(int w, int h, GameState state) {
    this.screenWidth = w;
    this.screenHeight = h;
    this.state = state;
  }
  
  String s = "1";
  int count = 1;
  public void draw() {
    fill(0);
    textAlign(CENTER);
    textSize(this.initFontSize);
    if (state.getState()==GameState.START) {
      text("START", this.screenWidth/2, this.screenHeight/2);
      initFontSize += zoomSpeed;
      if (initFontSize >= 100 || initFontSize <= 20) {
        zoomSpeed *= -1;
      }
    } else if (state.getState()==GameState.COUNTDOWN){
      text(s, this.screenWidth/2, this.screenHeight/2);
      
      if (initFontSize >= 100) {
        count++;
        s = count+"";
        if (count == 4) {
          s = "GO!";
        }
        
        if(count>4) {
          this.state.setState(GameState.RUNNING);
        }
        this.initFontSize = 20;
      }
      
      this.initFontSize += zoomSpeed;
    }
    
  }
  
  
  public void countdown() {
    if (this.state.getState()!=GameState.START) {
      return;
    }
    
    this.state.setState(GameState.COUNTDOWN);
    this.initFontSize = 20;
    this.zoomSpeed = 1;
    this.s = "1";
    this.count = 1;
  }
}
