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
  sphereDetail(2);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(0, 0, 100);
  translate(width/2, height/2, -700);
  lights();
  ambientLight(0,0,100);
  rotateX(-PI/8);
  rotateY(frameCount*0.01);
  stroke(0,0,0);
  float n = 30;
  for (float v = 0; v <= 20; v += .1) {
    for (float u = 0; u <= TWO_PI; u += TWO_PI/360) {
      float x = v * cos(u) * n;
      float y = 1 * cos(1 * u + 1.5 * v) * n;
      float z = v * sin(u) * n;
      pushMatrix();
      translate(x, y, z);
      point(0,0);
      popMatrix();
    }
  }
}
