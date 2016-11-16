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

public class sketch_009 extends PApplet {

/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/775457941969248256
//
//  x=u*cos(v)
//  y=u*sin(v)
//  z=v
//  -2\u2266u\u22662
//  -1pi\u2266v\u22661pi

// setup\u95a2\u6570 : \u521d\u56de1\u5ea6\u3060\u3051\u5b9f\u884c\u3055\u308c\u308b
public void setup() {
   // \u30a6\u30a3\u30f3\u30c9\u30a6\u30b5\u30a4\u30ba\u3092960px,540px\u306b
  colorMode(HSB, 360, 100, 100, 100); // HSB\u3067\u306e\u8272\u6307\u5b9a\u306b\u3059\u308b
   // \u63cf\u753b\u3092\u6ed1\u3089\u304b\u306b
  sphereDetail(4);
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(194, 97, 50);
  translate(width/2, height/2, -500);
  rotateX(-PI/2);
  rotateY(PI/8);
  rotateZ(frameCount*0.01f);
  lights();
  stroke(54, 25, 65, 50);
  line(0, 0, -1000, 0, 0, 1000);

  fill(55, 15, 94);
  noStroke();
  float n = 150;
  for (float v = -PI; v <= PI; v += PI/50) {
    for (float u = -2; u <= 2; u += .05f) {
      float x = (u*cos(v))*n;
      float y = (u*sin(v))*n;
      float z = (v)*n;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_009" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
