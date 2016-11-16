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

public class sketch_008 extends PApplet {

/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/775098568298278912
//
//  x=(1+sin(1*PI*u)sin(1*PI*v))sin(4*PI*v)
//  y=(1+sin(1*PI*u)sin(1*PI*v))cos(4*PI*v)
//  z=cos(1*PI*u)sin(1*PI*v)+4v-2
//  0\u2266u\u22661
//  0\u2266v\u22661

// setup\u95a2\u6570 : \u521d\u56de1\u5ea6\u3060\u3051\u5b9f\u884c\u3055\u308c\u308b
public void setup() {
   // \u30a6\u30a3\u30f3\u30c9\u30a6\u30b5\u30a4\u30ba\u3092960px,540px\u306b
  colorMode(HSB, 360, 100, 100, 100); // HSB\u3067\u306e\u8272\u6307\u5b9a\u306b\u3059\u308b
   // \u63cf\u753b\u3092\u6ed1\u3089\u304b\u306b
  sphereDetail(4);
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(50, 53, 100);
  translate(width/2, height/2, -500);
  rotateX(PI/2);
  rotateY(PI/8+frameCount*0.0001f);
  rotateZ(frameCount*0.05f);
  lights();
  stroke(20, 100, 100, 50);
  line(0, 0, -1000, 0, 0, 1000);

  fill(143, 50, 80);
  noStroke();
  float n = 200;
  for (float v = 0; v <= 1; v += .003f) {
    for (float u = 0; u <= 1; u += .05f) {
      float x = ((1+sin(1*PI*u)*sin(1*PI*v))*sin(4*PI*v))*n;
      float y = ((1+sin(1*PI*u)*sin(1*PI*v))*cos(4*PI*v))*n;
      float z = (cos(1*PI*u)*sin(1*PI*v)+4*v-2)*n;
      pushMatrix();
      translate(x, y, z);
      sphere(3);
      popMatrix();
    }
  }
}
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_008" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
