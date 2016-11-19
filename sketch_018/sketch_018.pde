/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/778007033865842688
//
// x=sqrt(10v)*cos(u)
// y=sqrt(10v)*sin(u)
// z=cos(5u)
// 0≦u≦2pi
// 0≦v≦1

// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = TWO_PI;
// 変数vの最小値
float minV = 0;
// 変数vの最大値
float maxV = 1;
// 分割数
float div = 400;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

// スケール
float scale = 100;

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
  sphereDetail(2);

  bgColor = color(50, 35, 100);
  keyColor = color(35, 77, 100);
  baseColor = color(149, 69, 54);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 60);
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
      float x = (sqrt(10.0 * v) * cos(u)) * scale;
      float y = (sqrt(10.0 * v) * sin(u)) * scale;
      float z = cos(5.0 * u) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(5);
      popMatrix();
    }
  }
}