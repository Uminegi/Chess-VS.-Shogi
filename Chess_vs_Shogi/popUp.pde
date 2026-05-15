float[][] anyRectInformations;//任意の成りの座標などの情報が入る
float[] forcedRectInformations;//強制の成りの座標などの情報が入る
float[][] pawnRectInformations;//ポーンのプロモーションの座標などの情報が入る
float[][] resignRectInformations;//降参するボタンなどの座標の情報が入る
float[][] backRectInformations;//一手戻るボタンの座標の情報が入る
int proPiece[];//なる前の駒の番号が入る
int popCheck;

void initPopUp() {
  anyRectInformations = new float[2][4];
  forcedRectInformations = new float[4];
  pawnRectInformations = new float[4][4];
  resignRectInformations = new float[2][4];
  backRectInformations = new float[2][4];
  popCheck = 0;//
  proPiece = new int[3];
}

void anyPopUp() {//任意の成りのポップアップの処理。pop==1
  popCheck = 0;//1が入ると成る、2が　入ると成らないを表す
  viewAnyPopUp();//ポップアップを表示する
  fill(#ffff00, 150);
  for ( int n = 0; n < anyRectInformations.length; n++) {
    float x, y, s_x, s_y;
    x = anyRectInformations[n][0];
    y = anyRectInformations[n][1];
    s_x = anyRectInformations[n][2];
    s_y = anyRectInformations[n][3];
    if (mouseX >= x && mouseX<= x+s_x && mouseY >= y&& mouseY <= y+s_y) {
      popCheck = n+1;
      rect(x, y, s_x, s_y);
      break;
    }
  }
}

void forcedPopUp() {//強制の成りのポップアップの処理
  viewForcedPopUp();
  fill(#ffff00, 150);
  float x, y, s_x, s_y;
  x = forcedRectInformations[0];
  y = forcedRectInformations[1];
  s_x = forcedRectInformations[2];
  s_y = forcedRectInformations[3];
  if (mouseX >= x && mouseX<= x+s_x && mouseY >= y&& mouseY <= y+s_y) {
    popCheck = 1;
    rect(x, y, s_x, s_y);
  }
}

void pawnPopUp() {//ポーンのプロモーション(成り)のポップアップ
  viewPawnPopUp();
  fill(#ffff00, 150);
  for ( int n = 0; n < pawnRectInformations.length; n++) {
    float x, y, s_x, s_y;
    x = pawnRectInformations[n][0];
    y = pawnRectInformations[n][1];
    s_x = pawnRectInformations[n][2];
    s_y = pawnRectInformations[n][3];
    if (mouseX >= x && mouseX<= x+s_x && mouseY >= y&& mouseY <= y+s_y) {
      popCheck = n+1;
      rect(x, y, s_x, s_y);
      break;
    }
  }
}
void resignPopUp() {//降参するときに出てくるポップアップ:pop = 4
  popCheck = 0;//1が入ると成る、2が入ると成らないを表す
  viewResignPopUp();//ポップアップを表示する
  fill(#ffff00, 150);
  for ( int n = 0; n < anyRectInformations.length; n++) {
    float x, y, s_x, s_y;
    x = resignRectInformations[n][0];
    y = resignRectInformations[n][1];
    s_x = resignRectInformations[n][2];
    s_y = resignRectInformations[n][3];
    if (mouseX >= x && mouseX<= x+s_x && mouseY >= y&& mouseY <= y+s_y) {
      popCheck = n+1;
      rect(x, y, s_x, s_y);
      break;
    }
  }
}
void backPopUp() {//一手戻るためのポップアップ
  popCheck = 0;//1が入ると成る、2が入ると成らないを表す
  viewBackPopUp();//ポップアップを表示する
  fill(#ffff00, 150);
  for ( int n = 0; n < anyRectInformations.length; n++) {
    float x, y, s_x, s_y;
    x = backRectInformations[n][0];
    y = backRectInformations[n][1];
    s_x = backRectInformations[n][2];
    s_y = backRectInformations[n][3];
    if (mouseX >= x && mouseX<= x+s_x && mouseY >= y&& mouseY <= y+s_y) {
      popCheck = n+1;
      rect(x, y, s_x, s_y);
      break;
    }
  }
}
void viewAnyPopUp() {
  fill(#f6e5cc);
  float rect_x, rect_y, rect_x_size, rect_y_size;
  rect_x = stage_x + box_size;
  rect_y = stage_y + box_size;
  rect_x_size = stage_size/1.5 + box_size;
  rect_y_size = rect_x_size * 0.8;

  rect(rect_x, rect_y, rect_x_size, rect_y_size);
  int t_s;
  t_s = 50;
  textSize(t_s);
  fill(0);
  text("成りますか？", (rect_x_size/2) + rect_x - t_s * 3, rect_y + 80);
  t_s = 30;
  textSize(t_s);
  int rect_color[] = {125, 125, 125};
  int text_color[] = {0, 0, 0};
  textRect(rect_x + 100, (rect_y+rect_y_size)/2 + 130, "成る", t_s, rect_color, text_color);
  anyRectInformations[0][0] = rect_x + 100+5 ;//x座標
  anyRectInformations[0][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  anyRectInformations[0][2] = 2*t_s + 10;//横幅
  anyRectInformations[0][3] = t_s + 10;//縦幅

  textRect(rect_x + 250, (rect_y+rect_y_size)/2 + 130, "成らない", t_s, rect_color, text_color);
  anyRectInformations[1][0] = rect_x + 250+5 ;//x座標
  anyRectInformations[1][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  anyRectInformations[1][2] = 4*t_s + 10;//横幅
  anyRectInformations[1][3] = t_s + 10;//縦幅
}

void viewForcedPopUp() {
  fill(#f6e5cc);
  float rect_x, rect_y, rect_x_size, rect_y_size;
  rect_x = stage_x + box_size;
  rect_y = stage_y + box_size;
  rect_x_size = stage_size/1.5 + box_size;
  rect_y_size = rect_x_size * 0.8;

  rect(rect_x, rect_y, rect_x_size, rect_y_size);
  int t_s;
  t_s = 50;
  textSize(t_s);
  fill(0);
  text("成りました", (rect_x_size/2) + rect_x - t_s * 2.5, rect_y + 80);
  t_s = 30;
  textSize(t_s);
  int rect_color[] = {125, 125, 125};
  int text_color[] = {0, 0, 0};
  textRect(rect_x + (rect_x_size)/2 - 40, (rect_y+rect_y_size)/2 + 130, "OK", t_s, rect_color, text_color);
  forcedRectInformations[0] =rect_x + (rect_x_size)/2 - 40+5 ;//x座標
  forcedRectInformations[1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  forcedRectInformations[2] = 2*t_s + 10;//横幅
  forcedRectInformations[3] = t_s + 10;//縦幅
}

void viewPawnPopUp() {
  fill(#f6e5cc);
  float rect_x, rect_y, rect_x_size, rect_y_size;
  rect_x = stage_x + box_size;
  rect_y = stage_y + box_size;
  rect_x_size = stage_size/1.5 + box_size;
  rect_y_size = rect_x_size * 0.8;

  rect(rect_x, rect_y, rect_x_size, rect_y_size);
  int t_s;
  t_s = 50;
  textSize(t_s);
  fill(0);
  text("どれになりますか？", (rect_x_size/2) + rect_x - t_s * 4.5, rect_y + 80);
  t_s = 30;
  textSize(t_s);
  int rect_color[] = {159, 159, 152};
  int text_color[] = {0, 0, 0};
  textRect(rect_x + 50, (rect_y+rect_y_size)/2 + 130, "クイーン", t_s, rect_color, text_color);
  pawnRectInformations[0][0] = rect_x + 50+5 ;//x座標
  pawnRectInformations[0][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  pawnRectInformations[0][2] = 4*t_s + 10;//横幅
  pawnRectInformations[0][3] = t_s + 10;//縦幅

  textRect(rect_x + 50, (rect_y+rect_y_size)/2 + 180, "ビショップ", t_s, rect_color, text_color);
  pawnRectInformations[1][0] = rect_x + 50+5 ;//x座標
  pawnRectInformations[1][1] = (rect_y+rect_y_size)/2 + 180 + 5;//y座標
  pawnRectInformations[1][2] = 5*t_s + 10;//横幅
  pawnRectInformations[1][3] = t_s + 10;//縦幅

  textRect(rect_x + 300, (rect_y+rect_y_size)/2 + 130, "ルーク", t_s, rect_color, text_color);
  pawnRectInformations[2][0] = rect_x + 300+5 ;//x座標
  pawnRectInformations[2][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  pawnRectInformations[2][2] = 3*t_s + 10;//横幅
  pawnRectInformations[2][3] = t_s + 10;//縦幅

  textRect(rect_x + 300, (rect_y+rect_y_size)/2 + 180, "ナイト", t_s, rect_color, text_color);
  pawnRectInformations[3][0] = rect_x + 300+5 ;//x座標
  pawnRectInformations[3][1] = (rect_y+rect_y_size)/2 + 180 + 5;//y座標
  pawnRectInformations[3][2] = 3*t_s + 10;//横幅
  pawnRectInformations[3][3] = t_s + 10;//縦幅
}
void viewResignPopUp() {
  fill(#f6e5cc);
  float rect_x, rect_y, rect_x_size, rect_y_size;
  rect_x = stage_x + box_size;
  rect_y = stage_y + box_size;
  rect_x_size = stage_size/1.5 + box_size;
  rect_y_size = rect_x_size * 0.8;

  rect(rect_x, rect_y, rect_x_size, rect_y_size);
  int t_s;
  t_s = 50;
  textSize(t_s);
  fill(0);
  text("降参しますか？", (rect_x_size/2) + rect_x - t_s * 3.5, rect_y + 80);
  t_s = 30;
  textSize(t_s);
  int rect_color[] = {125, 125, 125};
  int text_color[] = {0, 0, 0};
  textRect(rect_x + 100, (rect_y+rect_y_size)/2 + 130, "降参する", t_s, rect_color, text_color);
  resignRectInformations[0][0] = rect_x + 100+5 ;//x座標
  resignRectInformations[0][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  resignRectInformations[0][2] = 4*t_s + 10;//横幅
  resignRectInformations[0][3] = t_s + 10;//縦幅

  textRect(rect_x + 250, (rect_y+rect_y_size)/2 + 130, "降参しない", t_s, rect_color, text_color);
  resignRectInformations[1][0] = rect_x + 250+5 ;//x座標
  resignRectInformations[1][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  resignRectInformations[1][2] = 5*t_s + 10;//横幅
  resignRectInformations[1][3] = t_s + 10;//縦幅
}
void viewBackPopUp() {
  fill(#f6e5cc);
  float rect_x, rect_y, rect_x_size, rect_y_size;
  rect_x = stage_x + box_size;
  rect_y = stage_y + box_size;
  rect_x_size = stage_size/1.5 + box_size;
  rect_y_size = rect_x_size * 0.8;

  rect(rect_x, rect_y, rect_x_size, rect_y_size);
  int t_s;
  t_s = 50;
  textSize(t_s);
  fill(0);
  text("一手戻りますか？", (rect_x_size/2) + rect_x - t_s * 3.5, rect_y + 80);
  t_s = 30;
  textSize(t_s);
  int rect_color[] = {125, 125, 125};
  int text_color[] = {0, 0, 0};
  textRect(rect_x + 100, (rect_y+rect_y_size)/2 + 130, "一手戻る", t_s, rect_color, text_color);
  backRectInformations[0][0] = rect_x + 100+5 ;//x座標
  backRectInformations[0][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  backRectInformations[0][2] = 4*t_s + 10;//横幅
  backRectInformations[0][3] = t_s + 10;//縦幅

  textRect(rect_x + 250, (rect_y+rect_y_size)/2 + 130, "戻らない", t_s, rect_color, text_color);
  backRectInformations[1][0] = rect_x + 250+5 ;//x座標
  backRectInformations[1][1] = (rect_y+rect_y_size)/2 + 130 + 5;//y座標
  backRectInformations[1][2] = 4*t_s + 10;//横幅
  backRectInformations[1][3] = t_s + 10;//縦幅
}
int popCheck(int piece_num, int y, int x, int ex_y ) {//成れるかどうかのチェックを行う
  int pop;
  pop = 0;//1が任意、2が強制、3がポーン。1つがtrueのときは他をfalseにする
  int[] soeji;
  soeji = bunnkai(stage_piece_num[y][x]);
  int soeji1, soeji2, soeji3;
  soeji1 = soeji[0];
  soeji2 = soeji[1];
  soeji3 = soeji[2];
  proPiece[0] = piece_num;//動く先の番号が入る
  proPiece[1] = y;
  proPiece[2] = x;

  /*入れ子構造になりまくって見にくくなったのでelseを使わずに分けました*/
  if (soeji1 == 1) {//下側のとき
    if (soeji2 == 0 && rules[2]) {//将棋のとき

      if (soeji3 == 4 || soeji3 == 6 || soeji3 == 7) {//銀、角、飛車のどれかだったらここ
        if ( y <= 2 || ex_y <= 2) {//うえ3列から上だったら
          pop = 1;
        }
      } else if (soeji3 == 3) {//桂馬だったら
        if (y <= 1) {//強制の方
          pop = 2;
        } else if ( y == 2) {//任意の方
          pop = 1;
        }
      } else if (soeji3 == 1 || soeji3 == 2) {//香車と歩兵
        if (y == 0) {//強制の方
          pop = 2;
        } else if (y <= 2) {//任意の方
          pop = 1;
        }
      }
    } else if (soeji3 == 1 && y == 0 && rules[3]) {//チェスのとき(ポーンのみ)

      pop = 3;
    }
  }

  if (soeji1 == 2) {//上側のとき
    if (soeji2 == 0 && rules[2]) {//将棋のとき

      if (soeji3 == 4 || soeji3 == 6 || soeji3 == 7) {//銀、角、飛車のどれかだったらここ
        if ( y >= 6 || ex_y >= 6) {//下3列から下だったら,敵陣地から出たときにも成ることができる
          pop = 1;
        }
      } else if (soeji3 == 3) {//桂馬だったら
        if (y >= 7) {//強制の方
          pop = 2;
        } else if ( y == 6) {//任意の方
          pop = 1;
        }
      } else if (soeji3 == 1 || soeji3 == 2) {//香車と歩兵
        if (y == 8) {//強制の方
          pop = 2;
        } else if (y >= 6) {//任意の方
          pop = 1;
        }
      }
    } else if (soeji3 == 1 && y == 8 && rules[3]) {//チェスのとき(ポーンのみ)

      pop = 3;
    }
  }
  return pop;
}
