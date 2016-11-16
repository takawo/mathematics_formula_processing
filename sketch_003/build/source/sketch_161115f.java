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

public class sketch_161115f extends PApplet {

// inspired https://twitter.com/ru_sack/status/774777460856541184
//
// mathematics formula
//
// x=(3+sin(2\u03c0u)sin(2\u03c0v))sin(2\u03c0v)
// y=(3+sin(2\u03c0u)sin(2\u03c0v))cos(2\u03c0v)
// z=cos(2\u03c0u)sin(2\u03c0v)+4v-2
// 0\u2266u\u22661
// 0\u2266v\u22661


// setup\u95a2\u6570 : \u521d\u56de1\u5ea6\u3060\u3051\u5b9f\u884c\u3055\u308c\u308b
public void setup() {
   // \u30a6\u30a3\u30f3\u30c9\u30a6\u30b5\u30a4\u30ba\u3092960px,540px\u306b
  colorMode(HSB, 360, 100, 100); // HSB\u3067\u306e\u8272\u6307\u5b9a\u306b\u3059\u308b
   // \u63cf\u753b\u3092\u6ed1\u3089\u304b\u306b
  sphereDetail(2);
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(0, 0, 100);
  translate(width/2, height/2, -700);
  lights();
  ambientLight(0,0,100);
  rotateX(-PI/8);
  rotateY(frameCount*0.01f);
  stroke(0,0,0);
  float n = 30;
  for (float v = 0; v <= 20; v += .1f) {
    for (float u = 0; u <= TWO_PI; u += TWO_PI/360) {
      float x = v * cos(u) * n;
      float y = 1 * cos(1 * u + 1.5f * v) * n;
      float z = v * sin(u) * n;
      pushMatrix();
      translate(x, y, z);
      point(0,0);
      popMatrix();
    }
  }
}
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_161115f" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
