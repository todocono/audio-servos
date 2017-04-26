import processing.serial.*;
import cc.arduino.*;
import ddf.minim.*;

Arduino arduino;
Minim minim;
AudioInput in;

color red;
color green;
color blue;
float RMS;

int servo1 = 9;


void setup() {

  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[2], 57600);

  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.OUTPUT);

  size(512, 400, P2D);
  red = color(255, 100, 100);
  blue = color(100, 100, 255);
  green = color(100, 255, 100);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16

  in = minim.getLineIn(Minim.STEREO, 512);
  background(0);
}
void draw() {

  background(0);
  strokeWeight(1);  // Normal

  // draw the waveforms
  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
    stroke(green);
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    stroke(blue);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
    RMS = abs(in.left.get(i)) + abs(in.right.get(i));
  }
  strokeWeight(10);  // Coarse
  stroke(red);
  line ( 0, 300, RMS*300, 300);
  int servoAngle = (int)map(RMS, 0, 1, 10, 170); 
  arduino.analogWrite(servo1, servoAngle);
  strokeWeight(1);  // Coarse
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  super.stop();
}