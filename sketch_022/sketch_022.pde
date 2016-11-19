/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/779863884698046464
//
// x=u-(u^3/3)+u*v^2
// y=v-(v^3/3)+u^2*v
// z=u^3-v^3
// -2≦u≦2
// -2≦v≦2

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = true;

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

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0,0,40);
  translate(width/2, height/2, -500);

  float n = sin(frameCount/(float)gifCount * PI);
  float fov = map(n,-1,1,0.3,1.0);  //視野角
  //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  perspective(fov, float(width)/float(height), 1.0, 10000.0);

  rotateX(PI/3 * cos(frameCount/(float)gifCount * TWO_PI));
  rotateY(-PI/6 * sin(frameCount/(float)gifCount * TWO_PI));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));

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
