import org.openkinect.processing.*;

// Kinect Library object
Kinect kinect;

float minThresh = 480;
float maxThresh = 830;
PImage img;
int w = 512;
int h = 424;
PVector upMost = new PVector(h,h);
PVector downMost = new PVector(0,0);
PVector leftMost = new PVector(w,w);
PVector rightMost = new PVector(0,0);
//
void setup() {
  size(512, 424);
  kinect = new Kinect(this);
  kinect.initDepth();
  img = createImage(kinect.width, kinect.height, RGB);
}


void draw() {
  background(0);

  img.loadPixels();

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  int count = 0;
    leftMost.x = w;
    leftMost.y = w;
    rightMost.x = 0;
    rightMost.y = 0;
    downMost.x = 0;
    downMost.y = 0;
    upMost.x = h;
    upMost.y = h;
  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];
      //
      if (d > minThresh && d < maxThresh) {
        //count++;
        img.pixels[offset] = color(255, 150, 50);
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
  println(upMost.x+"   "+ upMost.y+"   "+downMost.x+"   "+downMost.y);
  println(">> "+leftMost.x+"   "+ leftMost.y+"   "+rightMost.x+"   "+rightMost.y);
  println("   ");
  img.updatePixels();
  image(img, 0, 0);
   fill(200,50,150,111);
       
      //shape   
      //beginShape();
      //vertex(upMost.x, upMost.y);
      //vertex(rightMost.x, rightMost.y);
      //vertex(downMost.x, downMost.y);
      //vertex(leftMost.x, leftMost.y);
      //endShape(CLOSE);
      
      //square
       beginShape();
      vertex(leftMost.x, upMost.y);
      vertex(rightMost.x, upMost.y);
      vertex(rightMost.x, downMost.y);
      vertex(leftMost.x, downMost.y);
      endShape(CLOSE);
  
   
  //fill(255);
  //textSize(32);
  //text(minThresh + " " + maxThresh, 10, 64);
}