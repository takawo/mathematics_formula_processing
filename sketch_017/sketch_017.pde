/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/778741808457060356
//
// x=sqrt(1+v^2)*cos(u)
// y=sqrt(1+v^2)*sin(4u)
// z=v
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
float div = 300;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = (abs(maxU - minU)/div)/2;

// スケール
float scale = 200;

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

  bgColor = color(15, 34, 100);
  keyColor = color(351, 48, 100);
  baseColor = color(69, 67, 54);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  translate(width/2, height/2, -500);
  rotateX(2.10);
  rotateY(0.00);
  rotateZ(frameCount*0.01);

  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = (sqrt(1+pow(v, 2))*cos(u)) * scale;
      float y = (sqrt(1+pow(v, 2))*sin(4 * u)) * scale;
      float z = v * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}