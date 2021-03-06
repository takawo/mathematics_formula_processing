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

public class sketch_043 extends PApplet {

/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/788162503620517888
//
// x=u*cos(v)sin(u)
// y=u*sin(v)
// z=sin(v)
// -2\u2266u\u22662
// pi\u2266v\u2266pi



// \u5909\u6570
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = true;


// \u5909\u6570u\u306e\u6700\u5c0f\u5024
float minU = -2.5f;
// \u5909\u6570u\u306e\u6700\u5927\u5024
float maxU = 2.5f;
// \u5909\u6570v\u306e\u6700\u5c0f\u5024
float minV = -PI;
// \u5909\u6570v\u306e\u6700\u5927\u5024
float maxV = PI;
// \u5206\u5272\u6570
float div = 100;

// u,v\u306e\u5897\u52a0\u30b9\u30c6\u30c3\u30d7
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

// \u30b9\u30b1\u30fc\u30eb
float scale = 50;

// \u80cc\u666f\u3001\u30d9\u30fc\u30b9\u3001\u30ad\u30fc\u8272
int bgColor;
int keyColor;
int baseColor;

// setup\u95a2\u6570 : \u521d\u56de1\u5ea6\u3060\u3051\u5b9f\u884c\u3055\u308c\u308b
public void setup() {
   // \u30a6\u30a3\u30f3\u30c9\u30a6\u30b5\u30a4\u30ba\u3092960px,540px\u306b
  colorMode(HSB, 360, 100, 100, 100); // HSB\u3067\u306e\u8272\u6307\u5b9a\u306b\u3059\u308b
   // \u63cf\u753b\u3092\u6ed1\u3089\u304b\u306b
  //hint(ENABLE_DEPTH_SORT);
  sphereDetail(0);

  bgColor = color(64, 67, 100);
  baseColor = color(14, 90, 89);
  keyColor = color(156, 100, 74);

  gifInit();
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);


  float n = pow(sin(frameCount/(float)gifCount * TWO_PI),3);
  float m = cos(frameCount/(float)gifCount * TWO_PI);
  float fov = map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, .8f, .2f);  //\u8996\u91ce\u89d2
  //perspective(\u8996\u91ce\u89d2\u3001\u7e26\u6a2a\u306e\u6bd4\u7387\u3001\u8fd1\u3044\u9762\u307e\u3067\u306e\u8ddd\u96e2\u3001\u9060\u3044\u9762\u307e\u3067\u306e\u8ddd\u96e2)
  perspective(fov, PApplet.parseFloat(width)/PApplet.parseFloat(height), 1.0f, 10000.0f);

  maxU = map(n,-1,1,2,4);
  minU = map(n,-1,1,-2,-4);

  rotateX(frameCount*(TWO_PI/(float)gifCount));
  rotateY(PI + map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, -PI/4, PI/4));
  //rotateZ(map(n, -1, 1, -PI/8, PI/8));
  //rotateZ(0.00);

  // rotateX(frameCount*(TWO_PI/(float)gifCount));
  // rotateY(PI/6 +frameCount*(TWO_PI/(float)gifCount));
  // rotateZ(frameCount*(PI/8/(float)gifCount));

  stroke(keyColor);
  strokeWeight(.5f);
  line(0, 0, -3000, 0, 0, 3000);
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = u*cos(v) * sin(u + frameCount*(TWO_PI/(float)gifCount));
      float y = u*sin(v);
      float z = sin(u)*2;
      x *= scale;
      y *= scale;
      z *= scale;
      pushMatrix();
      translate(x, y, z);
      noStroke();
      fill(baseColor);
      sphere(5);
      popMatrix();
    }
  }
  gifDraw();
}

public void gifInit() {
  if (isRecord == false) {
    return;
  }
  gifExport = new GifMaker(this, getClass().getSimpleName() +".gif"); // \u30d5\u30a1\u30a4\u30eb\u540d\u306eGIF\u30a2\u30cb\u30e1\u30fc\u30b7\u30e7\u30f3\u3092\u4f5c\u6210
  gifExport.setRepeat(0); // \u30a8\u30f3\u30c9\u30ec\u30b9\u518d\u751f
  gifExport.setQuality(8); // \u30af\u30aa\u30ea\u30c6\u30a3(\u30c7\u30d5\u30a9\u30eb\u30c810)
  gifExport.setDelay(33); // \u30a2\u30cb\u30e1\u30fc\u30b7\u30e7\u30f3\u306e\u9593\u9694\u309230ms(33fps)\u306b
}

public void gifDraw() {
  if (isRecord == false) {
    return;
  }
  //GIF\u30a2\u30cb\u30e1\u30fc\u30b7\u30e7\u30f3\u306e\u4fdd\u5b58
  if (frameCount <= gifCount) {
    gifExport.addFrame(); // \u30d5\u30ec\u30fc\u30e0\u3092\u8ffd\u52a0
  } else {
    gifExport.finish(); // \u7d42\u4e86\u3057\u3066\u30d5\u30a1\u30a4\u30eb\u4fdd\u5b58
    exit();
  }
}
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_043" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
