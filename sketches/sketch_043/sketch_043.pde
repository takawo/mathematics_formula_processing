/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/788162503620517888
//
// x=u*cos(v)sin(u)
// y=u*sin(v)
// z=sin(v)
// -2≦u≦2
// pi≦v≦pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// 変数uの最小値
float minU = -2.5;
// 変数uの最大値
float maxU = 2.5;
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
  sphereDetail(0);

  bgColor = color(64, 67, 100);
  baseColor = color(14, 90, 89);
  keyColor = color(156, 100, 74);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);


  float n = pow(sin(frameCount/(float)gifCount * TWO_PI),3);
  float m = cos(frameCount/(float)gifCount * TWO_PI);
  float fov = map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, .8, .2);  //視野角
  //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  perspective(fov, float(width)/float(height), 1.0, 10000.0);

  maxU = map(n,-1,1,2,4);
  minU = map(n,-1,1,-2,-4);

  rotateX(frameCount*(TWO_PI/(float)gifCount));
  rotateY(PI + map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, -PI/4, PI/4));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = u*cos(v) * sin(u + frameCount*(TWO_PI/(float)gifCount));
      float y = u*sin(v);
      float z = sin(u)*2;
      x *= scale;
      y *= scale;
      z *= scale;
      pushMatrix();
      translate(x, y, z);
      noStroke();
      fill(baseColor);
      sphere(5);
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
