class Explosion extends Ball {

  float max, growS, shrinkS; //maxsize, grow/shrink speeds
  boolean grow, shrink, dead;

  Explosion() {
    super();
    max = 100;
    growS = 1;
    shrinkS = 1;
    grow = true;
    shrink = false;
    dead = false;
  }

  Explosion(float Mx, float My) {
    super(Mx, My);
    max = 100;
    growS = 1;
    shrinkS = 1;
    grow = true;
    shrink = false;
    dead = false;
  }

  Explosion(Ball B) {
    super(B.diameter, B.x, B.y, B.c);
    max = 2*diameter+random(3*diameter);
    growS = 50/diameter;
    shrinkS = 50/diameter;
    grow = true;
    shrink = false;
    dead = false;
  }

  void explode() {
    if (dead) { 
      return;
    } else if (grow) { 
      grow();
    } else if (shrink) { 
      shrink();
    } else { 
      dead = true;
    } //error, kill
  }

  void grow() {
    if (diameter < max) {
      diameter += growS;
      return;
    }
    grow = false;
    shrink = true;
  }

  void shrink() {
    if (diameter > 1) {
      diameter -= shrinkS;
      return;
    }
    shrink = false;
    dead = true;
  }

  boolean collide(Ball B) {
    return !(B instanceof Explosion) && dist(this.x, this.y, B.x, B.y) <= minDist(B);
  }

  float minDist(Ball B) {
    return this.radius() + B.radius();
  }

  void frame() {
    display();
    explode();
  }

  boolean frame(ArrayList<Ball> others) { //add collision detection
    if(dead) { return false; }
    for(int i = 0; i < others.size(); i++) {
      if(collide(others.get(i))) {
        others.set(i,new Explosion(others.get(i)));
      }
    }
    frame();
    return true;
  }
}