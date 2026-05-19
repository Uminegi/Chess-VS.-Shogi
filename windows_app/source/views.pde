
/*将棋とチェスと陣営を分けるために将棋は2桁で[0n],チェスは[1n]と表し陣営は下が[1nm]、上が[2nm]とあらわす
 例.下の歩→001,上のN→113*/
String[][] stage_piece;//使わないかも
int[][] stage_piece_num;//[y座標][x座標]
boolean canPuts[][] = new boolean[9][9];
String stage_moji[] = new String[9];
void initView() {//盤面や表示に関する初期化
  stage_x = (width-consoleSize)/2 - stage_size/2;
  stage_y = height/2 - stage_size/2;
  s_size= new float[9][9];
  box_size=stage_size/9;//マス目の大きさ
  stage_piece = new String[9][9];
  stage_piece_num = new int[9][9];
  for (int n = 0; n < stage_piece.length; n++) {
    for (int j = 0; j < stage_piece[n].length; j++) {
      stage_piece[n][j] = null;//配列の中すべてに[null]を入れる
      stage_piece_num[n][j] = 0;//配列の中すべてに[0]を入れる
    }
  }

  stage_moji[0] ="a";
  stage_moji[1] ="b";
  stage_moji[2] ="c";
  stage_moji[3] ="d";
  stage_moji[4] ="e";
  stage_moji[5] ="f";
  stage_moji[6] ="g";
  stage_moji[7] ="h";
  stage_moji[8] ="i";
  initChessPiece();//(上側)チェスの盤面の初期化
  initSyogiPiece();//(下側)将棋の盤面の初期化
}

void initChessPiece() {
  for (int n = 0; n < 8; n++) {
    stage_piece_num[1][n] = 211;//211はポーン(P)
  }
  stage_piece_num[0][0] = 212;//212はルーク(R)
  stage_piece_num[0][7] = 212;
  stage_piece_num[0][1] = 213;//213はナイト(N)
  stage_piece_num[0][6] = 213;
  stage_piece_num[0][2] = 214;//214はビショップ(B)
  stage_piece_num[0][5] = 214;
  stage_piece_num[0][3] = 215;//215はクイーン(Q)
  stage_piece_num[0][4] = 210;//210はキング(K)
}

void initSyogiPiece() {
  for (int n = 0; n < 9; n++) {
    stage_piece_num[6][n] = 101;//101は歩
  }
  stage_piece_num[8][0] = 102;//102は香車
  stage_piece_num[8][8] = 102;
  stage_piece_num[8][1] = 103;//103は桂馬
  stage_piece_num[8][7] = 103;
  stage_piece_num[8][2] = 104;//104は銀将
  stage_piece_num[8][6] = 104;
  stage_piece_num[8][3] = 105;//105は金将
  stage_piece_num[8][5] = 105;
  stage_piece_num[8][4] = 100;//100は王
  stage_piece_num[7][1] = 106;//106は角行
  stage_piece_num[7][7] = 107;//107は飛車
}


void view() {//チェス将棋盤と駒の画像を書く処理

  String turnText;
  if (turn_num == 1) {
    turnText = "下側のターンです";
    textSize(24);
    text("こちら側のターンです", width-consoleSize - 240, height - 50);
  } else {
    turnText = "上側のターンです";
    textSize(24);
    text("こちら側のターンです", 0, 90);
  }
  fill(255);
  textSize(20);
  text(turnText, (width-consoleSize), 100);

  for (int n = 0; n<s_size.length; n++) {//盤面の出力
    for (int j = 0; j<s_size[n].length; j++) {
      if ((n+j)%2==0) {
        fill(42, 106, 204);
      } else {
        fill(#d59533);
      }
      rect(stage_x + box_size*n, stage_y + box_size*j, box_size, box_size);//盤面
    }
  }
  fill(0);
  textSize(19);
  for (int n = 0; n< 9; n++) {//盤の横の数字
    text(9-n, stage_x + box_size*(-0.4), stage_y+box_size*(n+0.6));
    text(stage_moji[n], stage_x+box_size*(n+0.45), stage_y + box_size*(-0.2));
  }



  /*駒を描画する処理*/
  fill(0);
  for (int n = 0; n < stage_piece_num.length; n++) {
    for (int j = 0; j < stage_piece_num[n].length; j++) {
      if (stage_piece_num[n][j] != 0) {
        int[] soeji;
        soeji = bunnkai(stage_piece_num[n][j]);//数字が1桁ごとに抽出される(4桁のときは3,4桁はまとまる)
        if (soeji[1] == 0) {//将棋のときの処理
          if (soeji[0] == 1) {//下側陣営
            image(syogi_images[soeji[2]], stage_x + box_size*j + 3, stage_y + box_size*n + 4);
          } else {//上側陣営
            image(reverse_images[soeji[2]], stage_x + box_size*j + 3, stage_y + box_size*n + 4);
          }
        } else {//チェスのときの処理
          if (soeji[0] == 1) {//下側陣営
            image(reverse_chess[soeji[2]], stage_x + box_size*j + 3, stage_y + box_size*n + 4);
          } else {//上側陣営
            image(chess_images[soeji[2]], stage_x + box_size*j + 3, stage_y + box_size*n + 4);
          }
        }
      }
    }
  }
}

void viewChoose(int x, int y) {//多分ここはいらない
  int soeji[];//数字をして添え字にする
  soeji = bunnkai(stage_piece_num[y][x]);

  fill(0, 255, 0, 64);
  rect(stage_x + box_size*x, stage_y + box_size*y, box_size, box_size);//選択した駒のマスに色を付ける
}

//void stageView() {//チェス将棋盤を書く処理
//}

void moveView(int y, int x) {
  int soeji[];
  soeji = bunnkai(stage_piece_num[y][x]);
  int viewCanMove[][];//ここにはどのマスに動けるかが入る
  int remit;
  remit = 32;
  fill(0, 255, 0, 64);
  rect(stage_x + box_size*x, stage_y + box_size*y, box_size, box_size);
  if ( soeji[0] == 1) {//下側陣営のとき
    viewCanMove = downCanMove[y][x];
  } else {
    viewCanMove = upCanMove[y][x];
  }
  int c = 0;
  fill(#ff0000, 80);

  while (viewCanMove[c][0] != -1 ) {
    int v_y, v_x;
    v_y = viewCanMove[c][0];
    v_x = viewCanMove[c][1];
    rect(stage_x + box_size*v_x, stage_y + box_size*v_y, box_size, box_size);

    c += 1;
    if ( c >= remit) {
      break;
    }
  }
}

boolean canPutCheck(int y, int x) {//マウスが動けるマスにあったら黄色になるようにする
  boolean canMove;//
  int soeji[];
  soeji = bunnkai(stage_piece_num[y][x]);
  int viewCanMove[][];//ここにはどのマスに動けるかが入る
  int remit;
  remit = 32;
  if ( soeji[0] == 1) {//下側陣営のとき
    viewCanMove = downCanMove[y][x];
  } else {
    viewCanMove = upCanMove[y][x];
  }

  /*ここからは駒を動けるようにする処理を書く*/
  canMove = false;
  if ((mouseX>= stage_x && mouseX < stage_x+stage_size) &&(mouseY >= stage_y && mouseY < stage_y + stage_size)) {//マウスが盤上にあったら処理をする
    int mouse_x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));//盤上の座標
    int mouse_y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
    int d = 0;//カウント用の変数
    while (viewCanMove[d][0] != -1) {
      if (viewCanMove[d][0] == mouse_y && viewCanMove[d][1] == mouse_x) {
        fill(0, 255, 0, 80);//駒がある位置を黄色にする
        rect(stage_x + box_size*mouse_x, stage_y + box_size*mouse_y, box_size, box_size);
        canMove = true;
        break;
      }


      d += 1;
      if ( d >= remit) {
        break;
      }
    }
  }
  return canMove;
}

void haveMoveView(float haveX, float haveY, int num, int option) {
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
      if (haveY >= checkY + j*40) {
        fill(0, 255, 0, 64);
        rect(checkX, checkY + j*40, 40, 40);

        break;
      }
    }
  } else {//右側の時の処理
    for (int n = 0; n < 3; n++) {
      int j = 2 - n;
      if (haveY >= checkY + j*40) {
        fill(0, 255, 0, 64);
        rect(checkX, checkY + j*40, 40, 40);

        break;
      }
    }
  }

  boolean haveCanPut[][] = new boolean[9][9];
  if (num <= 2) {//下側陣営
    if (option == 0) {//歩兵だったら
      haveCanPut = downHuhyoCanPut;
    } else if (option == 1) {//香車だったら
      haveCanPut = downKyosyaCanPut;
    } else if (option == 2) {//桂馬だったら
      haveCanPut = downKeimaCanPut;
    } else {//それ以外の駒だったら
      haveCanPut = normalCanPut;
    }
  } else {//上側陣営
    if (option == 0) {//歩兵だったら
      haveCanPut = upHuhyoCanPut;
    } else if (option == 1) {//香車だったら
      haveCanPut = upKyosyaCanPut;
    } else if (option == 2) {//桂馬だったら
      haveCanPut = upKeimaCanPut;
    } else {//それ以外の駒だったら
      haveCanPut = normalCanPut;
    }
  }
  canPuts = haveCanPut;//グローバル変数に保存
  fill(255, 0, 0, 80);//赤色に塗る
  for (int n = 0; n < haveCanPut.length; n++) {
    for (int j = 0; j < haveCanPut.length; j++) {
      if (haveCanPut[n][j]) {
        rect(stage_x + box_size*j, stage_y + box_size*n, box_size, box_size);//マウスがある位置を塗る
      }
    }
  }
}
void haveChessMoveView(float haveX, float haveY, int num, int option) {
  float checkX, checkY;
  switch(num) {
  case 5://下側の左
    checkX = stage_x + box_size*10.5;//下側の左
    checkY = stage_y + box_size*6 - 180;
    break;

  case 6://下側の右
    checkX = stage_x + box_size*12;//下側の右
    checkY = stage_y + box_size*6 - 180;
    break;

  case 7://上側の左
    checkX = stage_x + box_size*(-4);//上側の左
    checkY = stage_y + 260;
    break;

  case 8://上側の右
    checkX = stage_x + box_size*(-2.5);//上側の右
    checkY = stage_y + 260;
    break;

  default://ここを通ることは絶対にない
    checkX =0;
    checkY = 0;
    break;
  }
  if (num == 5 || num == 7) {//上でも下で左側の時の処理
    for (int n = 0; n < 3; n++) {
      int j = 2 - n;
      if (haveY >= checkY + j*40) {
        fill(0, 255, 0, 64);
        rect(checkX, checkY + j*40, 40, 40);

        break;
      }
    }
  } else {//右側の時の処理
    for (int n = 0; n < 2; n++) {
      int j = 1 - n;
      if (haveY >= checkY + j*40) {
        fill(0, 255, 0, 64);
        rect(checkX, checkY + j*40, 40, 40);

        break;
      }
    }
  }

  boolean haveCanPut[][] = new boolean[9][9];
  if (num <= 6) {//下側陣営
    if (option == 0) {//ポーンだったら
      haveCanPut = downKyosyaCanPut;
    } else {//それ以外の駒だったら
      haveCanPut = normalCanPut;
    }
  } else {//上側陣営
    if (option == 0) {//歩兵だったら
      haveCanPut = upKyosyaCanPut;
    } else {//それ以外の駒だったら
      haveCanPut = normalCanPut;
    }
  }
  canPuts = haveCanPut;//グローバル変数に保存
  fill(255, 0, 0, 80);//赤色に塗る
  for (int n = 0; n < haveCanPut.length; n++) {
    for (int j = 0; j < haveCanPut.length; j++) {
      if (haveCanPut[n][j]) {
        rect(stage_x + box_size*j, stage_y + box_size*n, box_size, box_size);//マウスがある位置を塗る
      }
    }
  }
}

void viewCheck() {
  fill(255);
  textSize(30);
  text("王手中です", width-consoleSize + 20, height/2+50);
}
