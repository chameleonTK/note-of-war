import gifAnimation.*;

class Coin{
  private PApplet app;
  private Gif rcoin, bcoin;
  private int delay;
  private float posx, posy, type;
  
  private int team;
  Coin(PApplet app) {
    this.app = app;
    rcoin = new Gif(app, "rcoin.gif");
    rcoin.play();
    
    bcoin = new Gif(app, "bcoin.gif");
    bcoin.play();
  }
  
  public int getTeam() {
    return this.team;
  }
  
  public int getDelay() {
    return this.delay;
  }
  
  public void setDelay(int n) {
    this.delay = n;
  }
  
  public void draw() {
    if (delay > 0) {
      if (type > 0.5) {
        team = 0;
        image(bcoin, posx, posy, 50, 50);
      } else {
        team = 1;
        image(rcoin, posx, posy, 50, 50);
      }
      
      delay--;
    } else {
      team = -1;
      posx = random(50, width-50);
      posy = random(50, height-50);
      type = random(1);
    }
  }
  
}
