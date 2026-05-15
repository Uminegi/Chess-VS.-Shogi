/*少し特殊なルールのキャスリングに関係する処理をまとめる*/
boolean cast;
float x_p, y_p, x_s, y_s;
void initCastling() {//キャスリングに使用する変数の初期化
  downCastling = true;//下側のキャスリングを1回にするための変数
  leftSide = false;//下側陣営の左のキャスリングができるか判断する変数
  rightSide = false;//下側陣営の右のキャスリングができるか判断する変数
  cast = false;
  castlingQueen = true;
  castlingKing = true;
  upCastling = true;
  canCastling = false;//上側のキャスリングができるか判断する変数
  canSyogiCastling = false;//上側のキャスリングができるか判断する変数
  castMode = false;//キャスリングモードか判断する変数
  syogiCastMode = false;//下側のキャスリングモードか判断する変数
  for (int n = 0; n < syogiCastlingPieces.length; n++) {//キャスリングに使われる駒が動いたり取られたりしたときにfalseになる
    syogiCastlingPieces[n] = true;
  }
  for (int n = 0; n < castlingPieces.length; n++) {//キャスリングに使われる駒が動いたり取られたりしたときにfalseになる
    castlingPieces[n] = true;
  }
}
void castling() {//上側がキャスリングできるときにキャスリングボタンを表示する関数
  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s;
  t_s = 20;
  textSize(t_s);
  float x, y;
  x = width-consoleSize + 20;
  y = 400;
  textRect(x, y, "キャスリング", t_s, rectColor, textColor);
  x_p = x+5;
  y_p = y+5;
  x_s = 6 * t_s + 10;
  y_s = t_s + 10;
  canCastling = false;
  if (mouseX >= x_p && mouseX <= x_p+x_s && mouseY >= y_p && mouseY <= y_p + y_s && !(castMode) && !(choose) && !(haveChoose)) {
    fill(0, 0, 255, 80);
    rect(x_p, y_p, x_s, y_s);
    canCastling = true;
  }
  if (castMode) {
    fill(0, 255, 0, 80);
    rect(x_p, y_p, x_s, y_s);
  }
}
void syogiCastling() {//下側がキャスリングできるときにボタンを表示する関数
  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s;
  t_s = 20;
  textSize(t_s);
  float x, y;
  x = width-consoleSize + 20;
  y = height/2;
  textRect(x, y, "キャスリング", t_s, rectColor, textColor);
  x_p = x+5;
  y_p = y+5;
  x_s = 6 * t_s + 10;
  y_s = t_s + 10;
  canSyogiCastling = false;
  if (mouseX >= x_p && mouseX <= x_p+x_s && mouseY >= y_p && mouseY <= y_p + y_s && !(castMode) && !(choose) && !(haveChoose) && !(syogiCastMode)) {
    fill(0, 0, 255, 80);
    rect(x_p, y_p, x_s, y_s);
    canSyogiCastling = true;
  }
  if (syogiCastMode) {
    fill(0, 255, 0, 80);
    rect(x_p, y_p, x_s, y_s);
  }
}

boolean castlingCheck(int turn) {//ターンごとにキャスリグができるか判断する関数
  boolean check;
  check = false;
  if (turn == 2) {
    if (castlingPieces[0]) {
      castlingQueen = false;
      boolean can = stage_piece_num[0][1]==0 && stage_piece_num[0][2] == 0  && stage_piece_num[0][3] == 0;
      if (castlingPieces[1] && can ) {//クイーンサイド
        castlingQueen = true;
        for (int n = 0; n < downCanMove.length; n++) {
          for (int j = 0; j < downCanMove[n].length; j++) {
            for ( int i = 0; i < downCanMove[n][j].length; i++) {
              if (downCanMove[n][j][i][0] == 0 && (downCanMove[n][j][i][1] == 2 || downCanMove[n][j][i][1] == 3|| downCanMove[n][j][i][1] == 4)) {
                //キャスリングができないときにfalseになる
                castlingQueen = false;

                break;
              }
            }
            if (!(castlingQueen)) {
              break;
            }
          }
          if (!(castlingQueen)) {
            break;
          }
        }
      }

      castlingKing = false;
      can =stage_piece_num[0][5] == 0 && stage_piece_num[0][6] == 0;//間に何もないか判定している
      if (castlingPieces[2] && can) {//キングサイド

        castlingKing = true;
        for (int n = 0; n < downCanMove.length; n++) {
          for (int j = 0; j < downCanMove[n].length; j++) {
            for ( int i = 0; i < downCanMove[n][j].length; i++) {
              if (downCanMove[n][j][i][0] == 0 && (downCanMove[n][j][i][1] == 5 || downCanMove[n][j][i][1] == 6|| downCanMove[n][j][i][1] == 4)) {
                //キャスリングができないときにfalseになる
                castlingKing = false;

                break;
              }
            }
            if (!(castlingKing)) {
              break;
            }
          }
          if (!(castlingKing)) {
            break;
          }
        }
      }

      if (castlingQueen || castlingKing) {
        check = true;
      }
    }
  }
  if (turn_num == 1) {//下側のターンの場合
    if (syogiCastlingPieces[0]) {
      syogiCastlingLeft = false;
      boolean can = stage_piece_num[8][1]==0 && stage_piece_num[8][2] == 0  && stage_piece_num[8][3] == 0;
      if (syogiCastlingPieces[1] && can ) {//レフトサイド
        syogiCastlingLeft = true;
        for (int n = 0; n < upCanMove.length; n++) {
          for (int j = 0; j < upCanMove[n].length; j++) {
            for ( int i = 0; i < upCanMove[n][j].length; i++) {
              if (upCanMove[n][j][i][0] == 8 && (upCanMove[n][j][i][1] == 2 || upCanMove[n][j][i][1] == 3|| upCanMove[n][j][i][1] == 4)) {

                //キャスリングができないときにfalseになる
                syogiCastlingLeft = false;

                break;
              }
            }
            if (!(syogiCastlingLeft)) {
              break;
            }
          }
          if (!(syogiCastlingLeft)) {
            break;
          }
        }
      }

      syogiCastlingRight = false;
      can = stage_piece_num[8][5] == 0 && stage_piece_num[8][6] == 0 && stage_piece_num[8][7] == 0;
      if (syogiCastlingPieces[2] && can) {//キングサイド

        syogiCastlingRight = true;
        for (int n = 0; n < upCanMove.length; n++) {
          for (int j = 0; j < upCanMove[n].length; j++) {
            for ( int i = 0; i < upCanMove[n][j].length; i++) {
              if (upCanMove[n][j][i][0] == 8 && (upCanMove[n][j][i][1] == 5 || upCanMove[n][j][i][1] == 6|| upCanMove[n][j][i][1] == 4)) {
                //キャスリングができないときにfalseになる
                syogiCastlingRight = false;

                break;
              }
            }
            if (!(syogiCastlingRight)) {
              break;
            }
          }
          if (!(syogiCastlingRight)) {
            break;
          }
        }
      }

      if (syogiCastlingLeft || syogiCastlingRight) {
        check = true;
      }
    }
  }
  return check;
}

void castlingChange( int x) {//駒が動く、取られるなどしてキャスリングができなくなる時実行される関数
  if ( x == 4 && castlingPieces[0]) {//キングだったら

    castlingPieces[0] = false;
  } else if (castlingPieces[1] && x == 0) {//クイーンサイドルークだったら

    castlingPieces[1] = false;
  } else if (castlingPieces[2]) {//キングサイドルークだったら
    castlingPieces[2] = false;
  }
}
void syogiCastlingChange(int x) {
  if ( x == 4 && syogiCastlingPieces[0]) {//王だったら

    syogiCastlingPieces[0] = false;
  } else if (syogiCastlingPieces[1] && x == 0) {//レフトサイド香車だったら

    syogiCastlingPieces[1] = false;
  } else if (syogiCastlingPieces[2]) {//ライトサイド香車だったら
    syogiCastlingPieces[2] = false;
  }
}

void castRect() {//キャスリングボタンを押した後にキャスリングができる駒に色を塗る処理
  if (castlingQueen) {//クイーンサイドキャスリングができるとき
    fill(255, 0, 0, 80);
    rect(stage_x, stage_y, box_size, box_size);
    queenSide = false;
    if (mouseX >= stage_x && mouseX<= stage_x + box_size && mouseY >= stage_y && mouseY <= stage_y+box_size) {
      fill(0, 255, 0, 80);
      rect(stage_x, stage_y, box_size, box_size);
      queenSide = true;
    }
  }
  if (castlingKing) {//キングサイドキャスリングができるとき
    fill(255, 0, 0, 80);
    rect(stage_x + box_size*7, stage_y, box_size, box_size);
    kingSide = false;
    if (mouseX >= stage_x + box_size*7 && mouseX<= stage_x + box_size*8 && mouseY >= stage_y && mouseY <= stage_y+box_size) {
      fill(0, 255, 0, 80);
      rect(stage_x + box_size*7, stage_y, box_size, box_size);
      kingSide = true;
    }
  }
}

void syogiCastRect() {//キャスリングボタンを押した後にキャスリングができる駒に色を塗る処理
  if (syogiCastlingLeft) {//レフトサイドキャスリングができるとき
    fill(255, 0, 0, 80);
    rect(stage_x, stage_y + box_size*8, box_size, box_size);
    leftSide = false;
    if (mouseX >= stage_x && mouseX<= stage_x + box_size && mouseY >= stage_y + box_size*8 && mouseY <= stage_y+box_size*9) {
      fill(0, 255, 0, 80);
      rect(stage_x, stage_y + box_size*8, box_size, box_size);
      leftSide = true;
    }
  }
  if (syogiCastlingRight) {//ライトサイドキャスリングができるとき
    fill(255, 0, 0, 80);
    rect(stage_x + box_size*8, stage_y + box_size*8, box_size, box_size);
    rightSide = false;
    if (mouseX >= stage_x + box_size*8 && mouseX<= stage_x + box_size*9 && mouseY >= stage_y + box_size*8 && mouseY <= stage_y+box_size*9) {
      fill(0, 255, 0, 80);
      rect(stage_x + box_size*8, stage_y + box_size*8, box_size, box_size);
      rightSide = true;
    }
  }
}

void kingSideCastling() {//キャスリングをする処理
  backSave();//一手戻るために記録をしている
  stage_piece_num[0][4] = 0;
  stage_piece_num[0][7] = 0;
  stage_piece_num[0][6] = 210;
  stage_piece_num[0][5] = 212;
}

void queenSideCastling() {//キャスリングをする処理
  backSave();//一手戻るために記録をしている
  stage_piece_num[0][4] = 0;
  stage_piece_num[0][0] = 0;
  stage_piece_num[0][2] = 210;
  stage_piece_num[0][3] = 212;
}
void leftSideCastling() {//キャスリングをする処理
  backSave();//一手戻るために記録をしている
  stage_piece_num[8][4] = 0;
  stage_piece_num[8][0] = 0;
  stage_piece_num[8][2] = 100;
  stage_piece_num[8][3] = 102;
}

void rightSideCastling() {//キャスリングをする処理
  backSave();//一手戻るために記録をしている
  stage_piece_num[8][4] = 0;
  stage_piece_num[8][8] = 0;
  stage_piece_num[8][6] = 100;
  stage_piece_num[8][5] = 102;
}
