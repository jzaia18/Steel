ArrayList<Ball> balls;

void setup(){
  size(720,720);
  frameRate(30);
  noStroke();
  balls = new ArrayList<Ball>(20);
  for (int i = 0; i < 20; i++) {
    balls.add(new Ball((int)random(20) + 20));    
  }
}

void draw() {
  background(0);
  ArrayList<Ball> explosions = new ArrayList<Ball>();
  for(Ball b : balls) {
    if(b.state > 0) { explosions.add(b); }
  }
  for(int i = 0; i < balls.size(); i++) {
   balls.get(i).frame(explosions);
  }
}

void mousePressed() {
  balls.add(new Ball(mouseX, mouseY));
}
/*
void mouseDragged() {
  balls.add(new Ball((int)random(20) + 20));
}
*/