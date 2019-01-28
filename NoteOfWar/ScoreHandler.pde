import com.phidget22.*;

class ScoreHandler{
  
  private float sumScore = 200;
  private float increment = 10;
  private Player[] players;
  private GameState state;
  public Coin coin;
  ScoreHandler(int n, GameState s, Coin c) {
    this.players = new Player[2];
    this.players[0] = new Player(0, this);
    this.players[1] = new Player(1, this);
    this.state = s;
    this.coin = c;
    
    this.setupSensor(277875, 0, this.players[0]);
    this.setupSensor(277875, 1, this.players[0]);
    this.setupOutputLED(277875, 0, this.players[0]);
    this.setupSensor(277875, 3, this.players[0]);
    this.players[0].setupSensor(SensorType.VOICE, 0);
    this.players[0].setupSensor(SensorType.TEMP, 1);
    this.players[0].setupSensor(SensorType.OUTPUT, 0);
    this.players[0].setupSensor(SensorType.LIGHT, 3);
    
    
    this.setupSensor(277875, 6, this.players[1]);
    this.setupSensor(277875, 7, this.players[1]);
    this.setupOutputLED(277875, 5, this.players[1]);
    this.setupSensor(277875, 3, this.players[1]);
    
    this.players[1].setupSensor(SensorType.VOICE, 6);
    this.players[1].setupSensor(SensorType.TEMP, 7);
    this.players[1].setupSensor(SensorType.OUTPUT, 5);
    this.players[1].setupSensor(SensorType.LIGHT, 3);
    
  }
  
  private void setupOutputLED(int port, int channel, Player player) {
    try {
      DigitalOutput chRota = new DigitalOutput();
      chRota.setDeviceSerialNumber(port);
      chRota.setChannel(channel);
      chRota.open();
      player.setupOutputLED(chRota);
    } catch (PhidgetException e) {
      System.out.println(e);
    }
  }
  
  private void setupSensor(int port, int channel, Player player) {
    try {
      VoltageRatioInput chRota = new VoltageRatioInput();
      chRota.setDeviceSerialNumber(port);
      chRota.setChannel(channel);
      chRota.open();
      
      chRota.addVoltageRatioChangeListener(player);
    } catch (PhidgetException e) {
      System.out.println(e);
    }
  }
  
  public void changeStage(boolean b, int delay) {
    this.players[0].changeState(b, delay);
    this.players[1].changeState(b, delay);
  }
  
  public Player[] getPlayers() {
    return this.players;
  }
  
   public Player getLoser() {
    double sumScore = this.getSumScore();
    for(int i=0; i<this.players.length; i++) {
      double s = this.players[i].getScore();
      if ( 100.0*s/sumScore < 5) {
        return this.players[i];
      }
    }
    
    return null;
  }
  
  public boolean hasWiner() {
    double sumScore = this.getSumScore();
    for(int i=0; i<this.players.length; i++) {
      double s = this.players[i].getScore();
      if ( 100.0*s/sumScore < 5) {
        return true;
      }
    }
    
    return false;
  }
  
  public void addScoreToPlayer(int index, float increment) {
    this.sumScore += increment;
    this.players[index].addScore(increment);
  }
  
  public void addScoreToPlayer(int index) {
    
    if (this.state.getState() != GameState.RUNNING) {
      return;
    }
    
    if (index >= this.players.length) {
      return;
    }
    
    if (this.increment < this.sumScore*0.05) {
      this.increment *= 1.5;
    }
    
    this.addScoreToPlayer(index, this.increment);
  }
  
  private double getSumScore() {
    //double sumScore = 0;
    //for(int i=0; i<this.players.length; i++) {
    //    sumScore += this.players[i].getScore();
    //}
    
    return this.sumScore;
  }
  
}
