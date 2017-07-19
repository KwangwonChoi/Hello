import java.util.Random;
//import org.openkinect.processing.*;

int numberOfFrames = 8;  // The number of frames in the animation
int frame = 0;

//Kinect2 kinect2;

fish luisy;
fish seungmin;

void setup()
{
  size(800, 480);
  frameRate(24);
  
  luisy = new fish("whale",80,48,8);
  seungmin = new fish("fish",80,48,8);
  // If you don't want to load each image separately
  // and you know how many frames you have, you
  // can create the filenames as the program runs.
  // The nf() command does number formatting, which will
  // ensure that the number is (in this case) 4 digits.
} 
 
void draw() 
{
  background(250);
  
  frame = (frame+1) % numberOfFrames;  // Use % to cycle through frames
  luisy.getImage();
  seungmin.getImage();

}

interface backGround{
int backgroundX = 800;
int backgroundY = 480;
}

class fish implements backGround{
  
  final int numberOfFrames;
  
  PImage[] boydImageSeq;

  float pre[];
  float cur[];
  float fut[];
  float sub[];
  
  final float imageWidth;
  final float imageHeight;
  
  Random random;

  public fish(String name,float imageWidth,float imageHeight,int numberOfFrames){
    // pre describes this potion's coordinate. and fut signifying future position.    
    pre = new float[2]; // pre[0] = x, pre[1] = y;
    fut = new float[2]; // fut[0] = x, fut[1] = y;
    
    //load image files.    
    this.numberOfFrames = numberOfFrames;
    boydImageSeq = new PImage[numberOfFrames];
    for(int i=0; i < numberOfFrames; i++) {
      String imageName = name + "/" + name + "_" + nf(i, 5) + ".png";
      boydImageSeq[i] = loadImage(imageName);
    }
    
    //setting cur, pre, fut position.
    random = new Random();
     pre[0] = random.nextInt(backgroundX);
     pre[1] = random.nextInt(backgroundY);
     
     cur = pre;
     
     fut[0] = mouseX;
     fut[1] = mouseY;
     
     sub = new float[2];
     sub[0] = fut[0] - pre[0];
     sub[1] = fut[1] - pre[1];
     
     this.imageWidth = imageWidth;
     this.imageHeight = imageHeight;
  }
  
  private void getCurPosition(){ //moving function.
    cur[0] = cur[0] + (float) (sub[0]/backgroundX*10);
    cur[1] = cur[1] + (float) (sub[1]/backgroundY*10);
    
    if(cur[0] == fut[0] && cur[1] == fut[1]){
    pre = cur;
    fut[0] = mouseX;
    fut[1] = mouseY;
    }
    
  }
  
  public void getImage(){
    getCurPosition();
   image(boydImageSeq[frame], cur[0]-(imageWidth/2), cur[1]-(imageHeight/2),imageWidth,imageHeight);
  }
  
 
  
 
}
