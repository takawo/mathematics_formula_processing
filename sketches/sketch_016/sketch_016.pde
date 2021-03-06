/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/778400647079075840
//
// x=0.2 * (-u*u + 2) * e^(0.11 * v) * cos(v)
// y=0.2 * (-u*u + 2) * e^(0.11 * v) * sin(v)
// z=u
// -1≦u≦1
// 0≦v≦4pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;



// 変数uの最小値
float minU = -1;
// 変数uの最大値
float maxU = 1;
// 変数vの最小値
float minV = 0;
// 変数vの最大値
float maxV = 2 * TWO_PI;
// 分割数
float div = 50;

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

  bgColor = color(0, 0, 25);
  keyColor = color(186,98, 55);
  baseColor = color(180, 84, 95);
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  translate(width/2, height/2, -500);
  rotateY(PI/2 * pow(sin(frameCount/(float)gifCount * TWO_PI),3));
  rotateZ(-frameCount*(TWO_PI/(float)gifCount));

  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = (0.2 * (-u*u + 2) * exp(0.11 * v) * cos(v)) * scale;
      float y = (0.2 * (-u*u + 2) * exp(0.11 * v) * sin(v)) * scale;
      float z = (u) * scale;
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
