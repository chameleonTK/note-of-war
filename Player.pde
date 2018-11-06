import com.phidget22.*;

class Player implements VoltageRatioInputVoltageRatioChangeListener{
  private color team;
  private double score;
  final public color RED = color(254, 84, 110);
  final public color BLUE = color(90, 171, 253);
  
  private int currentSensor = SensorType.ALL;
  private int[] sensors;
  private DigitalOutput led;
  
  private int index;
  float[] prevValue;
  private ScoreHandler scoreHandler;
  
  
  Player(int n, ScoreHandler s) {
    color c;
    if (n==1) { 
      c = RED;
    } else { 
      c = BLUE;
    }
    
    this.index = n;
    this.prevValue = new float[8];
    this.sensors = new int[8];
    this.scoreHandler = s;
    this.team = c;
    this.score = 100;
  }
  
  public int getIndex() {
    return this.index;
  }
  
  public void setupSensor(int type, int port) {
    this.sensors[type] = port;
  }
  
  public void setupOutputLED(DigitalOutput chRota) {
    this.led = chRota;
  }
  
  int blinkCountdown=0;
  public color getColor() {
    if (blinkCountdown > 0) {
      blinkCountdown--;
    } else {
      this.changeState(false, 0);
    }
    
    if (blinkCountdown%2==0) {
      return this.team;
    } else {
      return color(255, 255, 255);
    }
  }
  
  public double getScore() {
    return this.score;
  }
  
  public double setScore(double d) {
    this.score = d;
    return this.score;
  }
  
  public double addScore(double d) {
    this.score += d;
    return this.score;
  }
  
  public void changeState(boolean blinking, int blinkCountdown) {
    if (blinking) {
      this.currentSensor = SensorType.TEMP;
      this.blinkCountdown = blinkCountdown;
    } else {
      this.currentSensor = SensorType.ALL;
      this.blinkCountdown = 0;
    }
  }
  
  public boolean allowSensor(int sensorType) {
    if (this.currentSensor == SensorType.ALL ||sensorType == this.currentSensor) {
      return true;
    }
    
    return false;
  }
  
  public int delayLED = 5;
  public void onVoltageRatioChange(VoltageRatioInputVoltageRatioChangeEvent rce) {
    try {
      float currValue = (float)rce.getSource().getSensorValue();
      if (this.allowSensor(SensorType.VOICE) && (rce.getSource().getChannel()==this.sensors[SensorType.VOICE])) {
        //Pulse detection
        if ((currValue-prevValue[rce.getSource().getChannel()]) > 0.1) {
              System.out.println("SCORE VOICE "+this.index); 
              this.delayLED = 5;
              this.scoreHandler.addScoreToPlayer(this.index);
        }
      }
      
      if (rce.getSource().getChannel()==this.sensors[SensorType.LIGHT]) {
        //Pulse detection
        if ((prevValue[rce.getSource().getChannel()] - currValue) > 0.02) {

          //Just push light button; team who have its coin in the screen get the score. no matter who push the button
          if (this.scoreHandler.coin.getTeam() != -1) {
            System.out.println("SCORE LIGHT"+this.scoreHandler.coin.getTeam());  
            this.scoreHandler.addScoreToPlayer(this.scoreHandler.coin.getTeam());
            this.scoreHandler.getPlayers()[this.scoreHandler.coin.getTeam()].delayLED = 5;
            
          }
          
        }
      }
      
      if (this.allowSensor(SensorType.TEMP) && (rce.getSource().getChannel()==this.sensors[SensorType.TEMP])) {
        //Pulse detection
        
          System.out.println(currValue+" SCORE TEMP "+this.index); 
        if ( currValue > 0.385) {
          System.out.println("SCORE TEMP "+this.index); 
          this.delayLED = 1;
          this.scoreHandler.addScoreToPlayer(this.index, 1);
        }  
      }
      
      
        prevValue[rce.getSource().getChannel()] = (float)rce.getSource().getSensorValue();
        if (this.delayLED > 0) {
          this.led.setState(true);
          this.delayLED--;
        } else {
          this.led.setState(false);
        }
    } catch (PhidgetException e) {
      System.out.println(e.toString());
    }
  }
  
}
