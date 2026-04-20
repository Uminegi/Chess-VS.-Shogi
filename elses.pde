/*いろんなところから呼び出される予定の便利な関数を記録する。
 または、他のタブに分類されない関数*/
//行って戻るときに使う変数
int[] upBackHaveSyogi, upBackHaveChess, downBackHaveSyogi, downBackHaveChess;
int[][] back_stage_piece_num;
boolean[] backCastlingChess, backCastlingSyogi;
boolean canBack, backUpCastling, backDownCastling;

void initElse() {//分類されない変数などの初期化を行う
  resign = false;//降参するかどうかを判断する変数
  fixTesu = true;//結果表示時に手数を直す処理
  gear = 0;//初めにメニュー画面に行くようにする
  choose = false;//初めは何も選択していないので、[false]が入る
  turn_num = int(random(1, 3));//ターンはランダムで決める
  pop = 0;
  tesu = 1;//手数の初期化(後から気づいたが読みは"てかず")
  for (int n = 0; n < rules.length; n++) {//ルールの初期化
    rules[n] = false;
  }
  /*カスタムモード設定に関する変数の初期化
   0→両方無し、1→両方あり、2→将棋のみ,3→チェスのみ
   初期設定はオリジナルモードと同じ
   */
  option1_num = 2;//持ち駒
  option2_num = 1;//駒の成り
  option3_num = 3;//キャスリング
  canBack = false;
  back_stage_piece_num = new int[9][9];
  upBackHaveSyogi = new int[7];
  upBackHaveChess = new int[5];
  downBackHaveSyogi = new int[7];
  downBackHaveChess = new int[5];
  backCastlingChess = new boolean[3];
  backCastlingSyogi = new boolean[3];
  canBackCheck = false;
}


void textRect(float x, float y, String moji, int size, int[] rect_color, int[] text_color) {//文字を長方形の中に入れるボタンを作る目的
  /*引数は左から座標、座標、表示する文字列、文字の大きさ,長方形の色、表示する文字の色*/
  int moji_size;
  x = x+5;
  y = y+5;

  moji_size = moji.length();
  fill(rect_color[0], rect_color[1], rect_color[2]);
  rect(x, y, moji_size*size + 10, size + 10);
  x = x+5;
  fill(text_color[0], text_color[1], text_color[2]);
  text(moji, x, y+size);
}

void promotion(int[] proPiece, int popCheck) {//この言い方はチェスの言い方だけど将棋の処理も含む
  int[] soeji ;
  int y, x;
  int piece;
  int piece_num;
  soeji = bunnkai(proPiece[0]);
  int soeji1, soeji2, soeji3;
  soeji1 = soeji[0];
  soeji2 = soeji[1];
  soeji3 = soeji[2];
  y = proPiece[1];
  x = proPiece[2];
  if (soeji2 == 1) {//チェスの場合
    switch(popCheck) {
    case 1:
      piece_num = int(str(soeji1) + str(15));
      stage_piece_num[y][x] = piece_num;
      break;

    case 2:
      piece_num = int(str(soeji1) + str(14));
      stage_piece_num[y][x] = piece_num;
      break;

    case 3:
      piece_num = int(str(soeji1) + str(12));
      stage_piece_num[y][x] = piece_num;
      break;

    case 4:
      piece_num = int(str(soeji1) + str(13));
      stage_piece_num[y][x] = piece_num;
      break;
    }
  } else {//将棋の場合
    piece = conversion(soeji3);
    piece_num = int(str(soeji1)+str(soeji2)+str(piece));
    stage_piece_num[y][x] = piece_num;
  }
}

int conversion(int ex_option) {
  int option;
  if (ex_option >= 1 && ex_option<= 4) {
    option = ex_option+7;
  } else {
    option = ex_option + 6;
  }
  return option;
}

void turnChange() {
  if (turn_num == 1) {//ここではターンの入れ替えを行う
    turn_num = 2;
  } else {
    turn_num = 1;
  }
  tesu++;//ターンが変わるのと同時に手数を増やす
}

boolean checkCheck() {//チェック、王手確認用関数
  boolean kingCheck;
  kingCheck = false;
  int[][][][] canMoves;
  int king;
  int y, x;//キングや王が今現在いる位置の座標が入る
  boolean find;//キングが見つかったらtrueが入る
  if (turn_num == 1) {
    canMoves = upCanMove;
    king = 100;
  } else {
    canMoves = downCanMove;
    king = 210;
  }
  y = 0;
  x = 0;//エラー回避用
  find = false;
  for (int n = 0; n < stage_piece_num.length; n++) {
    for (int j = 0; j < stage_piece_num[n].length; j++) {
      if (stage_piece_num[n][j] == king) {
        y = n;
        x = j;
        find = true;
        break;
      }
    }
    if (find) {
      break;
    }
  }

  for (int n = 0; n < canMoves.length; n++) {
    for (int j = 0; j < canMoves[n].length; j++) {
      for (int i = 0; i < canMoves[n][j].length; i++) {
        if (canMoves[n][j][i][0] == y && canMoves[n][j][i][1] == x) {
          kingCheck = true;
          break;
        }
      }
      if (kingCheck) {
        break;
      }
    }
    if (kingCheck) {
      break;
    }
  }



  return kingCheck;
}
void backSave() {//一手戻るために駒の情報をセーブする関数
  for (int n = 0; n < upHave.length; n++) {
    upBackHaveSyogi[n] = upHave[n];
    downBackHaveSyogi[n] = downHave[n];
  }
  for (int n = 0; n < upHaveChess.length; n++) {
    upBackHaveChess[n] = upHaveChess[n];
    downBackHaveChess[n] = downHaveChess[n];
  }
  for (int n = 0; n < stage_piece_num.length; n++) {
    for (int j = 0; j < stage_piece_num[n].length; j++) {
      back_stage_piece_num[n][j] = stage_piece_num[n][j];
    }
  }
  for (int n = 0; n < castlingPieces.length; n++) {
    backCastlingChess[n] = castlingPieces[n];
    backCastlingSyogi[n] = syogiCastlingPieces[n];
  }
  backUpCastling = upCastling;
  backDownCastling = downCastling;
  canBack = true;//一手戻れるようにしている
}

void backPiece() {//実際に一手戻る関数
  for (int n = 0; n < upHave.length; n++) {
    upHave[n] = upBackHaveSyogi[n];
    downHave[n] = downBackHaveSyogi[n];
  }
  for (int n = 0; n < upHaveChess.length; n++) {
    upHaveChess[n] = upBackHaveChess[n];
    downHaveChess[n] = downBackHaveChess[n];
  }
  for (int n = 0; n < stage_piece_num.length; n++) {
    for (int j = 0; j < stage_piece_num[n].length; j++) {
      stage_piece_num[n][j] = back_stage_piece_num[n][j];
    }
  }
  for (int n = 0; n < castlingPieces.length; n++) {
    castlingPieces[n] = backCastlingChess[n];
    syogiCastlingPieces[n] = backCastlingSyogi[n];
  }
  upCastling = backUpCastling;
  downCastling = backDownCastling;
  turnChange();
  tesu = tesu - 2;//手数を一手戻す(関数turnChangeで手数+1してあるので、手数を2減らしている)

  canBack = false;//一手戻れるようにしている
}
