class Game{
  private int screenWidth, screenHeight;
  private GameState screenState;

  private IMenu message;
  private Avatar avatar;
  private PApplet app;
  private ScoreHandler score;
  private Coin coin;
  
  Game(int w, int h, PApplet app) {
    this.screenWidth = w;
    this.screenHeight = h;
    this.app = app;
    this.screenState = new GameState();
    this.screenState.setState(GameState.START);
    
    this.message = new StartMenu(this.screenWidth, this.screenHeight, this.screenState);
    this.avatar = new Avatar(this.screenWidth, this.screenHeight, this.app);
    this.coin = new Coin(app);
    
    this.score = new ScoreHandler(2, this.screenState, this.coin); 
  }
  
  int delayBlinking = 0;
  public void run() {
    this.drawStage();
    this.avatar.draw();
    this.coin.draw();
    
    if (screenState.getState() == GameState.START || screenState.getState() == GameState.COUNTDOWN) {
      this.message.draw();
    } else if (screenState.getState() == GameState.RUNNING) {
      
      //It will have 0.05% chance to change to use temperature sensor
      if (delayBlinking <= 0 && random(100) > 99.9) {
          //System.out.println("CHANGE");
          delayBlinking = 200;
          this.score.changeStage(true, delayBlinking);
      }
      
      if (this.coin.getDelay() <=0 && random(100) > 98) {
        this.coin.setDelay(50);
      }
      
      if (delayBlinking > 0) {
        delayBlinking--;
      }
      
      Player p = this.score.getLoser();
      if (p != null) {
        this.avatar.setLoser(p);
        this.end();
      }  
    } else if (screenState.getState() == GameState.ENDING) {
      this.message.draw();
    }
  }
  
  public void end() {
    this.message = new EndMenu(this.screenWidth, this.screenHeight, this.screenState);
    this.screenState.setState(GameState.ENDING);
  }
  
  public void handleEvent(String e, int mouseButton) {
    if (screenState.getState() == GameState.START) {
      ((StartMenu)this.message).countdown();
    } else if (screenState.getState() == GameState.RUNNING) {
      ///
    } else if (screenState.getState() == GameState.ENDING) {
      ((EndMenu)this.message).reset(this);
    }
  }
 
  public void reset() {
    this.screenState.setState(GameState.START);
    this.message = new StartMenu(this.screenWidth, this.screenHeight, this.screenState);
    this.avatar.reset();
    this.score = new ScoreHandler(2, this.screenState, this.coin); 
  }
  
  public void drawStage() {
    double sumScore = this.score.getSumScore();
    noStroke();
    rectMode(CORNER);
    float posX = 0;
    float posY = 0;
  
    Player[] players = this.score.getPlayers();
    for(int i=0; i < players.length; i++) {
      
      fill(players[i].getColor());
      
      float w = (float)Math.ceil(this.screenWidth*players[i].getScore()/sumScore);
      rect(posX, posY, w, (float)this.screenHeight);
      posX += w;
    }
   
  }
}
