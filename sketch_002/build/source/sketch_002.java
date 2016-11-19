import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_002 extends PApplet {

/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/798308368007892992
//
//  x=exp(0.12u)(3.5+1.25cos(v))cos(1u)
//  y=exp(0.12u)(3.5+1.25cos(v))sin(1u)
//  z=exp(0.12u)(0+1.25sin(v))
//  -40\u2266u\u2266-1
//  0\u2266v\u22662pi



// \u5909\u6570
GifMaker gifExport;
int gifCount = 90;

// setup\u95a2\u6570 : \u521d\u56de1\u5ea6\u3060\u3051\u5b9f\u884c\u3055\u308c\u308b
public void setup() {
   // \u30a6\u30a3\u30f3\u30c9\u30a6\u30b5\u30a4\u30ba\u3092960px,540px\u306b
  colorMode(HSB, 360, 100, 100); // HSB\u3067\u306e\u8272\u6307\u5b9a\u306b\u3059\u308b
   // \u63cf\u753b\u3092\u6ed1\u3089\u304b\u306b
  sphereDetail(4);
  gifInit();
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(0, 0, 0);
  noStroke();
  fill(0,0,100);
  lights();
  ambientLight(0,0,100);
  translate(width/2, height/2, -500);
  rotateY(frameCount*0.01f);
  rotateX(frameCount*0.015f);
  float n = 100;
  for (float u = -40; u<=-1; u += 39f/400f) {
    for (float v = 0; v <= TWO_PI; v += TWO_PI/20) {
      float x= exp(0.12f*u)*(3.5f+1.25f*cos(v))*cos(1*u)*n;
      float y= exp(0.12f*u)*(3.5f+1.25f*cos(v))*sin(1*u)*n;
      float z= exp(0.12f*u)*(0+1.25f*sin(v))*n;
      //println(x,y,z);
      pushMatrix();
      translate(x, y, z);
      sphere(3);
      popMatrix();
    }
  }
  gifDraw();
}

public void gifInit(){
  gifExport = new GifMaker(this, getClass().getSimpleName() +".gif"); // \u30d5\u30a1\u30a4\u30eb\u540d\u306eGIF\u30a2\u30cb\u30e1\u30fc\u30b7\u30e7\u30f3\u3092\u4f5c\u6210
  gifExport.setRepeat(0); // \u30a8\u30f3\u30c9\u30ec\u30b9\u518d\u751f
  gifExport.setQuality(8); // \u30af\u30aa\u30ea\u30c6\u30a3(\u30c7\u30d5\u30a9\u30eb\u30c810)
  gifExport.setDelay(33); // \u30a2\u30cb\u30e1\u30fc\u30b7\u30e7\u30f3\u306e\u9593\u9694\u309230ms(33fps)\u306b
}
public void gifDraw(){
  gifExport.addFrame();

  //GIF\u30a2\u30cb\u30e1\u30fc\u30b7\u30e7\u30f3\u306e\u4fdd\u5b58
  if(frameCount <= gifCount){
    gifExport.addFrame(); // \u30d5\u30ec\u30fc\u30e0\u3092\u8ffd\u52a0
    } else {
      gifExport.finish(); // \u7d42\u4e86\u3057\u3066\u30d5\u30a1\u30a4\u30eb\u4fdd\u5b58
    }
  }
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_002" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
