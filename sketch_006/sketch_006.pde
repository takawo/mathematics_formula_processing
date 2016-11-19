/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/774116195469451264
//
//  x=cos(u)*(3*cos(v)-cos(3*v))
//  y=sin(u)*(3*cos(v)-cos(3*v))
//  z=3*sin(v)-sin(3*v)
//  0≦u≦2pi
//  -pi/2≦v≦pi/2

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = true;

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(8);
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(47,22,96);
  translate(width/2, height/2, -500);
  rotateX(frameCount*(TWO_PI/(float)gifCount));
  rotateY(PI/8);
  rotateZ(frameCount*(PI/(float)gifCount));
  lights();
  fill(184,73,47);
  noStroke();
  float n = 100;
    for(float v = -PI/2; v <= PI/2; v += PI/50){
      for(float u = 0; u <= TWO_PI; u += TWO_PI/50){
      float x = (cos(u)*(3*cos(v)-cos(3*v))) * n;
      float y = (sin(u)*(3*cos(v)-cos(3*v))) * n;
      float z = (3*sin(v)-sin(3*v)) * n;
      pushMatrix();
      translate(x,y,z);
      sphere(5);
      popMatrix();
    }
  }
  gifDraw();
}

void gifInit(){
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
