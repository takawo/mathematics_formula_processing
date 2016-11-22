/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/785661197014052865
//
// x=0.5(1-cos(u))*sin(u)*2cos(v)
// y=0.5(1-cos(u))*sin(u)*2sin(v)
// z=cos(u)^3
// 0≦u≦pi
// 0≦v≦2pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = PI;
// 変数vの最小値
float minV = 0;
// 変数vの最大値
float maxV = TWO_PI;
// 分割数
float div = 400;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

// スケール
float scale = 150;

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
  sphereDetail(0);

  bgColor = color(221, 28, 20);
  keyColor = color(227, 20, 18);
  baseColor = color(350, 88, 30);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 10);
  translate(width/2, height/2, -500);

   float n = sin(frameCount/(float)gifCount * TWO_PI);
   float fov = map(n,-1,1,0,1.0);  //視野角
   //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
   perspective(fov, float(width)/float(height), 1.0, 10000.0);


  rotateX(1.50 + map(n,-1,1,-1,0));
  rotateY(0.00);
  rotateZ(frameCount/(float)gifCount * TWO_PI);

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = 0.5 * (1-cos(u)) * sin(u) * 2 * cos(v);
      float y = 0.5 * (1-cos(u)) * sin(u) * 2 * sin(v);
      float z = pow(cos(u),3);
      x *= scale;
      y *= scale;
      z *= scale;
      pushMatrix();
      translate(x, y, z);
      noFill();
      fill(baseColor);
      sphere(3);
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