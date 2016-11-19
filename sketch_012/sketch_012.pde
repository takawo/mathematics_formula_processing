/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/776552356662026240
//  x=(cos(u)*cos(v))^3
//  y=(sin(u)*cos(v))^3
//  z=sin(v)^3
//  -pi/2≦u≦pi/2
//  -pi≦v≦pi
// setup関数 : 初回1度だけ実行される

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = true;

void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(2);
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(302, 28, 20);
  translate(width/2, height/2, -500);
  lights();

  rotateX(-PI/2 * cos(frameCount/(float)gifCount * TWO_PI));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));

  fill(25, 69, 100);
  noStroke();
  float n = 400;
  for (float v = -PI; v <= PI; v += PI/100f) {
    for (float u = -PI/2; u <= PI/2; u += PI/100f) {
      float x = pow((cos(u)*cos(v)),3) * n;
      float y = pow((sin(u)*cos(v)),3) * n;
      float z = pow(sin(v),3) * n;
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
