/* This program plays the selected video and outputs the subtitles from the selected subtitle file.
   'p' pauses and plays the video.
   scrolling the mouse wheel changes the speed of playback
   'r' reverses playback
   
   Errors
   The playback speed will go outside the bounds by approxametly .1. I beleive this is a rounding error
   in the nf function.
 */

import processing.video.*;
String vidname = "Ready-Player-One.mp4", srtName = "Ready-Player-One-Trailer-HD-English-French-Subtitles.srt";
Movie m;
SubtitlePlayer sp;
float playSpeed = 1.0;
boolean paused = false, reverse = true;

void setup(){
  size(640,300);
  surface.setResizable(true);
  m = new Movie(this, vidname);
  sp = new SubtitlePlayer(srtName);
  frameRate(30); 
  textSize(20);
  m.play();
}

void draw(){
  background(0);
  float curTime = m.time() * 1000; //current position of the video in milliseconds
  String curSub = sp.getCurrentSubtitle(curTime, playSpeed < 0);//get the subtitle for the current time
  image(m,0,0);
  //set up for speed label
  fill(255);
  textAlign(RIGHT);
  text(nf(playSpeed,1,2),width, height - 5);
  textAlign(LEFT);
  text(curSub,5,height-5);
  
  
}
void movieEvent(Movie m){
  m.read();
}

void mouseWheel(MouseEvent event){
  float count = event.getCount();
  //check to see if we're playing forwards
 if (playSpeed > 0.0){
  if(count == -1.0 && playSpeed < 2.0 && playSpeed > 0.0){
    playSpeed += 0.01;
    m.speed(playSpeed);
  }
  else if (count == 1.0 && playSpeed > 0.1 && playSpeed < 2.1){
    playSpeed -= 0.01;
    m.speed(playSpeed);
  }
 }
 //check to see if we're playing backwards
 else if (playSpeed < 0.0){
    if(count == -1.0 && playSpeed < 0.0 && playSpeed > -2.0){
    playSpeed -= 0.01;
    m.speed(playSpeed);
  }
  else if (count == 1.0 && playSpeed > -2.1 && playSpeed < -0.1){
    playSpeed += 0.01;
    m.speed(playSpeed);
  }
 }
  
}
void keyReleased(){
  if (key == 'p'){
    if (paused){
      paused = false;
      m.play();
    }
    else{
      paused = true;
      m.pause();
    }
  }
  else if (key == 'r'){
    playSpeed = playSpeed * -1.0;
    m.speed(playSpeed);
  }
}