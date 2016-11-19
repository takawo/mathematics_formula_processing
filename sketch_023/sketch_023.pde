/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/780954536986804225
//
// x=(4+1cos(v)*(1+sin(u)))*cos(u)
// y=(4+1cos(v)*(1+sin(u)))*sin(u)
// z=1*sin(v)(1+sin(u))
// 0≦u≦2pi
// 0≦v≦2pi

// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = TWO_PI;
// 変数vの最小値
float minV = 0;
// 変数vの最大値
float maxV = TWO_PI;
// 分割数
float div = 100;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/(div);
float stepV = abs(maxU - minU)/(div);

// スケール
float scale = 60;

// 背景、ベース、キー色
color bgColor;
color keyColor;
color baseColor;

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(0);

  bgColor = color(197, 2, 80);
  keyColor = color(358, 73, 99);
  baseColor = color(210, 45, 31);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 80);
  translate(width/2, height/2, -500);
  rotateX(-0.47);
  rotateY(0.50);
  rotateZ(frameCount*0.01);
  stroke(keyColor);
  line(0, 0, -1000, 0, 0, 1000);
  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float h = 1 + u * u * sin(v) * sin(v);
      float x = ((4 + 1 * cos(v)*(1 + sin(u))) * cos(u)) * scale;
      float y = ((4 + 1 * cos(v)*(1 + sin(u))) * sin(u)) * scale;
      float z = (1 * sin(v) * (1+sin(u))) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(10);
      popMatrix();
    }
  }
}
