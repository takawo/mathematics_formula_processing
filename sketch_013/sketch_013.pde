/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/776903869917896704
//
//  x=u*cos(v)*sin(u)
//  y=u*cos(u)*cos(v)
//  z=-u*sin(v)
//  0≦u≦2pi
//  -pi≦v≦pi

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
float stepV = abs(maxU - minU)/div;

// スケール
float scale = 50;

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
  sphereDetail(4);
  bgColor = color(318, 100, 37);
  keyColor = color(73, 100, 71);
  baseColor = color(168, 100, 100);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  translate(width/2, height/2, -500);
  rotateX(-PI/2);
  rotateY(PI/5);
  rotateZ(frameCount*0.01);
  lights();
  stroke(keyColor);
  line(0, 0, -1000, 0, 0, 1000);

  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = (u*cos(v)*sin(u))*scale;
      float y = (u*cos(u)*cos(v))*scale;
      float z = (-u*sin(v))*scale;
      pushMatrix();
      translate(x, y, z);
      sphere(10);
      popMatrix();
    }
  }
}
