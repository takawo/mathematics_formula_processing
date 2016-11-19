/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/779449378800934912
//
// x=v*cos(u)
// y=v*sin(u)
// z=v*sin(2u)
// 0≦u≦2pi
// -1≦v≦1

// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = TWO_PI;
// 変数vの最小値
float minV = -1;
// 変数vの最大値
float maxV = 1;
// 分割数
float div = 200;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

// スケール
float scale = 300;

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
  sphereDetail(0);

  bgColor = color(199, 62, 25);
  keyColor = color(149, 15, 67);
  baseColor = color(80, 14, 86);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);
  rotateX(frameCount*0.005);
  rotateY(frameCount*0.0015);
  rotateZ(frameCount*0.01);
  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  noFill();
  fill(baseColor);
  noStroke();

  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x=v * cos(u) * scale;
      float y=v * sin(u) * scale;
      float z=v * sin(2 * u) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(10);
      popMatrix();
    }
  }
}
