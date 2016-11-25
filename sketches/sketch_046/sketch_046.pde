/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/789264225747079168
//
// x=cos(u)
// y=-cos(u+v)^2
// z=cos(v)
// -pi≦u≦pi
// -pi≦v≦pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// 変数uの最小値
float minU = -PI;
// 変数uの最大値
float maxU = PI;
// 変数vの最小値
float minV = -PI;
// 変数vの最大値
float maxV = PI;
// 分割数
float div = 400;

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

  bgColor = color(262, 20, 28);
  keyColor = color(332, 20, 28);
  baseColor = color(18, 17, 92);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);

  float n = pow(sin(frameCount/(float)gifCount * TWO_PI),3);
  float fov = map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, .5, 1.0);  //視野角
  //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  perspective(fov, float(width)/float(height), 1.0, 10000.0);

  rotateX(-PI/8 + map(cos(frameCount/(float)gifCount * TWO_PI),-1,1,PI/16,-PI/16));
  rotateY(PI/4 + frameCount/(float)gifCount * TWO_PI);
  rotateZ(map(sin(frameCount/(float)gifCount * TWO_PI),-1,1,PI/4,-PI/4));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  line(0, -3000, 0, 0, 3000,0);
  line(-3000, 0, 0, 3000,0,0);
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = cos(u);
      float y = pow(-cos(u+v),2);
      float z = cos(v);
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
