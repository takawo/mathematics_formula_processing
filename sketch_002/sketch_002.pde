/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/798308368007892992
//
//  x=exp(0.12u)(3.5+1.25cos(v))cos(1u)
//  y=exp(0.12u)(3.5+1.25cos(v))sin(1u)
//  z=exp(0.12u)(0+1.25sin(v))
//  -40≦u≦-1
//  0≦v≦2pi

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(4);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(0, 0, 0);
  noStroke();
  fill(0,0,100);
  lights();
  ambientLight(0,0,100);
  translate(width/2, height/2, -500);
  rotateY(frameCount*0.01);
  rotateX(frameCount*0.015);
  float n = 100;
  for (float u = -40; u<=-1; u += 39f/400f) {
    for (float v = 0; v <= TWO_PI; v += TWO_PI/20) {
      float x= exp(0.12*u)*(3.5+1.25*cos(v))*cos(1*u)*n;
      float y= exp(0.12*u)*(3.5+1.25*cos(v))*sin(1*u)*n;
      float z= exp(0.12*u)*(0+1.25*sin(v))*n;
      //println(x,y,z);
      pushMatrix();
      translate(x, y, z);
      sphere(3);
      popMatrix();
    }
  }
}
