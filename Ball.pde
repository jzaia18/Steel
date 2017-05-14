class Ball {

  int diameter;
  int state;
  int max;
  float x, y, dx, dy;
  color c;

  Ball() {
    state = 0;
    max = 80 + (int)random(100);
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    dx = random(10)-5;
    dy = random(10)-5;
  }
  
  Ball(int Diameter) {
    this();
    diameter = Diameter;
    x = random(width-diameter) + diameter/2;
    y = random(height-diameter) + diameter/2;
    
  }
  
  Ball(int mx, int my) {
    this((int)random(20) + 20);
    state = 1;
    x = mx;
    y = my;
  }

  void state(int s) {
    state = s;
  }

  void display() {
    fill(c);
    ellipse(x, y, diameter, diameter);
  }

  void move() {
    x += dx;
    y += dy;
    if (x <= diameter/2 || x >= width-diameter/2)  dx = -dx;
    if (y <= diameter/2 || y >= height-diameter/2) dy = -dy;
  }
  
  void frame(ArrayList<Ball> explosions) {
    if(state == -1) { return; }
    display();
    if(state == 0) {
      move();
      for(Ball e : explosions) {
        if( pow(this.x-e.x,2) + pow(this.y-e.y,2) < pow(this.diameter/2+e.diameter/2,2) ) {
          state(1);
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
  }
}