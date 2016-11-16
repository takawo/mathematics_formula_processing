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

public class sketch_010 extends PApplet {

/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/775830254006906884
//
//  x=cos(u)*(0.5*cos(3*v))
//  y=sin(u)*(0.5*cos(3*v))
//  z=sin(v)
//  0\u2266u\u22662pi
//  0\u2266v\u22662pi

// setup\u95a2\u6570 : \u521d\u56de1\u5ea6\u3060\u3051\u5b9f\u884c\u3055\u308c\u308b
public void setup() {
   // \u30a6\u30a3\u30f3\u30c9\u30a6\u30b5\u30a4\u30ba\u3092960px,540px\u306b
  colorMode(HSB, 360, 100, 100); // HSB\u3067\u306e\u8272\u6307\u5b9a\u306b\u3059\u308b
   // \u63cf\u753b\u3092\u6ed1\u3089\u304b\u306b
  sphereDetail(4);
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(186, 17, 22);
  translate(width/2, height/2, -500);
  rotateX(PI/2);
  rotateZ(frameCount*0.005f);
  lights();
  fill(186, 17, 100);
  noStroke();
  float n = 400;
  for (float v = 0; v < TWO_PI; v += TWO_PI/150) {
    for (float u = 0; u < TWO_PI; u += TWO_PI/60) {
      float x = (cos(u) * (0.5f * cos(3 * v))) * n;
      float y = (sin(u) * (0.5f * cos(3 * v))) * n;
      float z = (sin(v)) * n;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_010" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
