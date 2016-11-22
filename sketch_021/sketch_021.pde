/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/779863884698046464
//
// h=1+u^2*sin(v)^2
// x=(2(cos(u)+u*sin(u))sin(v))/h
// y=(2(-u*cos(u)+sin(u))sin(v))/h
// z=log(tan(v/2))+2cos(v)/h
// -4.5≦u≦4.5
// 0.03≦v≦3.11

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// 変数uの最小値
float minU = -4.5;
// 変数uの最大値
float maxU = 4.5;
// 変数vの最小値
float minV = 0.03;
// 変数vの最大値
float maxV = 3.11;
// 分割数
float div = 500;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/(div);
float stepV = abs(maxU - minU)/(div);

// スケール
float scale = 200;

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

  bgColor = color(302, 28, 20);
  keyColor = color(347, 23, 39);
  baseColor = color(25, 69, 100);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  translate(width/2, height/2, -500);

  rotateX(PI/3 + PI/6 * cos(frameCount/(float)gifCount * TWO_PI));
  rotateY(-PI/6 + PI/3 * sin(frameCount/(float)gifCount * TWO_PI));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));

  stroke(keyColor);
  line(0,0,-1000,0,0,1000);
  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float h=1+ u * u * sin(v)* sin(v);
      float x = ((2 * (cos(u) + u * sin(u)) * sin(v))/h) * scale;
      float y = ((2 * (-u * cos(u) + sin(u)) * sin(v))/h) * scale;
      float z = (log(tan(v/2))+ 2 * cos(v)/h) * scale;
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
