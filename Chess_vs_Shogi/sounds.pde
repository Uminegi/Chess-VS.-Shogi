Minim minim;//音を扱うために必要な変数
AudioPlayer move_piece_sound;
void initSound() {
  minim = new Minim(this);
  move_piece_sound = minim.loadFile("data/sound/指す.mp3");//サウンドファイルのインポーロ
  move_piece_sound.setGain(6);
}
