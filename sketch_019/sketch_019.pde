/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/779449378800934912
//
// x=v*cos(u)
// y=v*sin(u)
// z=v*sin(2u)
// 0≦u≦2pi
// -1≦v≦1

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
float minV = -1;
// 変数vの最大値
float maxV = 1;
// 分割数
float div = 200;

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

  bgColor = color(199, 62, 25);
  keyColor = color(149, 15, 67);
  baseColor = color(80, 14, 86);
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);

  float n = sin(frameCount/(float)gifCount * PI);
  float fov = map(n,-1,1,-PI/2,PI/2);  //視野角
  //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  perspective(fov, float(width)/float(height), 1.0, 10000.0);

  rotateX(PI/2);
  rotateY(-PI/4 * sin(frameCount/(float)gifCount * TWO_PI));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  noFill();
  fill(baseColor);
  noStroke();

  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x=v * cos(u) * scale;
      float y=v * sin(u) * scale;
      float z=v * sin(2 * u) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(10);
      popMatrix();
    }
  }
  gifDraw();
}

void gifInit(){
  if(isRecord == false){
    return;
  }
  gifExport = new GifMaker(this, getClass().getSimpleName() +".gif"); // ファイル名のGIFアニメーションを作成
  gifExport.setRepeat(0); // エンドレス再生
  gifExport.setQuality(8); // クオリティ(デフォルト10)
  gifExport.setDelay(33); // アニメーションの間隔を30ms(33fps)に
}
void gifDraw(){
  if(isRecord == false){
    return;
  }
  //GIFアニメーションの保存
  if(frameCount <= gifCount){
    gifExport.addFrame(); // フレームを追加
  } else {
    gifExport.finish(); // 終了してファイル保存
    exit();
  }
}
