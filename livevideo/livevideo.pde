import processing.video.*;
Capture video;
//Particle[] particles;

void setup(){
  size(640,480);
  video = new Capture(this, 640, 480,30);
  video.start();
  //particles = new Particle(new PVector(width/2,20));
  //for (int i=0; i< particles.length; i++){
  //  particles[i] = new Particle();
  //}
}

void captureEvent(Capture video){
  video.read();
}

void draw(){
  background(0);
  image(video,0,0);
  //particles.addParticle();
  //particles.run();
}

//class Particle{
//  PVector loaction;
//  PVector velocity;
//  PVector acceleration;
  
//  float lifespan = 255;
  
//  Particle(){
//    acceleration = new PVector(0,0.05);
//    velocity = new PVector(random(-1,1),random(-1,1));
//    location = 1.get();
//  }  
//  void update(){
//     velocity.add(acceleration);
//     location.add(velocity);
     
//     lifespan -= 2;
//  }
  
//  boolean isDead(){
//  if(lifespan<=0){
//    return true;
//  } 
//  else{
//    return false;
//  }
//}
//  void display(){
//    stroke(0, lifespan);
//    strokeWeight(2);
//    fill(127, lifespan);
//    ellipse(location.x, location.y,12,12);
//}
