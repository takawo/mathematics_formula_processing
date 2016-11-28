/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/789600557316972544
//
// x=cos(v)*(2+cos(u))/sqrt(1+sin(v)^2)
// y=sin(v-2pi/3)*(2+cos(u-2pi/3))/sqrt(1+sin(v)^2)
// z=sin(v+2pi/3)(2+cos(u+2 pi/3))/sqrt(1+sin(v)^2)
// 0≦u≦2pi
// 0≦v≦2pi

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
float maxV = TWO_PI;
// 分割数
float div = 150;

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
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  // blendMode(ADD);
  //hint(ENABLE_DEPTH_SORT);
  sphereDetail(8);

  // https://color.adobe.com/ja/explore/most-popular/?time=all
  bgColor = color(80, 14, 40);
  keyColor = color(199, 62, 25);
  baseColor = color(78, 40, 100);
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 10);
  translate(width/2, height/2, -500);
  float n = pow(sin(frameCount/(float)gifCount * TWO_PI),3);
  float fov = map(n,-1,1,-PI/2,PI/2);  //視野角
  //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  perspective(fov, float(width)/float(height), 1.0, 10000.0);

  rotateX(frameCount*(PI/(float)gifCount));
  rotateY(frameCount*(TWO_PI/(float)gifCount));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      // formula_is_here
      float x = cos(v)*(2+cos(u))/sqrt(1+pow(sin(v),2));
      float y = sin(v-TWO_PI/3)*(2+cos(u-TWO_PI/3))/sqrt(1+pow(sin(v),2));
      float z = sin(v+TWO_PI/3)*(2+cos(u+TWO_PI/3))/sqrt(1+pow(sin(v),2));
      x *= scale;
      y *= scale;
      z *= scale;
      pushMatrix();
      translate(x, y, z);
      fill(baseColor);
      noStroke();
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
