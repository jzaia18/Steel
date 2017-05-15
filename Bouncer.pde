class Bouncer extends Ball {
  
  float dx, dy;
  
  Bouncer() {
    super();
    dx = random(10)-5;
    dy = random(10)-5;
  }
  
  Bouncer(int Diameter) {
    super(Diameter);
    dx = random(10)-5;
    dy = random(10)-5;
  }
  
  Bouncer(int Mx, int My) {
    super(Mx, My);
    dx = random(10)-5;
    dy = random(10)-5;
  }
/*
  private void bouncer() {
    dx = random(10)-5;
    dy = random(10)-5;
    radius = diameter/2;
  }
*/
  void bounce() {
    float r = radius();
    if(x <= r) { x = r; dx = -dx; }
    else if(x >= width - r) { x = width - r; dx = -dx; }
    if(y <= r) { y = r; dy = -dy; }
    else if(y >= height - r) { y = height - r; dy = -dy; }
  }

  void move() {
    x += dx;
    y += dy;
    bounce();
  }
  
  void bounce(Ball B) {
    
  }
  
  boolean collide(Ball B) {
    return dist(this.x, this.y, B.x, B.y) > 0 && !(B instanceof Explosion) && dist(this.x, this.y, B.x, B.y) <= minDist(B);
  }
  
  float minDist(Ball B) {
    return this.radius() + B.radius();
  }
  
  void frame() {
    display();
    move();
  }
  
  boolean frame(ArrayList<Ball> others) {
    for(int i = 0; i < others.size(); i++) {
      if(collide(others.get(i))) {
        Bouncer b = (Bouncer)others.get(i);
        //correct offset (clump correction)
        float offset = minDist(b) - dist(this.x, this.y, b.x, b.y);
        float X = (b.x - this.x)/abs(b.x - this.x);
        float Y = (b.y - this.y)/abs(b.y - this.y);
        this.x -= X*offset/3;
        this.y -= Y*offset/3;
        others.get(i).x += X*offset/3;
        others.get(i).y += Y*offset/3;
        //change velocities
        float tx = this.dx;
        float ty = this.dy;
        this.dx = pow(b.radius()/this.radius(),2)*b.dx;
        this.dy = pow(b.radius()/this.radius(),2)*b.dy;
        ((Bouncer)others.get(i)).dx = pow(this.radius()/b.radius(),2)*tx;
        ((Bouncer)others.get(i)).dy = pow(this.radius()/b.radius(),2)*ty;
        
      }
    }
    frame();
    return true;
  }
}