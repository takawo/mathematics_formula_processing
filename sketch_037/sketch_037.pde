/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/786034760875249668
//
// x=(sin(u)cos(v))/(sin(u)^6(sin(v)^6+cos(v)^6)+cos(u)^6)^(1/6)
// y=(sin(u)sin(v))/(sin(u)^6(sin(v)^6+cos(v)^6)+cos(u)^6)^(4/9)
// z=(cos(u))/(sin(u)^6*(sin(v)^6+cos(v)^6)+cos(u)^6)^(4/9)
// 0≦u≦2pi
// 0≦v≦pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = true;

// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = TWO_PI;
// 変数vの最小値
float minV = 0;
// 変数vの最大値
float maxV = PI;
// 分割数
float div = 400;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/(div);
float stepV = abs(maxU - minU)/(div);

// スケール
float scale = 50;

// 背景、ベース、キー色
color bgColor;
color keyColor;
color baseColor;

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  blendMode(ADD);
  smooth(); // 描画を滑らかに
  sphereDetail(0);

  bgColor = color(197, 2, 20);
  keyColor = color(240, 73, 99);
  baseColor = color(160, 80, 15);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  translate(width/2, height/2, -500);

  lights();
  ambientLight(0, 0, 100, 890, 0, 0);

  float n = sin(frameCount/(float)gifCount * TWO_PI);
  float fov = map(n, -1, 1, 0.5, 0.8);  //視野角
  //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  perspective(fov, float(width)/float(height), 1.0, 10000.0);

  rotateX(frameCount/(float)gifCount * TWO_PI);
  rotateY(map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, 0, PI));
  rotateZ(1.93);

  stroke(keyColor);
  line(0, 0, -1000, 0, 0, 1000);
  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      // x=(sin(u)cos(v))/(sin(u)^6(sin(v)^6+cos(v)^6)+cos(u)^6)^(1/6)
      // y=(sin(u)sin(v))/(sin(u)^6(sin(v)^6+cos(v)^6)+cos(u)^6)^(4/9)
      // z=(cos(u))/(sin(u)^6*(sin(v)^6+cos(v)^6)+cos(u)^6)^(4/9)
      float sinU_6 = pow(sin(u), 6);
      float cosU_6 = pow(cos(u), 6);
      float sinV_6 = pow(sin(v), 6);
      float cosV_6 = pow(cos(v), 6);
      double dx = pow((sin(u)*cos(v))/(sinU_6*(sinV_6+cosV_6)+cosU_6), 1.00);
      double dy = pow((sin(u)*sin(v))/(sinU_6*(sinV_6+cosV_6)+cosU_6), 1.00);
      double dz = pow((cos(u))/(sinU_6*(sinV_6+cosV_6)+cosU_6), 1.00);
      float x = (float)(dx) * scale;
      float y = (float)(dy) * scale;
      float z = (float)(dz) * scale;
      pushMatrix();
      translate(x, y, z);
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
