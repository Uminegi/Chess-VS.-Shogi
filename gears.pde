boolean originalMode;//オリジナル（原型）ルールで始めるための変数
boolean balanceMode;//バランスルールで始めるための変数
boolean customMode;//カスタムルールで始めるための変数
boolean optionMode;//カスタムルールの設定を変えるための変数
boolean explainMode;//説明画面に行くための変数
boolean back; //タイトル画面に戻るかどうかを判断する変数
boolean option1, option2, option3;//設定しようとしているか判断する変数
boolean original_option, balance_option;
boolean start;//ルール確認画面のゲームを始めるボタンに
int option1_num, option2_num, option3_num;//選択肢を表す番号
int change_option1, change_option2, change_option3;//選択肢変更用の変数
boolean canB, canBreakTime;//休憩ボタンを押せるかどうか判定する変数(canBがボタンを押せるかの判定、canBreakTimeが休憩するかの判定)

void menu() {//メニュー画面を表示する処理(gearは0)
  background(#deb887);//背景
  textSize(60);
  fill(0);
  text("チェスVS将棋", width/2 - 180, 100);


  originalButton();//オリジナルモードに進むためのボタン
  balanceButton();//バランスモードに進むためのボタン
  customButton();//カスタムモードに進むためのボタン
  optionButton();//カスタムモードの設定画面に進むためのボタン
  explainButton();//特殊ルール説明の画面に行くためのボタン
}


void play() {//ゲームをプレイする処理(gearは1)
  background(#deb887);//背景
  //fill(#deb887);
  // rect(stage_x,stage_y,600,600);
  fill(0);
  rect(width-consoleSize, 0, consoleSize, height);
  canPut = false;//駒が動かせるかを判断している変数

  view();//初期画面
  fill(255);
  textSize(25);
  text("対局時間", width-consoleSize + 50, 270);
  viewTimer(width - consoleSize + 62.5, 300, time);
  text(tesu + "手目", width - consoleSize + 50, 335);

  canB = !(choose) && pop == 0 && !(haveChessChoose) && !(castMode) && !(syogiCastMode)&& !(haveChoose);
  canBreakTime = breakTimeButton(canB);//休憩ボタン
  resignButton(canB);//降参ボタン
  if (canBack) {
    backPieceButton(canB);//一手戻るボタン
  }
  int viewHave;
  int viewHaveChess;
  boolean canH;//他のモードになっていないか判断する変数
  canH =  !(choose) && pop == 0 && !(haveChessChoose) && !(castMode) && !(syogiCastMode);
  if (rules[0]) {
    haveView();//持ち駒を描画する
    viewHave = viewHaveCheck();
    mouseHave = viewHave;//マウスの方の処理を行うために色々やる
    if (viewHave >= 1 && viewHave <= 4 && canH) {
      viewHaveRect(viewHave);
    }
  }

  if (rules[1]) {
    haveChessView();
    viewHaveChess = viewHaveChessCheck();
    mouseHaveChess = viewHaveChess;//マウスの方の処理を行うために色々やる
    if (viewHaveChess >= 5 && viewHaveChess <= 8 && canH) {
      viewHaveChessRect(viewHaveChess);
    }
  }
  canMoveCheck();//どの駒がどこからどこへ動けるか判断する処理
  haveCheck();//持ち駒をどこに置くことができるか判断する処理,チェスの駒の方も包含している
  boolean check;
  check = checkCheck();//チェック、王手確認用処理
  if (check) {
    viewCheck();
  }

  boolean can;
  can = (mouseX>= stage_x && mouseX < stage_x+stage_size) &&(mouseY >= stage_y && mouseY < stage_y + stage_size)
    && !(choose)&& !(haveChoose) && (pop == 0) && !(castMode) &&!(syogiCastMode) && !(syogiCastMode) && !(haveChessChoose);
  if (can) {
    /*↑選択モードでなく,駒を選択しているかの判定*/
    int x, y;
    x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
    y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
    fill(0, 0, 255, 64);
    rect(stage_x + box_size*x, stage_y + box_size*y, box_size, box_size);//マウスがある位置を塗る
  }
  cast = castlingCheck(turn_num);
  if (cast && upCastling && rules[5] && turn_num == 2) {//チェス側のキャスリング
    castling();
  }
  if (cast && downCastling && rules[4] && turn_num == 1) {//将棋側のキャスリング
    syogiCastling();
  }

  if (choose) {//駒が選択されているときの処理
    //viewChoose(choose_x,choose_y);//選択した駒が動ける範囲に色塗りを行う
    moveView(choose_y, choose_x);
    canPut=canPutCheck(choose_y, choose_x);
  }
  if (haveChoose) {//持ち駒が0だった時の処理
    if (turn_num == 1) {//下側のターン
      if (downHave[mouseHaveOption] == 0) {
        haveChoose =false;
      }
    } else {
      if (upHave[mouseHaveOption] == 0) {
        haveChoose =false;
      }
    }
  }

  if (haveChessChoose) {
    if (turn_num == 1) {//下側のターン
      if (downHaveChess[mouseHaveOption] == 0) {
        haveChessChoose =false;
      }
    } else {
      if (upHaveChess[mouseHaveOption] == 0) {
        haveChessChoose =false;
      }
    }
  }

  if (haveChoose) {//持ち駒が選択されているときの処理
    int x, y;
    x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
    y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
    haveMoveView(haveX, haveY, have_num, mouseHaveOption);//[viewタブに書いてある]
    canHavePut=canHavePutCheck(y, x);//[hves]タブ,マウスがある位置が黄色になる
  }
  if (haveChessChoose) {//チェスの持ち駒が選択されているときの処理
    int x, y;
    x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
    y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
    haveChessMoveView(haveX, haveY, have_num, mouseHaveOption);//[viewタブに書いてある]
    canHaveChessPut=canHavePutCheck(y, x);//[hves]タブ,マウスがある位置が黄色になる
  }
  if (pop != 0) {
    switch(pop) {
    case 1:
      anyPopUp();//任意の成り
      break;

    case 2:
      forcedPopUp();//強制の成り
      break;

    case 3:
      pawnPopUp();//ポーンの成り
      break;

    case 4:
      resignPopUp();//降参するかどうかを聞くポップアップ
      break;

    case 5:
      backPopUp();//一手戻るかどうかを聞くポップアップ
      break;

    default:
      break;
    }
  }
  if (castMode) {
    castRect();
  }
  if (syogiCastMode) {
    syogiCastRect();
  }
}

void gameEnd() {
  if (fixTesu) {
    tesu--;
    fixTesu = false;
  }
  stopTimer();
  background(0);
  fill(120, 120, 25);
  int t_s = 60;
  textSize(t_s);
  if ( win == 1) {
    text("下側陣営(将棋)の勝利", width/2 - 5*t_s, 100);
  } else {
    text("上側陣営(チェス)の勝利", width/2 - 5.5 * t_s, 100);
  }
  t_s = 40;
  textSize(40);
  String moji;
  moji = "対局時間:";
  text(moji, width/2-280, 400);
  viewRightTimer(width/2+200, 400, time, t_s);
  moji = "手数: " ;
  text(moji, width/2-280, 500);
  moji = tesu + "手";
  text(moji, width/2+200 - ((moji.length())/2 * t_s - t_s/2 ), 500);
}

void option() {//設定の画面
  background(160, 145, 160);
  textSize(60);
  fill(0);
  text("カスタムモード設定", width/2 - 270, 100);
  fill(0);
  textSize(40);
  text("持ち駒", width/2 - 200, 300);
  text("駒の成り", width/2 - 200, 380);
  text("キャスリング", width/2 - 200, 460);

  backButton();
  viewOptionButtons();//設定に使われるボタンの処理
}

void explain() {//特殊ルールの説明をする処理
  background(#deb887);
  backButton();
  fill(0);
  textSize(60);
  text("特殊ルールの説明", width/2 - 4*60, 100);
  textSize(30);
  text("チェスの持ち駒:", width/2 - 500, 300);
  text("将棋のキャスリング:", width/2 - 550, 500);
  String chessHaveExplain, syogiCastlingExplain;
  chessHaveExplain ="基本的には将棋と同じですが1つ異なる点があります。\nポーンが成った駒が取られた場合ポーンではなく、\n成った駒として持ち駒になります。";
  syogiCastlingExplain = "チェスでは、キングとルークでキャスリングを行うのに対し、\n将棋では王と香車でキャスリングを行います。";
  textSize(25);
  text(chessHaveExplain, width/2 - 500 + 30*7.5, 300);
  text(syogiCastlingExplain, width/2 - 550 + 30*9.5, 500);
}

void breakTime() {//休憩画面を映す処理
  int t_s;//文字のサイズ
  t_s = 60;
  background(255, 255, 120);
  fill(0);
  textSize(t_s);
  text("休憩中", width/2 - 60*1.5, 100);
  t_s = 40;
  textSize(t_s);
  String moji;
  moji = "現在の対局時間";
  text(moji, width/2 - 540, 400);
  viewRightTimer(width/2-40, 400, time, t_s);
  moji = "現在の手数";
  text(moji, width/2 - 540, 500); 
  moji = tesu + "手目";
  text(moji, width/2 -40 - ((moji.length()+0.5)/2 * t_s), 500);

  String[] mojis = {"将棋の持ち駒", "チェスの持ち駒", "将棋の成り", "チェスの成り", "将棋のキャスリング", "チェスのキャスリング"};
  t_s = 40;
  textSize(t_s);
  moji = "ルール確認";
  fill(0);
  text(moji, (width/2) + 300, 250);
  t_s = 30;
  textSize(t_s);
  for (int n = 0; n < mojis.length; n++) {
    fill(0);
    text(mojis[n], (width/2) + 160, 340 + n*60);
    if (rules[n]) {//ルールの確認
      moji = "あり";
    } else {
      moji = "なし";
      fill(255, 0, 0);
    }
    text(moji, (width/2) + 530, 340 + n*60);
  }

  playButton();//ゲームに戻るボタン
}

void confirm() {//ゲームを始める前にルールの確認をする画面
  background(#deb887);//背景
  int t_s;
  String moji;
  String[] mojis = {"将棋の持ち駒", "チェスの持ち駒", "将棋の成り", "チェスの成り", "将棋のキャスリング", "チェスのキャスリング"};
  t_s = 60;
  textSize(t_s);
  moji = "ルール確認画面";
  fill(0);
  text(moji, (width/2) - (moji.length()/2 * t_s), 100);
  t_s = 40;
  textSize(t_s);
  for (int n = 0; n < mojis.length; n++) {
    fill(0);
    text(mojis[n], width/4, 240 + n*60);
    if (rules[n]) {//ルールの確認
      moji = "あり";
    } else {
      moji = "なし";
      fill(255, 0, 0);
    }
    text(moji, width/4*3, 240 + n*60);
  }


  backButton();//メニュー画面に戻るための関数
  startButton();//ゲームを始めるためのボタン
}
