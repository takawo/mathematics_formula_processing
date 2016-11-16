/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/774116195469451264
//
//  x=cos(u)*(3*cos(v)-cos(3*v))
//  y=sin(u)*(3*cos(v)-cos(3*v))
//  z=3*sin(v)-sin(3*v)
//  0≦u≦2pi
//  -pi/2≦v≦pi/2

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(8);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(184,100,20);
  translate(width/2, height/2, -500);
  rotateX(PI/2);
  rotateY(PI/6);
  rotateZ(frameCount*0.01);
  lights();
  fill(347,65,78);
  noStroke();
  float n = 400;
  for(float v = 0; v <= TWO_PI; v += TWO_PI/50){
    for(float u = 0; u <= PI; u += PI/50){
      float x = (0.5*(1-cos(u))*sin(u)*cos(v))*n;
      float y = (0.5*(1-cos(u))*sin(u)*sin(v))*n;
      float z = (cos(u))*n;
      pushMatrix();
      translate(x,y,z);
      sphere(5);
      popMatrix();
    }
  }
}
