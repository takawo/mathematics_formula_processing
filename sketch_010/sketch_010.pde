/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/775830254006906884
//
//  x=cos(u)*(0.5*cos(3*v))
//  y=sin(u)*(0.5*cos(3*v))
//  z=sin(v)
//  0≦u≦2pi
//  0≦v≦2pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(4);
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(186, 17, 22);
  translate(width/2, height/2, -500);
  rotateX(map(sin(frameCount*(TWO_PI/(float)gifCount)),-1,1,-PI,PI));
  rotateY(map(cos(frameCount*(TWO_PI/(float)gifCount)),-1,1,-PI/4,PI/4));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));
  lights();
  fill(186, 17, 100);
  noStroke();
  float n = 400;
  for (float v = 0; v < TWO_PI; v += TWO_PI/150) {
    for (float u = 0; u < TWO_PI; u += TWO_PI/60) {
      float x = (cos(u) * (0.5 * cos(3 * v))) * n;
      float y = (sin(u) * (0.5 * cos(3 * v))) * n;
      float z = (sin(v)) * n;
      pushMatrix();
      translate(x, y, z);
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
