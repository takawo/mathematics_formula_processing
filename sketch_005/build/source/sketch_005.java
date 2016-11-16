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

public class sketch_005 extends PApplet {

/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/773762461614739456
//
//  x=(2+s*cos(t))*sin(2*pi*s)
//  y=(2+s*cos(t))*cos(2*pi*s)+2*s
//  z=s*sin(t)
//  s1>=0
//  s2<=1
//  t1>=-pi
//  t2<=pi

// setup\u95a2\u6570 : \u521d\u56de1\u5ea6\u3060\u3051\u5b9f\u884c\u3055\u308c\u308b
public void setup() {
   // \u30a6\u30a3\u30f3\u30c9\u30a6\u30b5\u30a4\u30ba\u3092960px,540px\u306b
  colorMode(HSB, 360, 100, 100); // HSB\u3067\u306e\u8272\u6307\u5b9a\u306b\u3059\u308b
   // \u63cf\u753b\u3092\u6ed1\u3089\u304b\u306b
}

// draw\u95a2\u6570 : setup\u95a2\u6570\u5b9f\u884c\u5f8c\u7e70\u308a\u8fd4\u3057\u5b9f\u884c\u3055\u308c\u308b
public void draw() {
  background(80, 14, 90);
  translate(width/2, height/4, -500);
  rotateY(frameCount*0.01f);
  rotateZ(frameCount*0.003f);
  lights();
  stroke(198, 44, 44);
  noFill();
  float n = 100;
  beginShape(POINTS);
  for (float t = -PI; t <= PI; t += PI/100.0f) {
    for (float s = 0; s <= 1; s += 1/100.0f) {
      float x = ((2+s*cos(t))*sin(2*PI*s)) * n;
      float y = ((2+s*cos(t))*cos(2*PI*s)+2*s) * n;
      float z = (s*sin(t)) * n;
      vertex(x,y,z);
      // pushMatrix();
      // translate(x, y, z);
      // point(0,0);
      // popMatrix();
    }
  }
  endShape();
}
  public void settings() {  size(960, 540, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_005" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
