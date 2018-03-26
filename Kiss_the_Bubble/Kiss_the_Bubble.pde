import processing.video.*;
Name[] theName = new Name[20];
// String s = "name1,name2,name3";
String[] names_arr = {"Katherine", "Maddie", "Izzy", "Shahriar","Amira","Jaynaba","Idriss","Yiping","Claire","Oliwia","Angelica","Gisela","Justin","Jingyi","Lucas","Ari","Ryan","Arvi","Joyce","rashid"};

  
Capture video;
PImage prev;

float threshold = 25;

float motionX = 0;
float motionY = 0;

float closestX = 0;
float closestY = 0; ;float lerpX = 0;
float lerpY = 0;

color trackColor; 

//int cellSize = 1;
//// Number of columns and rows in our system
//int cols, rows;

void setup() {
  size(1280, 720);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, width,height);
  video.start();
  prev = createImage(1280, 720, RGB);
  for(int i=0; i < theName.length; i++){
    theName[i] = new Name();
    theName[i].name = names_arr[i];
    //println(theName[i].name);
  }
  trackColor = color(0);
  //cols = width / cellSize;
  //rows = height / cellSize;
  //background(0);
  //colorMode(RGB, 255, 255, 255, 100);
}


//void mousePressed() {
//}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  video.loadPixels();
  prev.loadPixels();
  //for (int ii = 0; ii < cols; ii++) {
  //    // Begin loop for rows
  //    for (int j = 0; j < rows; j++) {
      
  //      // Where are we, pixel-wise?
  //      int xx = ii*cellSize;
  //      int yy = j*cellSize;
  //      int locc = (video.width - xx - 1) + yy*video.width; // Reversing x to mirror the image
      
  image(video, 0, 0);
  threshold = 50;
  
  float worldRecord = 500; 

  int count = 0;
  
  float avgX = 0;
  float avgY = 0;

  loadPixels();
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);
      
      float r3 = red(trackColor);
      float g3 = green(trackColor);
      float b3 = blue(trackColor);
      
      //float r = red(video.pixels[locc]);
      //float g = green(video.pixels[locc]);
      //float b = blue(video.pixels[locc]);

      float d = distSq(r1, g1, b1, r2, g2, b2); 
      float dd = dist(r1, g1, b1, r3, g3, b3);
      //color cc = color(r, g, b, 75);
  
      if (d > threshold*threshold) {
        avgX += x;
        avgY += y;
        count++;
        pixels[loc] = color(random(200,255),random(100,150),random(100,200));
      } else {
        pixels[loc] = color(0);
      }
      
      if (dd < worldRecord) {
        worldRecord = dd;
        closestX = x;
        closestY = y;
      }
    }
  }
  updatePixels();

  if (count > 2500) { 
    motionX = avgX / count;
    motionY = avgY / count;
  }
  
  
  fill(255,255,0);
  strokeWeight(2.0);
  stroke(0);
  ellipseMode(CENTER);
  ellipse(motionX, motionY, 6, 6);
  
  if (worldRecord < 100) { 
    // Draw a circle at the tracked pixel
        fill(255,0,0);
        strokeWeight(4.0);
        stroke(0);
        ellipse(closestX, closestY, 50, 50);
        println(closestX, closestY);
  }
  

  for(int i=0; i < theName.length; i++){
    theName[i].move(); 
    theName[i].display();
    theName[i].rollover(mouseX, mouseY);
  }
  //pushMatrix();
  //      translate(xx+cellSize/2, yy+cellSize/2);
  //      // Rotation formula based on brightness
  //      rotate((2 * PI * brightness(c) / 255.0));
  //      rectMode(CENTER);
  //      fill(c);
  //      noStroke();
  //      // Rects are larger than the cell for some overlap
  //      rect(0, 0, cellSize+6, cellSize+6);
  //      popMatrix();
  //    }
  //  }
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}
