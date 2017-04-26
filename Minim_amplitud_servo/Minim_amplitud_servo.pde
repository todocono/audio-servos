/**
 * This sketch demonstrates how to monitor the currently active audio input 
 * of the computer using an AudioInput. What you will actually 
 * be monitoring depends on the current settings of the machine the sketch is running on. 
 * Typically, you will be monitoring the built-in microphone, but if running on a desktop
 * it's feasible that the user may have the actual audio output of the computer 
 * as the active audio input, or something else entirely.
 * <p>
 * Press 'm' to toggle monitoring on and off.
 * <p>
 * When you run your sketch as an applet you will need to sign it in order to get an input.
 * <p>
 * For more information about Minim and additional features, 
 * visit http://code.compartmental.net/minim/ 
 */

import ddf.minim.*;

Minim minim;
//AudioInput in;
AudioPlayer song;


void setup()
{
  size(512, 400, P3D);

  minim = new Minim(this);

  song = minim.loadFile("servo-test.mp3", 1024);
  song.setPan(1);
  song.loop();
  // use the getLineIn method of the Minim object to get an AudioInput
  // in = minim.getLineIn();
}

void draw()
{
  background(0);
  stroke(255);

  float energyR = 0;
  float energyL = 0;

  // draw the waveforms so we can see what we are monitoring
  for (int i = 0; i < song.bufferSize() - 1; i++)
  {
    line( i, 50 + song.left.get(i)*50, i+1, 50 + song.left.get(i+1)*50 );
    line( i, 150 + song.right.get(i)*50, i+1, 150 + song.right.get(i+1)*50 );
    energyL = energyL + abs(song.left.get(i));
    energyR = energyR + abs(song.right.get(i));
  }

  println ( "left " + energyL);
  println ( "right " + energyR);

  int angleL = (int)map(energyL, 0, 1000, 0, 180);
  int angleR = (int)map(energyR, 0, 1000, 0, 180);

  line( 0, 250, angleL, 250);
  text( angleL, 350, 250);
  line( 0, 350, angleR, 350);
  text( angleR, 350, 350);
  // String monitoringState = song.isMonitoring() ? "enabled" : "disabled";
  // text( "Input monitoring is currently " + monitoringState + ".", 5, 15 );
}
/*
void keyPressed()
 {
 if ( key == 'm' || key == 'M' )
 {
 if ( in.isMonitoring() )
 {
 in.disableMonitoring();
 } else
 {
 in.enableMonitoring();
 }
 }
 }
 */