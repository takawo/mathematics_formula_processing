/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/775457941969248256
//
//  x=u*cos(v)
//  y=u*sin(v)
//  z=v
//  -2≦u≦2
//  -1pi≦v≦1pi

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(4);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(194, 97, 50);
  translate(width/2, height/2, -500);
  rotateX(-PI/2);
  rotateY(PI/8);
  rotateZ(frameCount*0.01);
  lights();
  stroke(54, 25, 65, 50);
  line(0, 0, -1000, 0, 0, 1000);

  fill(55, 15, 94);
  noStroke();
  float n = 135;
  for (float v = -PI; v <= PI; v += PI/100) {
    for (float u = -2; u <= 2; u += 0.10) {
      float x = (u*cos(v))*n;
      float y = (u*sin(v))*n;
      float z = (v)*n;
      pushMatrix();
      translate(x, y, z);
      sphere(10);
      popMatrix();
    }
  }
}