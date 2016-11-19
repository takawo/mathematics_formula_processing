/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/779863884698046464
//
// x=u-(u^3/3)+u*v^2
// y=v-(v^3/3)+u^2*v
// z=u^3-v^3
// -2≦u≦2
// -2≦v≦2

// 変数uの最小値
float minU = -2;
// 変数uの最大値
float maxU = 2;
// 変数vの最小値
float minV = -2;
// 変数vの最大値
float maxV = 2;
// 分割数
float div = 100;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/(div);
float stepV = abs(maxU - minU)/(div);

// スケール
float scale = 20;

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

  bgColor = color(194, 100, 35);
  keyColor = color(71, 74, 65);
  baseColor = color(28, 100, 89);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0,0,40);
  translate(width/2, height/2, -500);
  rotateX(0.00);
  rotateY(PI/2);
  rotateZ(frameCount*0.01);
  stroke(keyColor);
  line(0,0,-1000,0,0,1000);
  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float h=1+ u * u * sin(v)* sin(v);
      float x = (u - (pow(u,3) / 3) + u * pow(v,2)) * scale;
      float y = (v - (pow(v,3) / 3) + pow(u,2) * v) * scale;
      float z = (pow(u,3) - pow(v,3)) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}