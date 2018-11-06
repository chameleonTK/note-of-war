import gifAnimation.*;

class Avatar{
  private int screenWidth, screenHeight;
  
  Gif player, looser, rope;
  private PApplet app;
  private int loserIndex = -1;
  Avatar(int w, int h, PApplet app) {
    this.screenWidth = w;
    this.screenHeight = h;
    this.app = app;
    player = new Gif(app, "1.gif");
    player.play();
    
    looser = new Gif(app, "2.gif");
    looser.play();
     
    rope = new Gif(app, "rope.gif");
    rope.play();
  }
  
  public void draw() {
    
    for(int i=0; i<7; i++) {
      image(rope, rope.width*i, this.screenHeight - rope.height + player.height/2);
    }
    //Player1
    if (loserIndex==0) {
      image(looser, 0, this.screenHeight - looser.height - 10);
    } else {
      image(player, 0, this.screenHeight - player.height - 10);
    }
    
    
    //Player2
    pushMatrix();
    if (loserIndex==1) {
      translate(looser.width,0);
      scale(-1,1);
      image(looser, -1*(this.screenWidth-player.width), this.screenHeight - looser.height - 10);
    } else {
      translate(player.width,0);
      scale(-1,1); // You had it right!
      image(player, -1*(this.screenWidth-player.width), this.screenHeight - player.height - 10);
    }
    popMatrix();
  }
  
  public void reset() {
    this.loserIndex = -1;
  }
  
  public void setLoser(Player p) {
    this.loserIndex = p.getIndex();
  }
}
