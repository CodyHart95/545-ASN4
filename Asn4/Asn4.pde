import processing.video.*;
String vidname = "Ready-Player-One.mp4";
Movie m;
float playSpeed = 1.0;
boolean paused = false, reverse = true;

void setup(){
  size(640,300);
  surface.setResizable(true);
  m = new Movie(this, vidname);
  frameRate(30); 
  textSize(20);
  m.play();
}

void draw(){
  background(0);
  image(m,0,0);
  fill(255);
  text(str(playSpeed),width - 50, height - 10);
}
void movieEvent(Movie m){
  m.read();
}
void mouseWheel(MouseEvent event){
  float count = event.getCount();
 if (playSpeed >= 0.1){
  if(count == -1.0 && playSpeed <= 2.0 && playSpeed >= 0.1){
    playSpeed += 0.1;
    m.speed(playSpeed);
  }
  else if (count == 1.0 && playSpeed >= 0.1 && playSpeed <= 2.0){
    playSpeed -= 0.1;
    m.speed(playSpeed);
  }
 }
 else{
    if(count == -1.0 && playSpeed <= -0.1 && playSpeed >= -2.0){
    playSpeed -= 0.1;
    m.speed(playSpeed);
  }
  else if (count == 1.0 && playSpeed >= -2.0 && playSpeed <= -0.1){
    playSpeed += 0.1;
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