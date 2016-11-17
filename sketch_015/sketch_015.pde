/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/778007033865842688
//
// x=sin(u)
// y=sin(v)
// z=sin(u+v)
// -pi≦u≦pi
// -pi≦v≦pi

// 変数uの最小値
float minU = -PI;
// 変数uの最大値
float maxU = PI;
// 変数vの最小値
float minV = -PI;
// 変数vの最大値
float maxV = PI;
// 分割数
float div = 150;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

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
  sphereDetail(2);

  bgColor = color(0, 0, 100);
  keyColor = color(175,17, 81);
  baseColor = color(353, 93, 54);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0,0,50);
  translate(width/2, height/2, -500);
  rotateX(frameCount*0.005);
  rotateY(frameCount*0.0015);
  rotateZ(frameCount*0.01);

  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x= (sin(u)) * scale;
      float y= (sin(v)) * scale;
      float z= (sin(u+v)) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(15);
      popMatrix();
    }
  }
}
