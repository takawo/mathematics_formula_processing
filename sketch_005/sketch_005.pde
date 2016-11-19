/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/773762461614739456
//
//  x=(2+s*cos(t))*sin(2*pi*s)
//  y=(2+s*cos(t))*cos(2*pi*s)+2*s
//  z=s*sin(t)
//  s1>=0
//  s2<=1
//  t1>=-pi
//  t2<=pi

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
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(80, 14, 90);
  translate(width/2, height/4, -500);
  rotateY(frameCount*(TWO_PI/(float)gifCount));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));
  lights();
  stroke(198, 44, 44);
  noFill();
  float n = 100;
  beginShape(POINTS);
  for (float t = -PI; t <= PI; t += PI/100.0) {
    for (float s = 0; s <= 1; s += 1/100.0) {
      float x = ((2+s*cos(t))*sin(2*PI*s)) * n;
      float y = ((2+s*cos(t))*cos(2*PI*s)+2*s) * n;
      float z = (s*sin(t)) * n;
      vertex(x,y,z);
      // pushMatrix();
      // translate(x, y, z);
      // point(0,0);
      // popMatrix();
    }
  }
  endShape();

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
