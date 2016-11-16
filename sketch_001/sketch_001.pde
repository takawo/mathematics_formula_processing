/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/774777460856541184
//
//  x=(3+sin(2πu)sin(2πv))sin(2πv)
//  y=(3+sin(2πu)sin(2πv))cos(2πv)
//  z=cos(2πu)sin(2πv)+4v-2
//  0≦u≦1
//  0≦v≦1

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(4);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(6,74,91);
  float r = 100;
  float R = 250;
  translate(width/2, height/2, -500);
  lights();
  rotateY(PI/2);
  rotateZ(frameCount*0.01);
  fill(192,2,95);
  noStroke();
  float n = 100;
  for (float v = -5; v <= 5; v += 0.01) {
    for (float u = 0; u <= 1; u += 0.1) {
      float x = (3 + sin(TWO_PI * u) * sin(TWO_PI * v)) * sin(TWO_PI * v) * n;
      float y = (3 + sin(TWO_PI * u) * sin(TWO_PI * v)) * cos(TWO_PI * v) * n;
      float z = cos(TWO_PI * u) * sin(TWO_PI * v) + (4 * v - 2)*n;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}
