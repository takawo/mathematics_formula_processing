/*  mathematics formula */
//  inspired https://twitter.com/i/moments/782451244178690049
//  x=u-(u^3/3+v^2*u)
//  y=v-(v^3/3+u^2*v)
//  z=u^2-v^2
//  -1≦u≦1
//  -1≦v≦1

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(4);
  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(194, 30, 30);
  translate(width/2, height/2, -500);
  rotateX(PI/2 * cos(frameCount/(float)gifCount * TWO_PI));
  rotateY(PI/8 * sin(frameCount/(float)gifCount * TWO_PI));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));
  lights();
  stroke(54, 25, 65, 50);
  line(0, 0, -1000, 0, 0, 1000);

  fill(140, 50, 100);
  noStroke();
  float n = 400;
  for (float v = -1; v <= 1; v += 2/200f) {
    for (float u = -1; u <= 1; u += 2/100f) {
      float x = (u-(pow(u, 3)/3+pow(v, 2)*u))*n;
      float y = (v-(pow(v, 3)/3+pow(u, 2)*v))*n;
      float z = (pow(u, 2)-pow(v, 2))*n;
      pushMatrix();
      translate(x, y, z);
      sphere(3);
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
