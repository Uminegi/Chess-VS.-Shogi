PImage[] syogi_images = new PImage[14];//通常の将棋の駒
PImage[] reverse_images = new PImage[14];//上側で表示される将棋(王が上に来ることはないので[0]番は使われない)
PImage[] chess_images = new PImage[6];//通常のチェスの駒
PImage[] reverse_chess = new PImage[6];//下側のチェスの駒(キングが下に来ることはないので[0]番目は使われない)
PImage[] have_images = new PImage[7];//将棋の持ち駒の画像
PImage[] up_have_chess = new PImage[5];//上側のチェスの持ち駒の画像
PImage[] down_have_chess = new PImage[5];//チェスの持ち駒の画像
void initImage() {

  syogi_images[0]= loadImage("data/image/将棋/王.png");
  syogi_images[1]= loadImage("data/image/将棋/歩兵.png");
  syogi_images[2]= loadImage("data/image/将棋/香車.png");
  syogi_images[3]= loadImage("data/image/将棋/桂馬.png");
  syogi_images[4]= loadImage("data/image/将棋/銀将.png");
  syogi_images[5]= loadImage("data/image/将棋/金将.png");
  syogi_images[6]= loadImage("data/image/将棋/角行.png");
  syogi_images[7]= loadImage("data/image/将棋/飛車.png");
  syogi_images[8]= loadImage("data/image/将棋/と金.png");
  syogi_images[9]= loadImage("data/image/将棋/成り香.png");
  syogi_images[10]= loadImage("data/image/将棋/成り桂.png");
  syogi_images[11]= loadImage("data/image/将棋/成り銀.png");
  syogi_images[12]= loadImage("data/image/将棋/竜馬.png");
  syogi_images[13]= loadImage("data/image/将棋/龍王.png");
  for (int n = 0; n < syogi_images.length; n++) {
    syogi_images[n].resize(60, 60);
  }
  reverse_images[1] = loadImage("data/image/反転/反転歩兵.png");
  reverse_images[2] = loadImage("data/image/反転/反転香車.png");
  reverse_images[3] = loadImage("data/image/反転/反転桂馬.png");
  reverse_images[4] = loadImage("data/image/反転/反転銀将.png");
  reverse_images[5] = loadImage("data/image/反転/反転金将.png");
  reverse_images[6] = loadImage("data/image/反転/反転角行.png");
  reverse_images[7] = loadImage("data/image/反転/反転飛車.png");
  reverse_images[8] = loadImage("data/image/反転/反転と金.png");
  reverse_images[9] = loadImage("data/image/反転/反転成り香.png");
  reverse_images[10] = loadImage("data/image/反転/反転成り桂.png");
  reverse_images[11] = loadImage("data/image/反転/反転成り銀.png");
  reverse_images[12] = loadImage("data/image/反転/反転竜馬.png");
  reverse_images[13] = loadImage("data/image/反転/反転龍王.png");
  for (int n = 1; n < syogi_images.length; n++) {
    reverse_images[n].resize(60, 60);
  }


  chess_images[0] = loadImage("data/image/チェス/キング.png");
  chess_images[1] = loadImage("data/image/チェス/ポーン.png");
  chess_images[2] = loadImage("data/image/チェス/ルーク.png");
  chess_images[3] = loadImage("data/image/チェス/ナイト.png");
  chess_images[4] = loadImage("data/image/チェス/ビショップ.png");
  chess_images[5] = loadImage("data/image/チェス/クイーン.png");
  for (int n = 0; n < chess_images.length; n++) {
    chess_images[n].resize(60, 60);//サイズの変更
  }

  reverse_chess[1] = loadImage("data/image/反転チェス/反転ポーン.png");
  reverse_chess[2] = loadImage("data/image/反転チェス/反転ルーク.png");
  reverse_chess[3] = loadImage("data/image/反転チェス/反転ナイト.png");
  reverse_chess[4] = loadImage("data/image/反転チェス/反転ビショップ.png");
  reverse_chess[5] = loadImage("data/image/反転チェス/反転クイーン.png");
  for (int n = 1; n < reverse_chess.length; n++) {
    reverse_chess[n].resize(60, 60);//サイズの変更
  }
  have_images[0]= loadImage("data/image/将棋/歩兵.png");
  have_images[1]= loadImage("data/image/将棋/香車.png");
  have_images[2]= loadImage("data/image/将棋/桂馬.png");
  have_images[3]= loadImage("data/image/将棋/銀将.png");
  have_images[4]= loadImage("data/image/将棋/金将.png");
  have_images[5]= loadImage("data/image/将棋/角行.png");
  have_images[6]= loadImage("data/image/将棋/飛車.png");
  for (int n = 0; n < have_images.length; n++) {
    have_images[n].resize(40, 40);//持ち駒用のサイズ
  }

  up_have_chess[0] = loadImage("data/image/チェス/ポーン.png");
  up_have_chess[1] = loadImage("data/image/チェス/ルーク.png");
  up_have_chess[2] = loadImage("data/image/チェス/ナイト.png");
  up_have_chess[3] = loadImage("data/image/チェス/ビショップ.png");
  up_have_chess[4] = loadImage("data/image/チェス/クイーン.png");
  for (int n = 0; n < up_have_chess.length; n++) {
    up_have_chess[n].resize(40, 40);//持ち駒用のサイズ
  }

  down_have_chess[0] = loadImage("data/image/反転チェス/反転ポーン.png");
  down_have_chess[1] = loadImage("data/image/反転チェス/反転ルーク.png");
  down_have_chess[2] = loadImage("data/image/反転チェス/反転ナイト.png");
  down_have_chess[3] = loadImage("data/image/反転チェス/反転ビショップ.png");
  down_have_chess[4] = loadImage("data/image/反転チェス/反転クイーン.png");
  for (int n = 0; n < down_have_chess.length; n++) {
    down_have_chess[n].resize(40, 40);//サイズの変更
  }
}
