class GameState {
  final static int
  START      = 0, 
  RUNNING    = 1, 
  ENDING     = 2,
  
  COUNTDOWN   = 3;

  int state;
  GameState() {
    this.state = START;
  }
  
  public int getState() {
    return this.state;
  }
  
  public int setState(int n) {
    this.state = n;
    return this.state;
  }
}
