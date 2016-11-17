/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/776903869917896704
//
//  x=2cos(v)sinh(u)-0.667cos(3v)sinh(3u)
//  y=2sin(v)sinh(u)+0.667sin(3v)sinh(3u)
//  z=2cos(2v)cosh(2u)
//  -1≦u≦1
//  -pi/2≦v≦pi/2

// 変数uの最小値
float minU = -1;
// 変数uの最大値
float maxU = 1;
// 変数vの最小値
float minV = -PI/2;
// 変数vの最大値
float maxV = PI/2;
// 分割数
float div = 150;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

// スケール
float scale = 40;

// 背景、ベース、キー色
color bgColor;
color keyColor;
color baseColor;

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  //hint(ENABLE_DEPTH_SORT);
  sphereDetail(1);

  bgColor = color(204, 22, 27);
  keyColor = color(197,31, 53);
  baseColor = color(40, 89, 100);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  translate(width/2, height/2, -500);
  rotateX(PI/2);
  rotateY(PI/4);
  rotateZ(-frameCount*0.01);
  lights();
  stroke(keyColor);
  line(0, 0, -1000, 0, 0, 1000);

  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = (2 * cos(v) * (float)Math.sinh(u) - 0.667 * cos(3 * v) * (float)Math.sinh(3 * u)) * scale;
      float y = (2 * sin(v) * (float)Math.sinh(u) + 0.667 * sin(3 * v) * (float)Math.sinh(3 * u)) * scale;
      float z = (2 * cos(2 * v) * (float)Math.cosh(2 * u)) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(3);
      popMatrix();
    }
  }
}
