/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/779863884698046464
//
// x=u*cos(v)*sin(u)
// y=u*cos(u)*cos(v)
// z=sin(2v)
// 0≦u≦2pi
// -pi≦v≦pi

// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = TWO_PI;
// 変数vの最小値
float minV = -PI;
// 変数vの最大値
float maxV = PI;
// 分割数
float div = 100;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = (abs(maxU - minU)/div)/2;

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

  bgColor = color(226, 26, 27);
  keyColor = color(351, 80, 92);
  baseColor = color(145, 8, 93);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  translate(width/2, height/2, -500);
  rotateX(0.37);
  rotateY(0.35);
  rotateZ(frameCount*0.01);
  stroke(keyColor);
  line(0,0,-1027,0,0,1000);
  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = (u * cos(v) * sin(u)) * scale;
      float y = (u * cos(u) * cos(v)) * scale;
      float z = sin(2 * v) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}
