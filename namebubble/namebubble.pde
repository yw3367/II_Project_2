Name[] theName = new Name[10]; 
char data[] = {'B', 'H', 'C', 'D'};

void setup() {
  size(640, 480);
  for(int i=0; i < theName.length; i++){
    theName[i] = new Name();
  }
}

void draw() {
  background(255);
  for(int i=0; i < theName.length; i++){
    theName[i].move(); 
    theName[i].display();
    theName[i].rollover(mouseX, mouseY);
  }
}

class Name { 
  color c; 
  float xpos;
  float ypos;
  float size;
  float textsize;
  float sizechange;
  float yspeed;
  float ychange;
  boolean mouse;

  Name() { 
    c = color(175,175,20);
    xpos = random(0,width);
    ypos = 0;
    size = 25;
    sizechange = 0.02;
    yspeed = random(0.5,1);
    ychange = random(0,height);
    mouse = false;
  }

  void display() { 
    ellipseMode(CENTER);
    if (mouse) { 
      fill(255,0,0);
      size = 25;
    } else {
      fill(c);
    }
    textAlign(CENTER);
    textSize(textsize);
    if (textsize<0){
    textsize = 0;
    }
    for (int a = 0; a < data.length; a++){
      text(data[a], xpos,ypos-size/1.2);
    }
    noStroke();
    ellipse(xpos, ypos, size, size);
  }
    void move() { 
    ypos = ypos + yspeed;
    size = size - sizechange;
    if (ypos > height) {
      ypos = 0;
    }
    if (size < 3) {
      size = 3;
    }
    textsize=size/2;
  }
  void rollover(int mx, int my) {  
    if (mx > xpos - 20 && mx < xpos + 20 && my > ypos-20 && my < ypos + 20) {
      mouse = true;
    } else {
      mouse = false;
    }
  }
}
