import processing.video.*;
Name[] theName = new Name[20];
// String s = "name1,name2,name3";
String[] names_arr = {"Katherine", "Maddie", "Izzy", "Shahriar","Amira","Jaynaba","Idriss","Yiping","Claire","Oliwia","Angelica","Gisela","Justin","Jingyi","Lucas","Ari","Ryan","Arvi","Joyce","rashid"};

  
Capture video;
PImage prev;

float threshold = 25;

float motionX = 0;
float motionY = 0;

float lerpX = 0;
float lerpY = 0;


void setup() {
  size(640, 360);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, width,height);
  video.start();
  prev = createImage(640, 360, RGB);
  for(int i=0; i < theName.length; i++){
    theName[i] = new Name();
    theName[i].name = names_arr[i];
    //println(theName[i].name);
  }
}


void mousePressed() {
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  video.loadPixels();
  prev.loadPixels();
  image(video, 0, 0);
  threshold = 50;


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

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d > threshold*threshold) {
        avgX += x;
        avgY += y;
        count++;
        pixels[loc] = color(255);
      } else {
        pixels[loc] = color(0);
      }
    }
  }
  updatePixels();

  if (count > 2000) { 
    motionX = avgX / count;
    motionY = avgY / count;
  }
  
  fill(255,255,0);
  strokeWeight(2.0);
  stroke(0);
  ellipseMode(CORNER);
  ellipse(motionX, motionY, 6, 6);
  
  for(int i=0; i < theName.length; i++){
    theName[i].move(); 
    theName[i].display();
    theName[i].rollover(mouseX, mouseY);
  }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}
