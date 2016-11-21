/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/784530161664417792
//
// x=-2u*cos(v)+2cos(v)/u-2u^3*cos(3v)/3
// y=6u*sin(v)-2sin(v)/u-2u^3cos(3v)/3
// z=4log(u)
// 0.5≦u≦1
// 0≦v≦2pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = true;

// 変数uの最小値
float minU = 0.5;
// 変数uの最大値
float maxU = 1.0;
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
float scale = 100;

// 背景、ベース、キー色
color bgColor;
color keyColor;
color baseColor;

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  blendMode(ADD);
  //hint(ENABLE_DEPTH_SORT);
  sphereDetail(0);

  bgColor = color(221, 28, 12);
  keyColor = color(227, 20, 18);
  baseColor = color(350, 88, 30);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);

  rotateX(map(pow(sin(frameCount*(TWO_PI/(float)gifCount)),11),-1,1,PI/5,-PI/5));
  rotateY(frameCount*(TWO_PI/(float)gifCount));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = -2 * u * cos(v) + 2 * cos(v) / u - 2 * pow(u,3) * cos(3*v)/3;
      float y = 6 * u * sin(v) - 2 * sin(v) / u - 2 * pow(u,3) * cos(3*v)/3;
      float z = 4 * log(u);
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
