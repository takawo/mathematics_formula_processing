/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/781281699275472896
// x=(cos(2u)*cos(v))^3
// y=(sin(u)*cos(v))^3
// z=sin(v)^3
// -pi/2≦u≦pi/2
// -pi≦v≦pi

import gifAnimation.*;

// 変数
GifMaker gifExport;
int gifCount = 90;
boolean isRecord = true;

// 変数uの最小値
float minU = -PI/2;
// 変数uの最大値
float maxU = PI/2;
// 変数vの最小値
float minV = -PI;
// 変数vの最大値
float maxV = PI;
// 分割数
float div = 100;

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

  bgColor = color(351, 80, 92);
  keyColor = color(145, 8, 93);
  baseColor = color(226, 26, 57);

  gifInit();
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(bgColor);
  lights();
  ambientLight(0, 0, 20);
  translate(width/2, height/2, -500);
  rotateX(PI/4 * cos(frameCount/(float)gifCount * TWO_PI));
  rotateY(-PI/8 * sin(frameCount/(float)gifCount * TWO_PI));
  rotateZ(frameCount*(TWO_PI/(float)gifCount));

  stroke(keyColor);
  strokeWeight(.5);
  line(-3000, 0, 0, 3000, 0, 0);
  noFill();
  fill(baseColor);
  noStroke();

  for (float v = minV; v <= maxV; v += stepV) {
    for (float u = minU; u <= maxU; u += stepU) {
      float x = pow((cos(2 * u) * cos(v)), 3) * scale;
      float y = pow((sin(u) * pow(cos(v), 3)), 3) * scale;
      float z = (pow(sin(v), 3)) * scale;
      pushMatrix();
      translate(x, y, z);
      sphere(10);
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
