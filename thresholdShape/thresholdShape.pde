import org.openkinect.processing.*;

// Kinect Library object
Kinect kinect;

float minThresh = 580;
float maxThresh = 830;
PImage img;
int w = 640;
int h = 480;
PVector upMost = new PVector(h,h);
PVector downMost = new PVector(0,0);
PVector leftMost = new PVector(w,w);
PVector rightMost = new PVector(0,0);
//
void setup() {
  noStroke();
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  img = createImage(kinect.width, kinect.height, RGB);
  //println(kinect.width, kinect.height);
}


void draw() {
  background(0);

  img.loadPixels();

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  int count = 0;
    leftMost.x = w-100;
    leftMost.y = w-100;
    rightMost.x = 100;
    rightMost.y = 100;
    downMost.x = 100;
    downMost.y = 100;
    upMost.x = h-100;
    upMost.y = h-100;
  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];
      //
      if (d > minThresh && d < maxThresh) {
        //count++;
        img.pixels[offset] = color(255, 80, 50);
        if(x<leftMost.x){
          leftMost.x = x;
          leftMost.y = y;
          //println("new left"+x);
        }
        if(x>rightMost.x){
          rightMost.x = x;
          rightMost.y = y;
          //println("new right"+x);
        }
        //
        if(y>downMost.y){
          downMost.x = x;
          downMost.y = y;
          //println("new down"+y);
        }
        if(y<upMost.y){
          upMost.x = x;
          upMost.y = y;
          //println("new up"+y);
        }
        
        //
      } else {
        img.pixels[offset] = color(0);
      }
    }
  }
  //println(upMost.x+"   "+ upMost.y+"   "+downMost.x+"   "+downMost.y);
  //println(">> "+leftMost.x+"   "+ leftMost.y+"   "+rightMost.x+"   "+rightMost.y);
  //println("   ");
  img.updatePixels();
   fill(0,255,100,200);
   
      //beginShape();
      //vertex(upMost.x, upMost.y);
      //vertex(rightMost.x, rightMost.y);
      //vertex(downMost.x, downMost.y);
      //vertex(leftMost.x, leftMost.y);
      //endShape(CLOSE);

  //square
  //beginShape();
  //    vertex(leftMost.x, upMost.y);
  //    vertex(rightMost.x, upMost.y);
  //    vertex(rightMost.x, downMost.y);
  //    vertex(leftMost.x, downMost.y);
  //    endShape(CLOSE); 
   
  //fill(255);
  //textSize(32);
  //text(minThresh + " " + maxThresh, 10, 64);
}