import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_024 extends PApplet {

/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/781281699275472896
// x=(cos(2u)*cos(v))^3
// y=(sin(u)*cos(v))^3
// z=sin(v)^3
// -pi/2\u2266u\u2266pi/2
// -pi\u2266v\u2266pi

// \u5909\u6570u\u306e\u6700\u5c0f\u5024
float minU = -PI/2;
// \u5909\u6570u\u306e\u6700\u5927\u5024
float maxU = PI/2;
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
float scale = 300;

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

  bgColor = color(351, 80, 92);
  keyColor = color(145, 8, 93);
  baseColor = color(226, 26, 57);
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);
  rotateX(frameCount*0.01f);
  rotateY(PI/4 + frameCount*0.01f);
  rotateZ(PI/8);
  stroke(keyColor);
  strokeWeight(.5f);
  line(-3000, 0, 0, 3000, 0, 0);
  noFill();
  fill(baseColor);
  noStroke();

  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = pow((cos(2 * u) * cos(v)), 3) * scale;
      float y = pow((sin(u) * pow(cos(v), 3)), 3) * scale;
      float z = (pow(sin(v), 3)) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(10);
      popMatrix();
    }
  }
}
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_024" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
