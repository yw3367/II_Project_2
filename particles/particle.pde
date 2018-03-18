class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.00001);
    velocity = new PVector(random(-10, 1), random(-10, 1));
    position = l.copy();
    lifespan = 10000.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 5.0;
  }

  // Method to display
  void display() {
    stroke(255);
    fill(255);
    ellipse(position.x, position.y, 40, 40);
    fill(0,0,0);
    textAlign(CENTER);
    text("name",position.x+20, position.y+20);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
