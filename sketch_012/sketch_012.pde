/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/776552356662026240
//  x=(cos(u)*cos(v))^3
//  y=(sin(u)*cos(v))^3
//  z=sin(v)^3
//  -pi/2≦u≦pi/2
//  -pi≦v≦pi
// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(2);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(302, 28, 20);
  translate(width/2, height/2, -500);
  lights();
  rotateX(frameCount*0.015);
  rotateZ(frameCount*0.01);

  fill(25, 69, 100);
  noStroke();
  float n = 400;
  for (float v = -PI; v <= PI; v += PI/100f) {
    for (float u = -PI/2; u <= PI/2; u += PI/100f) {
      float x = pow((cos(u)*cos(v)),3) * n;
      float y = pow((sin(u)*cos(v)),3) * n;
      float z = pow(sin(v),3) * n;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}
