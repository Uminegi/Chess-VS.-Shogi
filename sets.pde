void originalSet() {//オリジナルモードのセットアップ
  rules[0] = true;//将棋の持ち駒
  rules[1] = false;//チェスの持ち駒
  rules[2] = true;//将棋の成り
  rules[3] = true;//チェスの成り
  rules[4] = false;//将棋のキャスリング
  rules[5] = true;//チェスのキャスリング(実装しなかったら消す)
}

void balanceSet() {//バランスモードのセットアップ
  rules[0] = true;//将棋の持ち駒
  rules[1] = true;//チェスの持ち駒
  rules[2] = true;//将棋の成り
  rules[3] = false;//チェスの成り
  rules[4] = true;//将棋のキャスリング
  rules[5] = true;//チェスのキャスリング
}
void customSet() {//カスタムモードのセットアップ
  switch(option1_num) {
  case 0:
    rules[0] = false;
    rules[1] = false;
    break;

  case 1:
    rules[0] = true;
    rules[1] = true;
    break;

  case 2:
    rules[0] = true;
    rules[1] = false;
    break;

  case 3:
    rules[0] = false;
    rules[1] = true;
    break;
  }
  switch(option2_num) {
  case 0:
    rules[2] = false;
    rules[3] = false;
    break;

  case 1:
    rules[2] = true;
    rules[3] = true;
    break;

  case 2:
    rules[2] = true;
    rules[3] = false;
    break;

  case 3:
    rules[2] = false;
    rules[3] = true;
    break;
  }
  switch(option3_num) {
  case 0:
    rules[4] = false;
    rules[5] = false;
    break;

  case 1:
    rules[4] = true;
    rules[5] = true;
    break;

  case 2:
    rules[4] = true;
    rules[5] = false;
    break;

  case 3:
    rules[4] = false;
    rules[5] = true;
    break;
  }
}
