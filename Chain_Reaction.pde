ArrayList<Ball> balls;

void setup(){
  size(1024,720);
  frameRate(40);
  noStroke();
  balls = new ArrayList<Ball>();
  for (int i = 0; i < (int)random(20)+20; i++) {
    balls.add(new Bouncer((int)random(25) + 25));    
  }
}

void draw() {
  background(0);
  /*
  ArrayList<Ball> explosions = new ArrayList<Ball>();
  ArrayList<Ball> regulars = new ArrayList<Ball>();
  for(Ball b : balls) {
    if(b.state > 0) { explosions.add(b); }
    else { regulars.add(b); }
  }*/
  for(int i = 0; i < balls.size(); i++) {
    balls.get(i).frame(balls);
  }
}


void mousePressed() {
  balls.add(new Explosion(mouseX, mouseY));
}
/*
void mouseDragged() {
  balls.add(new Ball((int)random(20) + 20));
}
*/