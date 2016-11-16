/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/775830254006906884
//
//  x=cos(u)*(0.5*cos(3*v))
//  y=sin(u)*(0.5*cos(3*v))
//  z=sin(v)
//  0≦u≦2pi
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
  background(186, 17, 22);
  translate(width/2, height/2, -500);
  rotateX(PI/2);
  rotateZ(frameCount*0.005);
  lights();
  fill(186, 17, 100);
  noStroke();
  float n = 400;
  for (float v = 0; v < TWO_PI; v += TWO_PI/150) {
    for (float u = 0; u < TWO_PI; u += TWO_PI/60) {
      float x = (cos(u) * (0.5 * cos(3 * v))) * n;
      float y = (sin(u) * (0.5 * cos(3 * v))) * n;
      float z = (sin(v)) * n;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}
