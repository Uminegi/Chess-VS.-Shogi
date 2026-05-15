int movedPiece[][][][];//将棋とチェスの動きをひとまとめにする
int syogiMove[][][];//3次元配列(1次元配列に2次元配列を入れるイメージで使用)
int chessMove[][][];
int reverseMove[][][];//上側に表示される将棋の動き
int reverseChessMove[][][];//下側に表示されるチェスの動き
int movePattern[][];//駒の動きを翻訳するために使用する
boolean firstPawn;//ポーンが初めの1歩かどうかを判断する変数

int upCanMove[][][][] = new int[9][9][32][2];//上側陣営の動きを表す配列
int downCanMove[][][][] = new int[9][9][32][2];//下側陣営の動きを表す配列
String test[] = {"歩:", "香車:", "桂馬:", "銀将:", "金将:", "角行:", "飛車:"};
String testChess[] = {"ポーン:", "ルーク:", "ナイト:", "ビショップ:", "クイーン:"};
boolean firstPawns[] = new boolean[8];
void initMove() {
  for (int n = 0; n < firstPawns.length; n++) {//ポーンの一歩目ができるかどうかを確認する変数
    firstPawns[n] = true;
  }
  /*{向き,歩数}(向きは左前を0として半時計回り
   歩数は1が1歩、2が無限歩),桂馬やナイト、ポーンは
   少し特殊なので別で作る*/

  /*まずは将棋の動きから*/
  int syogi_ou[][] ={{0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}, {7, 1}};//王の動きを表している
  int syogi_hu[][] ={{1, 1}};//歩の動き
  int syogi_kyo[][] ={{1, 2}};//香車の動き
  int syogi_kei[][]={{-1, -2}, {1, -2}};//桂馬は{xの歩数,yの歩数}
  int syogi_gin[][] ={{0, 1}, {1, 1}, {2, 1}, {4, 1}, {6, 1}};//銀の動き
  int syogi_kin[][] = {{0, 1}, {1, 1}, {2, 1}, {3, 1}, {5, 1}, {7, 1}};//金、と金、成り香、成り桂、成り銀の動き
  int syogi_kaku[][] ={{0, 2}, {2, 2}, {4, 2}, {6, 2}};//角行の動き
  int syogi_hisya[][] = {{1, 2}, {3, 2}, {5, 2}, {7, 2}};//飛車の動き
  int syogi_ryuuma[][] ={{0, 2}, {1, 1}, {2, 2}, {3, 1}, {4, 2}, {5, 1}, {6, 2}, {7, 1}};//竜馬(成り角の動き)
  int syogi_ryuuou[][] = {{0, 1}, {1, 2}, {2, 1}, {3, 2}, {4, 1}, {5, 2}, {6, 1}, {7, 2}};//龍王(成り飛車の動き)
  int ex_syogiMove[][][] = {syogi_ou, syogi_hu, syogi_kyo, syogi_kei, syogi_gin, //長すぎるので改行
    syogi_kin, syogi_kaku, syogi_hisya, syogi_kin, syogi_kin, syogi_kin, syogi_kin, syogi_ryuuma, syogi_ryuuou};
  syogiMove = ex_syogiMove;//グローバル変数に将棋の駒の動きを入れる

  /*上側陣営の将棋の動き*/
  int space[][] ={{0, 0}};//上側には王がいないので仮置き
  int reverse_hu[][] ={{5, 1}};//歩の動き
  int reverse_kyo[][] ={{5, 2}};//香車の動き
  int reverse_kei[][]={{-1, 2}, {1, 2}};//桂馬は{xの歩数,yの歩数}
  int reverse_gin[][] ={{0, 1}, {2, 1}, {4, 1}, {5, 1}, {6, 1}};//銀の動き
  int reverse_kin[][] = {{1, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}, {7, 1}};//金、と金、成り香、成り桂、成り銀の動き
  int reverse_kaku[][] ={{0, 2}, {2, 2}, {4, 2}, {6, 2}};//角行の動き
  int reverse_hisya[][] = {{1, 2}, {3, 2}, {5, 2}, {7, 2}};//飛車の動き
  int reverse_ryuuma[][] ={{0, 2}, {1, 1}, {2, 2}, {3, 1}, {4, 2}, {5, 1}, {6, 2}, {7, 1}};//竜馬(成り角の動き)
  int reverse_ryuuou[][] = {{0, 1}, {1, 2}, {2, 1}, {3, 2}, {4, 1}, {5, 2}, {6, 1}, {7, 2}};//龍王(成り飛車の動き)
  int ex_reverseMove[][][] = {space, reverse_hu, reverse_kyo, reverse_kei, reverse_gin, //長すぎるので改行
    reverse_kin, reverse_kaku, reverse_hisya, reverse_kin, reverse_kin, reverse_kin, reverse_kin, reverse_ryuuma, reverse_ryuuou};
  reverseMove = ex_reverseMove;

  /*次はチェス*/
  int chess_king[][] = syogi_ou;//将棋の王と同じ
  int chess_pawn[][] = {{0, 1}, {0, 2}, {-1, 1}, {1, 1}};//左からいつもの、初めの一歩、敵が斜め前にいるとき、敵が斜め前にいるとき
  /*ポーンは桂馬やナイトと同じ動かし方をする*/
  int chess_rook[][] = syogi_hisya;//ルークの動きは将棋の飛車と同じ
  int chess_knight[][] = {{-1, -2}, {1, -2}, {2, -1}, {2, 1}, {1, 2}, {-1, 2}, {-2, 1}, {-2, -1}};//ナイトは{xの歩数,yの歩数}
  int chess_bishop[][] = syogi_kaku;//ビショップの動きは将棋の角行と同じ
  int chess_queen[][]= {{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}, {5, 2}, {6, 2}, {7, 2}};//クイーンの動き
  int ex_chessMove[][][] = {chess_king, chess_pawn, chess_rook, chess_knight, chess_bishop, chess_queen};
  chessMove = ex_chessMove;//グローバル変数にチェスの駒の動きを入れる

  /*下側のチェスの動き(ほとんど元のチェスト同じ)*/
  int reverse_pawn[][] ={{0, -1}, {0, -2}, {-1, -1}, {1, -1}};//[1]番目は実は必要ないが関数の関係で必要
  int ex_reverse_chess[][][] = {space, reverse_pawn, chess_rook, chess_knight, chess_bishop, chess_queen};
  reverseChessMove = ex_reverse_chess;//グローバル変数に駒の動きを入れる
  int ex_movedPiece[][][][] = {syogiMove, chessMove, reverseMove, reverseChessMove};//[将棋かチェスか上側陣営の将棋か下側のチェス][種類][駒の動きの種類][実際の動き]
  movedPiece = ex_movedPiece;//将棋とチェスの動きを組み合わせる

  int ex_movePattern[][] = {{-1, -1}, {0, -1}, {1, -1}, {1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}};//翻訳するための前準備(x,y)
  movePattern = ex_movePattern;//駒の動きを翻訳するときに使う変数

  for (int n = 0; n < upCanMove.length; n++) {
    for (int j = 0; j < upCanMove[n].length; j++) {
      for (int i = 0; i < upCanMove[n][j].length; i++) {
        for (int k = 0; k < upCanMove[n][j][i].length; k++) {
          upCanMove[n][j][i][k] = -1;
        }
      }
    }
  }
  for (int n = 0; n < downCanMove.length; n++) {
    for (int j = 0; j < downCanMove[n].length; j++) {
      for (int i = 0; i < downCanMove[n][j].length; i++) {
        for (int k = 0; k < downCanMove[n][j][i].length; k++) {
          downCanMove[n][j][i][k] = -1;
        }
      }
    }
  }
}

void canMoveCheck() {//駒がどこからどこに動けるかを陣営ごとに記述する←超大事!!
  for (int n = 0; n < upCanMove.length; n++) {
    for (int j = 0; j < upCanMove[n].length; j++) {
      for (int i = 0; i < upCanMove[n][j].length; i++) {
        for (int k = 0; k < upCanMove[n][j][i].length; k++) {
          upCanMove[n][j][i][k] = -1;//変数の初期化
        }
      }
    }
  }
  for (int n = 0; n < downCanMove.length; n++) {
    for (int j = 0; j < downCanMove[n].length; j++) {
      for (int i = 0; i < downCanMove[n][j].length; i++) {
        for (int k = 0; k < downCanMove[n][j][i].length; k++) {
          downCanMove[n][j][i][k] = -1;//変数の初期化
        }
      }
    }
  }

  for (int n = 0; n < stage_piece_num.length; n++) {
    for (int j = 0; j < stage_piece_num[n].length; j++) {//「どこから動くか」を中心にする,n→y座標,j→x座標
      if (stage_piece_num[n][j] != 0) {//駒がなかったら処理しない
        int soeji[];
        soeji = bunnkai(stage_piece_num[n][j]);//数字が分解される
        if (soeji[0] == 1) {//下側陣営のとき
          if (soeji[1] == 1 && soeji[2] == 1) {//下側のポーンの動き
            downCanMove[n][j] = pawnMove(n, j, soeji);
          } else if (soeji[2] == 3) {//桂馬とナイトの駒のとき
            downCanMove[n][j] = jumpMove(n, j, soeji);
          } else {//通常の駒の処理

            downCanMove[n][j] = normalMove(n, j, soeji);//下側陣営の通常の駒の動きを絶対参照方式で入れる
          }
        } else {//上側陣営のときの処理


          if (soeji[2] == 1 && soeji[1] == 1) {//ポーンの駒の処理
            upCanMove[n][j] = pawnMove(n, j, soeji);
          } else if (soeji[2] == 3) {//ナイトの駒の処理
            upCanMove[n][j] = jumpMove(n, j, soeji);
          } else {//通常の駒の処理

            upCanMove[n][j] =normalMove(n, j, soeji);
          }
        }
      }
    }
  }
}

int[][] normalMove(int y, int x, int soeji[]) {//通常の駒
  int soeji1, soeji2, soeji3;
  soeji1 = soeji[0];//陣営情報
  soeji2 = soeji[1];//チェスか将棋かの情報
  soeji3 = soeji[2];//駒の種類
  if (soeji1 == 2 && soeji2 == 0) {
    soeji2 = 2;
  } else if (soeji1 == 1 && soeji2 ==1) {
    soeji2 = 3;
  }

  int m_y, m_x;//参照するときに使う
  m_y = y;//選択された駒の位置を保存
  m_x = x;//選択された駒野位置を保存

  int size;
  size = 32;
  int insert[][] = new int[size][2];//代入用配列
  for (int n = 0; n < insert.length; n++) {
    for (int j = 0; j < insert[n].length; j++) {
      insert[n][j] = -1;
    }
  }
  int count = 0;
  for (int n = 0; n < movedPiece[soeji2][soeji3].length; n++) {//駒が動ける動きを配列に入れる処理
    int transration[];
    int moves[];
    boolean enemy = true;//駒に敵がいたら[false]になる
    moves = movedPiece[soeji2][soeji3][n];//サイズは2,内容は(方向,歩数),歩数は1で1歩、2で無限歩
    transration = movePattern[moves[0]];//方向を翻訳して代入
    m_x = m_x + transration[0];
    m_y = m_y + transration[1];//1マス動く
    if (canMove(m_y, m_x, soeji1)) {
      insert[count][0] = m_y;
      insert[count][1] = m_x;
      enemy = enemyCheck(m_y, m_x, soeji1);
      count += 1;
      m_x = m_x + transration[0];
      m_y = m_y + transration[1];

      while (canMove(m_y, m_x, soeji1) && moves[1] == 2 && enemy) {
        insert[count][0] = m_y;
        insert[count][1] = m_x;
        enemy = enemyCheck(m_y, m_x, soeji1);
        count += 1;
        m_x = m_x + transration[0];
        m_y = m_y + transration[1];
      }
    }
    m_y = y;//選択された駒の位置を保存
    m_x = x;//選択された駒野位置を保存
  }
  return insert;
}


int[][] jumpMove(int y, int x, int soeji[]) {//桂馬とナイトの処理
  int soeji1, soeji2, soeji3;
  soeji1 = soeji[0];//陣営情報
  soeji2 = soeji[1];//チェスか将棋かの情報
  soeji3 = soeji[2];//駒の種類
  if (soeji1 == 2 && soeji2 == 0) {
    soeji2 = 2;
  } else if (soeji1 == 1 && soeji2 ==1) {
    soeji2 = 3;
  }

  int m_y, m_x;//参照するときに使う
  m_y = y;//選択された駒の位置を保存
  m_x = x;//選択された駒野位置を保存

  int size;
  size = 32;
  int insert[][] = new int[size][2];//代入用配列
  for (int n = 0; n < insert.length; n++) {
    for (int j = 0; j < insert[n].length; j++) {
      insert[n][j] = -1;//配列の初期化
    }
  }

  int count = 0;
  for (int n = 0; n < movedPiece[soeji2][soeji3].length; n++) {//駒が動ける動きを配列に入れる処理
    int moves[];//桂馬とナイトは駒の実際の動きが入る
    moves = movedPiece[soeji2][soeji3][n];
    m_x = m_x + moves[0];
    m_y = m_y + moves[1];
    if (canMove(m_y, m_x, soeji1)) {
      insert[count][0] = m_y;
      insert[count][1] = m_x;
      count += 1;
    }

    m_y = y;//選択された駒の位置を保存
    m_x = x;//選択された駒野位置を保存
  }

  return insert;
}


int[][] pawnMove(int y, int x, int soeji[]) {//ポーンの処理
  int soeji1, soeji2, soeji3;
  soeji1 = soeji[0];//陣営情報
  soeji2 = soeji[1];//チェスか将棋かの情報
  soeji3 = soeji[2];//駒の種類
  if (soeji1 == 1 && soeji2 ==1) {
    soeji2 = 3;
  }

  int m_y, m_x;//参照するときに使う
  m_y = y;//選択された駒の位置を保存
  m_x = x;//選択された駒野位置を保存

  int size;
  size = 32;
  int insert[][] = new int[size][2];//代入用配列
  for (int n = 0; n < insert.length; n++) {
    for (int j = 0; j < insert[n].length; j++) {
      insert[n][j] = -1;//配列の初期化
    }
  }

  int count = 0;
  boolean enemy = true;//敵がいたらtrueになる
  int moves[];//ポーンの動きはそのまま入る
  moves = movedPiece[soeji2][soeji3][0];
  m_x = m_x + moves[0];
  m_y = m_y + moves[1];
  enemy = enemyCheck(m_y, m_x, soeji1);
  if (canMove(m_y, m_x, soeji1)&& (enemy)) {
    insert[count][0] = m_y;
    insert[count][1] = m_x;
    //そのマスに敵がいるかの確認
    count += 1;
    m_y = y;//選択された駒の位置を保存
    m_x = x;//選択された駒野位置を保存
    moves = movedPiece[soeji2][soeji3][1];//ポーンが初期位置で目の前に敵がいない時
    m_x = m_x + moves[0];
    m_y = m_y + moves[1];
    enemy =enemyCheck(m_y, m_x, soeji1);
    if (enemy && y == 1 && x >= 0 && x <= 7 && canMove(m_y, m_x, soeji1) && firstPawns[x] ) {//ポーンが初期位置にいるとき

      insert[count][0] = m_y;
      insert[count][1] = m_x;
      count += 1;
    }
  }
  m_y = y;//選択された駒の位置を保存
  m_x = x;//選択された駒野位置を保存

  moves = movedPiece[soeji2][soeji3][2];
  m_x = m_x + moves[0];
  m_y = m_y + moves[1];
  if (canMove(m_y, m_x, soeji1)) {
    enemy = enemyCheck(m_y, m_x, soeji1);
    if (!(enemy)) {
      insert[count][0] = m_y;
      insert[count][1] = m_x;
      count += 1;
    }
  }
  m_y = y;//選択された駒の位置を保存
  m_x = x;//選択された駒野位置を保存

  moves = movedPiece[soeji2][soeji3][3];
  m_x = m_x + moves[0];
  m_y = m_y + moves[1];
  if (canMove(m_y, m_x, soeji1)) {
    enemy = enemyCheck(m_y, m_x, soeji1);
    if (!(enemy)) {
      insert[count][0] = m_y;
      insert[count][1] = m_x;
      count += 1;
    }
  }

  return insert;
}

boolean canMove(int m_y, int m_x, int soeji1) {//そのマスが外ではない(かつ)その駒に味方がいない
  int soeji[];
  if (m_y >= 0 && m_y <= 8 && m_x >= 0 && m_x <= 8) {//マスが外ではない
    soeji = bunnkai(stage_piece_num[m_y][m_x]);
    if (soeji1 != soeji[0]) {//その駒に味方がいない
      return true;
    }
    //味方がいた場合
    return false;
  }
  return false;//マスの外側だった時
}

boolean enemyCheck(int m_y, int m_x, int soeji1) {//その駒に敵がいるかの確認
  if (m_y>=0 && m_y <= 8&& m_x >= 0&& m_x <= 8) {
    if (stage_piece_num[m_y][m_x] != 0) {
      boolean check;
      int group;
      int soeji[];
      soeji = bunnkai(stage_piece_num[m_y][m_x]);//動く予定位置にいる駒がわかる
      if (soeji1 != soeji[0]) {//敵がいたら
        check = false;
      } else {
        check = true;
      }

      return check;//駒がいたときはここ
    }
  }
  return true;//駒がないときはここ
}

void place(int ex_y, int ex_x, int after_y, int after_x) {//駒を動かすときの処理←超重要
  backSave();//一手戻るために記録をしている
  int soeji[];
  int ex_soeji[];
  int check_num;
  check_num = stage_piece_num[after_y][after_x];//動く先の駒が入る(持ち駒保存用)
  ex_soeji = bunnkai(stage_piece_num[ex_y][ex_x]);
  soeji = bunnkai(stage_piece_num[after_y][after_x]);//ここで動く先の駒を分解して添え字にしている
  stage_piece_num[after_y][after_x] = stage_piece_num[ex_y][ex_x];
  stage_piece_num[ex_y][ex_x] = 0;
  choose = false;
  canPut = false;//ここはいらないかも
  if (ex_y == 1 && ex_x >= 0 && ex_x <= 7) {//ポーンが初期位置から動いたからfalseになる
    firstPawns[ex_x] = false;
  }
  if (after_y == 1 && after_x >= 0 && after_x <= 7) {
    firstPawns[after_x] = false;
  }

  if (rules[0]) {
    if (soeji[1] == 0 && check_num !=0) {
      if (turn_num == 1 ) {//下のターン
        downHave = have(downHave, soeji[2]);//soeji[2]には動いた先の駒の種類が入る
        for (int n = 0; n < downHave.length; n++) {
        }
      } else {//上のターン
        upHave = have(upHave, soeji[2]);
        for (int n = 0; n < upHave.length; n++) {
        }
      }
    }
  }
  if (rules[1]) {
    if (soeji[1] == 1 && check_num !=0) {
      if (turn_num == 1 ) {//下のターン
        downHaveChess = chessHave(downHaveChess, soeji[2]);//soeji[2]には動いた先の駒の種類が入る
        for (int n = 0; n < downHaveChess.length; n++) {
        }
      } else {//上のターン
        upHaveChess = chessHave(upHaveChess, soeji[2]);
        for (int n = 0; n < upHaveChess.length; n++) {
        }
      }
    }
  }
  if (rules[4]) {
    if (ex_y == 0 && (ex_x == 0 || ex_x == 4 || ex_x == 7)) {
      castlingChange( ex_x);
    }
    if (after_y == 0 && (after_x == 0 || after_x == 4 || after_x == 7)) {
      castlingChange(after_x);
    }
  }
  if (rules[5]) {
    if (ex_y == 8 && (ex_x == 0 || ex_x == 4 || ex_x == 7)) {
      syogiCastlingChange(ex_x);
    }
    if (after_y == 8 && (after_x == 0 || after_x == 4 || after_x == 7)) {
      syogiCastlingChange(after_x);
    }
  }


  pop = popCheck(stage_piece_num[after_y][after_x], after_y, after_x, ex_y);
  if (pop == 0) {
    turnChange();
  }
  if (check_num == 100) {
    win = 2;
    gear = 5;
  } else if ( check_num == 210) {
    win = 1;
    gear = 5;
  }
}
