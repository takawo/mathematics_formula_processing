/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/784172829222719490
//
// x=u-cosh(v)*sin(u)
// y=1-cos(u)*cosh(v)
// z=-4*sin(u/2)*sinh(v/2)
// -2pi≦u≦2pi
// -1.4≦v≦1.4

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// 変数uの最小値
float minU = -TWO_PI;
// 変数uの最大値
float maxU = TWO_PI;
// 変数vの最小値
float minV = -1.4;
// 変数vの最大値
float maxV = 1.4;
// 分割数
float div = 400;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

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
  blendMode(ADD);
  smooth(); // 描画を滑らかに
  //hint(ENABLE_DEPTH_SORT);
  sphereDetail(4);

  bgColor = color(228, 10, 20);
  keyColor = color(209, 57, 51);
  baseColor = color(214, 71, 32);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);

  // float n = sin(frameCount/(float)gifCount * PI);
  // float fov = map(n,-1,1,0,0.8);  //視野角
  // //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  // perspective(fov, float(width)/float(height), 1.0, 10000.0);


  rotateX(frameCount * TWO_PI/gifCount);
  //rotateY(map(sin(frameCount * TWO_PI/gifCount),-1,1,PI/16,-PI/16));
  rotateY(map(pow(cos(frameCount * PI/gifCount),5),-1,1,0,PI));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  noFill();
  fill(baseColor);
  noStroke();
  float t = map(cos(frameCount * TWO_PI/gifCount), -1, 1, 0.999, 2.0);

  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = u - (float)Math.cosh(v) * sin(u);
      float y = 1 - cos(u) * (float)Math.cosh(v);
      float z = -4 * sin(u/t) * (float)Math.sinh(v/t);
      x *= scale;
      y *= scale;
      z *= scale;
      pushMatrix();
      translate(x, y, z);
      // stroke(baseColor);
      // point(0,0,0);
      fill(baseColor);
      sphere(6);
      popMatrix();
    }
  }
  gifDraw();
}

void gifInit() {
  if (isRecord == false) {
    return;
  }
  gifExport = new GifMaker(this, getClass().getSimpleName() +".gif"); // ファイル名のGIFアニメーションを作成
  gifExport.setRepeat(0); // エンドレス再生
  gifExport.setQuality(8); // クオリティ(デフォルト10)
  gifExport.setDelay(33); // アニメーションの間隔を30ms(33fps)に
}

void gifDraw() {
  if (isRecord == false) {
    return;
  }
  //GIFアニメーションの保存
  if (frameCount <= gifCount) {
    gifExport.addFrame(); // フレームを追加
  } else {
    gifExport.finish(); // 終了してファイル保存
    exit();
  }
}
