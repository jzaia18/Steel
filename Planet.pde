//discontinued

class Planet extends Ball {
  
  float dx, dy;
  float velocityLoss = .01;
  float g = .005;
  
  Planet() {
    super();
    dx = random(4)-2;
    dy = random(4)-2;
  }
  
  Planet(int Diameter) {
    super(Diameter);
    dx = random(4)-2;
    dy = random(4)-2;
  }
  
  Planet(int Mx, int My) {
    super(Mx, My);
    dx = random(4)-2;
    dy = random(4)-2;
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
/*
  void bounce(Ball B) {
    
  }
*/
  boolean collide(Ball B) {
    return dist(this.x, this.y, B.x, B.y) > 0 && !(B instanceof Explosion) && dist(this.x, this.y, B.x, B.y) <= minDist(B);
  }
  
  float minDist(Ball B) {
    return this.radius() + B.radius();
  }
  
  void frame() {
    move();
  }

  boolean frame(ArrayList<Ball> others) {
    display();
    for(int i = 0; i < others.size(); i++) {
      //Planet b = (Planet)others.get(i);
      float dist = dist(this.x,this.y,others.get(i).x,others.get(i).y);
      float minDist = this.radius() + others.get(i).radius();
      if(dist == 0) {
        /*float offset = (minDist - dist(this.x, this.y, b.x, b.y))/2;
        float X = b.x - this.x;
        float Y = b.y - this.y;
        float D = sqrt(X*X + Y*Y);
        this.x -= offset*X/D;
        this.y -= offset*Y/D;
        others.get(i).x += offset*X/D;
        others.get(i).y += offset*Y/D;*/
        continue;
      }
      if(dist <= minDist) {
        this.dx = -this.dx;
        this.dy = -this.dy;
        move();
        //print(dist + "\n" + minDist + "\n\n");
      }
      float mass = pow(others.get(i).radius(),2);
      
      int sx = (int)((this.x-others.get(i).x)/abs(this.x-others.get(i).x));
      int sy = (int)((this.y-others.get(i).y)/abs(this.y-others.get(i).y));
      this.dx -= sx*g*mass/dist;//gconstant*pow(this.radius(),2)/pow(dist(this.x,this.y,others.get(i).x,others.get(i).y),2); //acceleration + current, acceleration = gconstant*massother/radius^2
      this.dy -= sy*g*mass/dist;//gconstant*pow(this.radius(),2)/pow(dist(this.x,this.y,others.get(i).x,others.get(i).y),2);
      //print(this.dx + "\n\n");
      //print(this.dy + "\n\n");
    }
    frame();
    return true;
  }
}