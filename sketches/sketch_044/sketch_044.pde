/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/788484631666397184
//
// x=(cos(u)-cos(2u))*cos(v)/4
// y=(sin(u)-sin(2u))*sin(v)/4
// z=cos(u)
// 0≦u≦pi
// 0≦v≦2pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = false;


// 変数uの最小値
float minU = 0;
// 変数uの最大値
float maxU = PI;
// 変数vの最小値
float minV = 0;
// 変数vの最大値
float maxV = TWO_PI;
// 分割数
float div = 100;

// u,vの増加ステップ
float stepU = abs(maxU - minU)/div;
float stepV = abs(maxU - minU)/div;

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
  //hint(ENABLE_DEPTH_SORT);
  sphereDetail(0);

  bgColor = color(202, 84, 35);
  baseColor = color(39, 98, 95);
  keyColor = color(73, 84, 65);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);


  float n = pow(sin(frameCount/(float)gifCount * TWO_PI),3);
  float m = cos(frameCount/(float)gifCount * TWO_PI);
  float fov = map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, -.2, -.8);  //視野角
  //perspective(視野角、縦横の比率、近い面までの距離、遠い面までの距離)
  perspective(fov, float(width)/float(height), 1.0, 10000.0);

  maxU = map(n,-1,1,2,4);
  minU = map(n,-1,1,-2,-4);

  rotateX(frameCount*(TWO_PI/(float)gifCount));
  rotateY(-PI - map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, -PI/4, PI/4));
  rotateZ(map(sin(frameCount/(float)gifCount * TWO_PI), -1, 1, -PI/2, PI/2));

  stroke(keyColor);
  strokeWeight(.5);
  line(0, 0, -3000, 0, 0, 3000);
  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = (cos(u)-cos(2 * u)) * cos(v)/4;
      float y = (sin(u)-sin(2 * u)) * sin(v)/4;
      float z = cos(u);
      x *= scale;
      y *= scale;
      z *= scale;
      pushMatrix();
      translate(x, y, z);
      noStroke();
      fill(baseColor);
      sphere(5);
      popMatrix();
    }
  }
  gifDraw();
}

void gifInit() {
  if (isRecord == false) {
    return;
  }
  gifExport = new GifMaker(this, getClass().getSimpleName() +".gif"); // ファイル名のGIFアニメーションを作成
  gifExport.setRepeat(0); // エンドレス再生
  gifExport.setQuality(8); // クオリティ(デフォルト10)
  gifExport.setDelay(33); // アニメーションの間隔を30ms(33fps)に
}

void gifDraw() {
  if (isRecord == false) {
    return;
  }
  //GIFアニメーションの保存
  if (frameCount <= gifCount) {
    gifExport.addFrame(); // フレームを追加
  } else {
    gifExport.finish(); // 終了してファイル保存
    exit();
  }
}
