/*  mathematics formula */
//  inspired https://twitter.com/ru_sack/status/775098568298278912
//
//  x=(1+sin(1*PI*u)sin(1*PI*v))sin(4*PI*v)
//  y=(1+sin(1*PI*u)sin(1*PI*v))cos(4*PI*v)
//  z=cos(1*PI*u)sin(1*PI*v)+4v-2
//  0≦u≦1
//  0≦v≦1

// setup関数 : 初回1度だけ実行される
void setup() {
  size(960, 540, P3D); // ウィンドウサイズを960px,540pxに
  colorMode(HSB, 360, 100, 100, 100); // HSBでの色指定にする
  smooth(); // 描画を滑らかに
  sphereDetail(4);
}

// draw関数 : setup関数実行後繰り返し実行される
void draw() {
  background(50, 53, 100);
  translate(width/2, height/2, -500);
  rotateX(PI/2);
  rotateY(PI/8+frameCount*0.0001);
  rotateZ(frameCount*0.05);
  lights();
  stroke(20, 100, 100, 50);
  line(0, 0, -1000, 0, 0, 1000);

  fill(143, 50, 80);
  noStroke();
  float n = 200;
  for (float v = 0; v <= 1; v += .003) {
    for (float u = 0; u <= 1; u += .05) {
      float x = ((1+sin(1*PI*u)*sin(1*PI*v))*sin(4*PI*v))*n;
      float y = ((1+sin(1*PI*u)*sin(1*PI*v))*cos(4*PI*v))*n;
      float z = (cos(1*PI*u)*sin(1*PI*v)+4*v-2)*n;
      pushMatrix();
      translate(x, y, z);
      sphere(3);
      popMatrix();
    }
  }
}
