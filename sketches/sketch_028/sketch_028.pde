/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/782740937873043456
//
// x=(1+0.25(cos(u/2)sin(v)-sin(u/2)sin(2v)))cos(u)
// y=(1+0.25(cos(u/2)sin(v)-sin(u/2)sin(2v)))sin(u)
// z=0.25(sin(u/2)sin(v)+cos(u/2)sin(2v))
// 0≦u≦2pi
// 0≦v≦2pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = TWO_PI;
// 変数vの最小値
float minV = 0;
// 変数vの最大値
float maxV = TWO_PI;
// 分割数
float div = 200;

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

  bgColor = color(66, 35, 95);
  keyColor = color(187, 5, 56);
  baseColor = color(259, 36, 42);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);

  // float n = sin(frameCount/(float)gifCount * PI);
  // float fov = map(n,-1,1,0,0.8);  //視野角
  // //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  // perspective(fov, float(width)/float(height), 1.0, 10000.0);


  rotateX(-frameCount*(TWO_PI/(float)gifCount));
  rotateY(frameCount*(TWO_PI/(float)gifCount));
  rotateZ(-frameCount*(TWO_PI/(float)gifCount));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  noFill();
  fill(baseColor);
  noStroke();
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = (1 + 0.25 * (cos(u/2) * sin(v) - sin(u/2) * sin(2 * v))) * cos(u);
      float y = (1 + 0.25 * (cos(u/2) * sin(v) - sin(u/2) * sin(2 * v))) * sin(u);
      float z = 0.25 * (sin(u/2) * sin(v) + cos(u/2) * sin(2 * v));
      x *= scale;
      y *= scale;
      z *= scale;

      pushMatrix();
      translate(x, y, z);
      // stroke(baseColor);
      // point(0,0,0);
      fill(baseColor);
      sphere(6);
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
