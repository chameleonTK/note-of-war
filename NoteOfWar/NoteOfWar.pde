import com.phidget22.*;

Game g;
int widthW=1000, heightW = 500;


void setup() {
  size(1000, 500);
  g = new Game(widthW, heightW, this);
  
}

void draw() {
  g.run();
}

void mouseClicked() {
  g.handleEvent("click", mouseButton);
}
