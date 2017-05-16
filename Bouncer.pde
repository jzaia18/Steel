class Bouncer extends Ball {
  
  float dx, dy;
  float velocityLoss = .005;
  float g = .01;
  
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
      
      if(collide(others.get(i))) {
        Bouncer b = (Bouncer)others.get(i);
        
        //running this too much heated a mac air enough for the fan noise to be audible
        
        //offset
        //repositions the balls so they aren't overlapping
        //works mostly, sometimes balls seem to bounce before actually hitting one another. hmmm.
        float offset = (minDist(b) - dist(this.x, this.y, b.x, b.y))/2;
        float X = b.x - this.x;
        float Y = b.y - this.y;
        float D = sqrt(X*X + Y*Y);
        this.x -= offset*X/D;
        this.y -= offset*Y/D;
        others.get(i).x += offset*X/D;
        others.get(i).y += offset*Y/D;
        
        //change velocities
        //funny physics - skips trig & accurate momentum conservation
        //1% decrease in velocity upon collision (eventually the entire system will stop)
        float tx = this.dx;
        float ty = this.dy;
        //float mt = pow(this.radius(),2);
        //float mb = pow(b.radius(),2);
        this.dx = (1-velocityLoss)*pow(b.radius()/this.radius(),2)*b.dx; //(tx*(mt-mb) + 2*mb*b.dx)/(mt+mb);
        this.dy = (1-velocityLoss)*pow(b.radius()/this.radius(),2)*b.dy; //(ty*(mt-mb) + 2*mb*b.dy)/(mt+mb);
        ((Bouncer)others.get(i)).dx = (1-velocityLoss)*pow(this.radius()/b.radius(),2)*tx; //(b.dx*(mb-mt) + 2*mb*tx)/(mt+mb);
        ((Bouncer)others.get(i)).dy = (1-velocityLoss)*pow(this.radius()/b.radius(),2)*ty; //(b.dy*(mb-mt) + 2*mb*ty)/(mt+mb);
        
      }

      /*else {
        float dist = dist(this.x,this.y,others.get(i).x,others.get(i).y);
        float mass = pow(others.get(i).radius(),2);
        if(dist == 0) {continue;}
        int sx = (int)((this.x-others.get(i).x)/abs(this.x-others.get(i).x));
        int sy = (int)((this.y-others.get(i).y)/abs(this.y-others.get(i).y));
        this.dx -= sx*g*mass/dist;//gconstant*pow(this.radius(),2)/pow(dist(this.x,this.y,others.get(i).x,others.get(i).y),2); //acceleration + current, acceleration = gconstant*massother/radius^2
        this.dy -= sy*g*mass/dist;//gconstant*pow(this.radius(),2)/pow(dist(this.x,this.y,others.get(i).x,others.get(i).y),2);
        //print(this.dx + "\n\n");
        //print(this.dy + "\n\n");
      }*/

    }
    frame();
    return true;
  }
}