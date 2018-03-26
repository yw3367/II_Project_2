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
    xpos = random(50,width-50);
    ypos = random(0,height);
    size = 50;
    sizechange = 0.02;
    yspeed = random(0.1,0.15);
    ychange = random(0,height);
    mouse = false;
  }
  
  void display() { 
    ellipseMode(CENTER);
    if (mouse) { 
      fill(255,0,0);
      stroke(255,0,0);
      size += 2;
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
    float r1 = dist(closestX,closestY,xpos,ypos); 
    float si1 = (closestX-xpos)/r1; 
    float co1 = (closestY-ypos)/r1; 
    if(abs(r1)<size/3.6){ 
    xxpos = closestX; 
    yypos = closestY; 
    }else{ 
    xxpos = xpos+size/5*si1; 
    yypos = ypos+size/5*co1; 
    } 

    ellipse(xxpos, yypos, size/1.8, size/1.8);
    line(xpos,ypos, closestX,closestY);
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
    if (closestX > xpos - size/2 && closestX < xpos + size/2 && closestY > ypos-size/2 && closestY < ypos + size/2) {
        mouse = true;
    } else {
      mouse = false;
    }
  }
}
