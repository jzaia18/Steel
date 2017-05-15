class Ball {

  int diameter;
  int opacity = 200;
  float x, y;
  color c;

  Ball() {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    diameter = 25;
    x = random(width - diameter) + diameter/2;
    y = random(height - diameter) + diameter/2;
  }
  
  Ball(int Diameter) {
    this();
    diameter = Diameter;
    x = random(width - diameter) + diameter/2;
    y = random(height - diameter) + diameter/2;
  }
  
  Ball(float Mx, float My) {
    this((int)random(25) + 25);
    x = Mx;
    y = My;
  }
  
  Ball(int Diameter, float Mx, float My) {
    this(Diameter);
    x = Mx;
    y = My;
  }
  
  
  Ball(int Diameter, float Mx, float My, color C) {
    this(Diameter,Mx,My);
    c = C;
  }
  
  float radius() {
    return diameter/2;
  }
  
  void display() {
    fill(c,opacity);
    ellipse(x, y, diameter, diameter);
  }
  
  void frame() {
    display();
  }
  
  boolean frame(ArrayList<Ball> others) {
    frame();
    return true;
  }
}
/*
  void move() {
    x += dx;
    y += dy;
    if (x <= diameter/2 || x >= width-diameter/2)  dx = -dx;
    if (y <= diameter/2 || y >= height-diameter/2) dy = -dy;
  }

  void frame(ArrayList<Ball> explosions, ArrayList<Ball> regulars) {
    if(state == -1) { return; }
    display();
    if(state == 0) {
      move();
      for(Ball e : explosions) {
        if( pow(this.x-e.x,2) + pow(this.y-e.y,2) < pow(this.diameter/2+e.diameter/2,2) ) {
          state(1);
        }
      }
      for(Ball e: regulars) {
        if( pow(this.x-e.x,2) + pow(this.y-e.y,2) <= pow(this.diameter/2+e.diameter/2,2) &&
            pow(this.x-e.x,2) + pow(this.y-e.y,2) > 1) {
          float tx = this.dx;
          float ty = this.dy;
          this.dx = e.diameter/(float)this.diameter*e.dx;
          this.dy = e.diameter/(float)this.diameter*e.dy;
          e.dx = this.diameter/(float)e.diameter*tx;
          e.dy = this.diameter/(float)e.diameter*ty;
          move();
          e.move();
        }
      }
    }
    else if(state == 1) {
      if(diameter >= max) {
        state(2);
      }
      diameter++;
    }
    else if(state == 2) {
      if(diameter <= 2) {
        state(-1);
      }
      diameter--;
    }
    else {
      return;
    }
  }
*/