class Name { 
  color c; 
  String name;
  float xpos;
  float ypos;
  float xxpos;
  float yypos;
  float size;
  float textsize;
  float sizechange;
  float yspeed;
  float ychange;
  boolean mouse;
  
  Name() { 
    c = color(random(150,200),random(180,200),random(150,180));
    xpos = random(20,width-20);
    ypos = random(0,height);
    size = 25;
    sizechange = 0.02;
    yspeed = random(0.1,0.2);
    ychange = random(0,height);
    mouse = false;
  }
  
  void display() { 
    ellipseMode(CENTER);
    if (mouse) { 
      fill(255,0,0);
      stroke(255,0,0);
      size = 25;
    } else {
      fill(c);
      stroke(c);
    }
    textAlign(CENTER);
    textSize(textsize/1.5);
    if (textsize<0){
    textsize = 0;
    }
    xxpos=xpos;
    yypos=ypos;
    float r1 = dist(motionX,motionY,xpos,ypos); 
    float si1 = (motionX-xpos)/r1; 
    float co1 = (motionY-ypos)/r1; 
    if(abs(r1)<size/3.6){ 
    xxpos = motionX; 
    yypos = motionY; 
    }else{ 
    xxpos = xpos+size/5*si1; 
    yypos = ypos+size/5*co1; 
    } 

    ellipse(xxpos, yypos, size/1.8, size/1.8);
    line(xpos,ypos, motionX,motionY);
    noFill();
    ellipse(xpos, ypos, size, size);
    text(name,xpos,ypos-size/1.2);
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
    if (motionX > xpos - 20 && motionX < xpos + 20 && motionY > ypos-20 && motionY < ypos + 20) {
      mouse = true;
    } else {
      mouse = false;
    }
  }
}
