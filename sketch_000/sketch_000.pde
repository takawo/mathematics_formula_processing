/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/791065524255854592
//
// x=(R+r*cos(v))cos(u)
// y=(R+r*cos(v))sin(u)
// z=r*sin(v)
// 0≦u≦2pi
// 0≦v≦2pi

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(8);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(210, 45, 31);
  float r = 100;
  float R = 250;
  translate(width/2, height/2, -500);
  rotateX(frameCount*0.01);
  rotateZ(frameCount*0.01);
  fill(192,2,95);
  noStroke();
  for (float v = 0; v <= TWO_PI; v += TWO_PI/20) {
    for (float u = 0; u <= TWO_PI; u += TWO_PI/50) {
      float x = (R + r * cos(v)) * cos(u);
      float y = (R + r * cos(v)) * sin(u);
      float z = r * sin(v);
      pushMatrix();
      translate(x, y, z);
      sphere(2);
      popMatrix();
    }
  }
}
