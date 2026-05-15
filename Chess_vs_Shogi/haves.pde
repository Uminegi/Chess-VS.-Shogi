boolean normalCanPut[][] = new boolean[9][9];
boolean upKeimaCanPut[][] = new boolean[9][9];
boolean downKeimaCanPut[][] = new boolean[9][9];
boolean upKyosyaCanPut[][] = new boolean[9][9];
boolean downKyosyaCanPut[][] = new boolean[9][9];
boolean upHuhyoCanPut[][] = new boolean[9][9];
boolean downHuhyoCanPut[][] = new boolean[9][9];
int haveOption; //選んだ持ち駒の種類が入る

void initHave() {
  haveChoose = false;
  haveChessChoose = false;
  for (int n = 0; n < upHave.length; n++) {
    upHave[n] = 0;
    downHave[n] = 0;
  }
  for (int n = 0; n < upHaveChess.length; n++) {
    upHaveChess[n] = 0;
    downHaveChess[n] = 0;
  }
  for (int n = 0; n < normalCanPut.length; n++) {
    for (int j = 0; j < normalCanPut[n].length; j++) {
      normalCanPut[n][j] = false;
      upKeimaCanPut[n][j] = false;
      downKeimaCanPut[n][j] = false;
      upKyosyaCanPut[n][j] = false;
      downKyosyaCanPut [n][j] = false;
      upHuhyoCanPut [n][j] = false;
      downHuhyoCanPut [n][j] = false;
    }
  }
}
void haveView() {
  //持ち駒
  //将棋の下側
  fill(#aaaa00);
  rect(stage_x + box_size*10.25, stage_y + box_size*5+40, 200, 220);
  for (int n = 0; n < 4; n++) {
    fill(255);
    image(have_images[n], stage_x + box_size*10.5, stage_y + box_size*6+n*40, 40, 40);
    fill(0);
    if (downHave[n] == 0) {
      fill(255, 0, 0);
    }
    text("×"+downHave[n], stage_x + box_size*10.5+40, stage_y + box_size*6.5+n*40);
  }
  for (int n = 0; n < 3; n++) {
    fill(255);
    image(have_images[n+4], stage_x + box_size*12, stage_y + box_size*6+n*40, 40, 40);
    fill(0);
    if (downHave[n+4] == 0) {
      fill(255, 0, 0);
    }
    text("×"+downHave[n+4], stage_x + box_size*12+40, stage_y + box_size*6.5+n*40);
  }
  /*上側*/
  fill(#aaaa00);
  rect(stage_x + box_size*(-4.25), stage_y, 200, 220);
  for (int n = 0; n < 4; n++) {
    fill(255);
    image(have_images[n], stage_x + box_size*(-4), stage_y +(1+n)*40, 40, 40);
    fill(0);
    if (upHave[n] == 0) {
      fill(255, 0, 0);
    }
    text("×"+upHave[n], stage_x + box_size*(-4)+40, stage_y +(1+n)*40+box_size*0.5);
  }
  for (int n = 0; n < 3; n++) {
    fill(255);
    image(have_images[n+4], stage_x + box_size*(-2.5), stage_y +40+n*40, 40, 40);
    fill(0);
    if (upHave[n+4] == 0) {
      fill(255, 0, 0);
    }
    text("×"+upHave[n+4], stage_x + box_size*(-2.5)+40, stage_y +(1+n)*40+box_size*0.5);
  }
}
void haveChessView() {
  //下側
  fill(#aaaa00);
  rect(stage_x + box_size*10.25, stage_y + box_size*5-140, 200, 170);
  for (int n = 0; n < 3; n++) {
    fill(255);
    image(down_have_chess[n], stage_x + box_size*10.5, stage_y + box_size*6+n*40 - 180, 38, 38);
    fill(0);
    if (downHaveChess[n] == 0) {
      fill(255, 0, 0);
    }
    text("×"+downHaveChess[n], stage_x + box_size*10.5+40, stage_y + box_size*6.5+n*40 - 180);
  }
  for (int n = 0; n < 2; n++) {
    fill(255);
    image(down_have_chess[n+3], stage_x + box_size*12, stage_y + box_size*6+n*40 - 180, 38, 38);
    fill(0);
    if (downHaveChess[n+3] == 0) {
      fill(255, 0, 0);
    }
    text("×"+downHaveChess[n+3], stage_x + box_size*12+40, stage_y + box_size*6.5+n*40 - 180);
  }
  /*上側*/
  fill(#aaaa00);
  rect(stage_x + box_size*(-4.25), stage_y + 230, 200, 170);
  for (int n = 0; n < 3; n++) {
    fill(255);
    image(up_have_chess[n], stage_x + box_size*(-4), stage_y +(1+n)*40 + 220, 38, 38);
    fill(0);
    if (upHaveChess[n] == 0) {
      fill(255, 0, 0);
    }
    text("×"+upHaveChess[n], stage_x + box_size*(-4)+40, stage_y +(1+n)*40+box_size*0.5 + 220);
  }
  for (int n = 0; n < 2; n++) {
    fill(255);
    image(up_have_chess[n+3], stage_x + box_size*(-2.5), stage_y +40+n*40 + 220, 38, 38);
    fill(0);
    if (upHaveChess[n+3] == 0) {
      fill(255, 0, 0);
    }
    text("×"+upHaveChess[n+3], stage_x + box_size*(-2.5)+40, stage_y +(1+n)*40+box_size*0.5 + 220);
  }
}
int[]  have(int[] have_num, int soeji2) {//持ち駒を保存する処理
  if (soeji2 != 0) {
    if ( soeji2 >= 1 && soeji2 <= 7 ) {
      soeji2 = soeji2 - 1;
    } else if (soeji2 >= 8 && soeji2 <= 11) {
      soeji2 = soeji2 -8;
    } else {
      soeji2 = soeji2 - 7;
    }
    have_num[soeji2]++;
  }
  return have_num;
}

int [] chessHave(int[] have_num, int soeji2) {
  if (soeji2 != 0) {
    soeji2 -= 1;
    have_num[soeji2]++;
  }
  return have_num;
}

int viewHaveCheck() {
  float checkX, checkY;

  checkX = stage_x + box_size*10.5;//下側の左
  checkY = stage_y + box_size*6;
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY + 160) {  
    return 1;
  }

  checkX = checkX + box_size*1.5;//下側の右
  //checkYは変わらない
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY + 120) {
    return 2;
  }

  checkX = stage_x + box_size*(-4);//上側の左
  checkY = stage_y + 40;
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY + 160) {
    return 3;
  }

  checkX = checkX + box_size*1.5;//上側の右
  //checkYは変わらない
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY + 120) {
    return 4;
  }
  return 0;//範囲内にマウスがなかったら0が返される
}

int viewHaveChessCheck() {
  float checkX, checkY;

  checkX = stage_x + box_size*10.5;//下側の左
  checkY = stage_y + box_size*6 - 180;
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY+120) {  
    return 5;
  }

  checkX = checkX + box_size*1.5;//下側の右
  //checkYは変わらない
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY+80) {

    return 6;
  }

  checkX = stage_x + box_size*(-4);//上側の左
  checkY = stage_y + 260;
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY+120) {
    return 7;
  }

  checkX = checkX + box_size*1.5;//上側の右
  //checkYは変わらない
  if (mouseX >= checkX && mouseX<= checkX+40 && mouseY >= checkY && mouseY <= checkY+80) {
    return 8;
  }
  return 0;//範囲内にマウスがなかったら0が返される
}
void viewHaveRect(int num) {
  float checkX, checkY;
  switch(num) {
  case 1://下側の左
    checkX = stage_x + box_size*10.5;//下側の左
    checkY = stage_y + box_size*6;
    break;

  case 2://下側の右
    checkX = stage_x + box_size*12;//下側の右
    checkY = stage_y + box_size*6;
    break;

  case 3://上側の左
    checkX = stage_x + box_size*(-4);//上側の左
    checkY = stage_y + 40;
    break;

  case 4://上側の右
    checkX = stage_x + box_size*(-2.5);//上側の右
    checkY = stage_y + 40;
    break;

  default://ここを通ることは絶対にない
    checkX =0;
    checkY = 0;
    break;
  }
  if (num == 1 || num == 3) {//上でも下で左側の時の処理
    for (int n = 0; n < 4; n++) {
      int j = 3 - n;
      if (mouseY >= checkY + j*40) {
        fill(0, 0, 255, 64);
        if (!(haveChoose)) {
          rect(checkX, checkY + j*40, 40, 40);
        }
        haveOption = j;//現在マウスがいる位置の駒の種類を保存
        break;
      }
    }
  } else {//右側の時の処理
    for (int n = 0; n < 3; n++) {
      int j = 2 - n;
      if (mouseY >= checkY + j*40) {
        fill(0, 0, 255, 64);
        if (!(haveChoose)) {
          rect(checkX, checkY + j*40, 40, 40);
        }
        haveOption = j + 4;//現在マウスがいる位置の駒の種類を保存
        break;
      }
    }
  }
}
void viewHaveChessRect(int num) {

  float checkX, checkY;
  switch(num) {
  case 5://下側の左
    checkX = stage_x + box_size*10.5;//下側の左
    checkY = stage_y + box_size*6 - 180;
    break;

  case 6://下側の右
    checkX = stage_x + box_size*12 ;//下側の右
    checkY = stage_y + box_size*6 - 180;
    break;

  case 7://上側の左
    checkX = stage_x + box_size*(-4);//上側の左
    checkY = stage_y + 40+ 220;
    break;

  case 8://上側の右
    checkX = stage_x + box_size*(-2.5);//上側の右
    checkY = stage_y + 40+ 220;
    break;

  default://ここを通ることは絶対にない
    checkX =0;
    checkY = 0;
    break;
  }
  if (num == 5 || num == 7) {//上でも下で左側の時の処理
    for (int n = 1; n < 4; n++) {
      int j = 3 - n;
      if (mouseY >= checkY + j*40) {
        fill(0, 0, 255, 64);
        if (!(haveChessChoose)) {
          rect(checkX, checkY + j*40, 40, 40);
        }
        haveOption = j;//現在マウスがいる位置の駒の種類を保存
        break;
      }
    }
  } else {//右側の時の処理
    for (int n = 1; n < 3; n++) {
      int j = 2 - n;
      if (mouseY >= checkY + j*40) {
        fill(0, 0, 255, 64);
        if (!(haveChessChoose)) {
          rect(checkX, checkY + j*40, 40, 40);
        }
        haveOption = j + 3;//現在マウスがいる位置の駒の種類を保存
        break;
      }
    }
  }
}

void haveCheck() {
  for (int n = 0; n < normalCanPut.length; n++) {
    for (int j = 0; j < normalCanPut[n].length; j++) {
      normalCanPut[n][j] = false;
      upKeimaCanPut[n][j] = false;
      downKeimaCanPut[n][j] = false;
      upKyosyaCanPut[n][j] = false;
      downKyosyaCanPut [n][j] = false;
      upHuhyoCanPut [n][j] = false;
      downHuhyoCanPut [n][j] = false;
    }
  }
  for (int n = 0; n < normalCanPut.length; n++) {
    for (int j = 0; j < normalCanPut[n].length; j++) {
      if (stage_piece_num[n][j] == 0) {
        normalCanPut[n][j] = true;
        if (n>=1) {//下側の香車と歩兵
          downKyosyaCanPut[n][j] = true;
          boolean huhyoCheck;
          huhyoCheck = true;
          for (int i = 0; i < 9; i++) {
            if (stage_piece_num[i][j] == 101) {
              huhyoCheck = false;
              break;
            }
          }
          downHuhyoCanPut[n][j] = huhyoCheck;
        }
        if (n>=2) {//下側の桂馬
          downKeimaCanPut[n][j] = true;
        }
        if (n<=7) {//上側の香車と歩兵
          upKyosyaCanPut[n][j] = true;
          boolean huhyoCheck;
          huhyoCheck = true;
          for (int i = 0; i < 9; i++) {
            if (stage_piece_num[i][j] == 201) {
              huhyoCheck = false;
              break;
            }
          }
          upHuhyoCanPut[n][j] = huhyoCheck;
        }
        if (n<=6) {//上側の桂馬
          upKeimaCanPut[n][j] = true;
        }
      }
    }
  }
}


boolean canHavePutCheck(int y, int x) {//置くことができる駒にマウスがあったら色を塗りtrueを返す
  boolean canPut;

  canPut = false;
  if (mouseX >= stage_x && mouseY >= stage_y) {
    if (x >= 0 && x <= 8 && y >= 0 && y <= 8) {
      if (canPuts[int(y)][int(x)]) {
        fill(0, 255, 0, 80);
        rect(stage_x + box_size*x, stage_y + box_size*y, box_size, box_size);
        canPut = true;
      }
    }
  }

  return canPut;
}

void havePlace(int y, int x, int ex_option) {
  backSave();//一手戻るために記録をしている
  int koma;
  int option;
  option = ex_option + 1;
  koma = turn_num*100 + option;
  stage_piece_num[y][x] = koma;
  haveChoose = false;
  canHavePut = false;
  if (turn_num == 1) {
    downHave[ex_option]--;
  } else {
    upHave[ex_option]--;
  }
  turnChange();
}

void haveChessPlace(int y, int x, int ex_option) {
  backSave();//一手戻るために記録をしている
  int koma;
  int option;
  option = ex_option + 11;
  koma = turn_num*100 + option;
  stage_piece_num[y][x] = koma;
  haveChessChoose = false;
  canHaveChessPut = false;
  if (turn_num == 1) {
    downHaveChess[ex_option]--;
  } else {
    upHaveChess[ex_option]--;
  }
  turnChange();
}
