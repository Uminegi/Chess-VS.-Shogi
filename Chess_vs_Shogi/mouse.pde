void mousePressed() {//マウスをクリックしたときの処理
  if (gear == 0) {//メニュー画面でのボタン等の処理
    if (originalMode) {//オリジナルモードでゲームを始める
      gear = 2;
    }
    if (balanceMode) {//バランスモードでゲームを始める
      gear = 3;
    }
    if (customMode) {//カスタムモードでゲームを始める
      gear = 4;
    }
    if (optionMode) {//設定モードに遷移する
      gear = 6;
    }
    if (explainMode) {//説明モードに遷移する
      gear = 7;
    }
  }

  if (gear == 1) {//ゲームプレイ中のボタン等の処理
    if (choose) {
      if (!(canPutCheck(choose_y, choose_x))) {
        choose = false;
      }
    }
    if (haveChoose) {
      int x, y;
      x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
      y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
      if (!(canHavePutCheck(y, x))) {
        haveChoose = false;
      }
    }
    if (haveChessChoose) {
      int x, y;
      x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
      y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
      if (!(canHavePutCheck(y, x))) {
        haveChessChoose = false;
      }
    }
    if (!(kingSide) && !(queenSide) && (castMode)) {
      castMode = false;
    }
    if (!(rightSide) && !(leftSide) && (syogiCastMode)) {
      syogiCastMode = false;
    }

    if ((mouseX>= stage_x && mouseX < stage_x+stage_size) &&(mouseY >= stage_y && mouseY < stage_y + stage_size)
      && !(choose) && !(haveChoose) && pop == 0 && !(castMode) && !(syogiCastMode)) {
      int x, y;
      x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
      y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
      boolean turn;
      turn = turnCheck(y, x, turn_num);
      if (stage_piece_num[y][x] != 0 && turn) {//もし駒があったらここの処理が行われる
        move(x, y);
      }
    }

    if (canPut) {//実際に駒を動かすときの処理
      int x, y;
      x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
      y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
      place(choose_y, choose_x, y, x);//駒を動かす関数
      move_piece_sound.play(0);//駒を指すときの音を流す
    }

    if (canHavePut) {
      int x, y;
      x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
      y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
      havePlace(y, x, mouseHaveOption);//[haves]タブ
      move_piece_sound.play(0);//駒を指すときの音を流す
    }
    if (canHaveChessPut) {
      int x, y;
      x = (((mouseX-6) - int(stage_x))/ (int(stage_size)/9));
      y = (((mouseY-6) - int(stage_y))/ (int(stage_size)/9));
      haveChessPlace(y, x, mouseHaveOption);//[haves]タブ
      move_piece_sound.play(0);//駒を指すときの音を流す
    }
    /*持ち駒の処理*/
    if (pop == 0 && turn_num == 1&&(mouseHave==1 || mouseHave == 2)) {
      haveX = mouseX;//持ち駒選択時のマウスの位置を保存する
      haveY = mouseY;
      have_num = mouseHave;
      mouseHaveOption = haveOption;//マウスをクリックしたときの駒の種類が描画される
      haveChoose = true;
    }
    if (pop == 0 && turn_num == 2 &&(mouseHave == 3 || mouseHave == 4)) {
      haveX = mouseX;//持ち駒選択時のマウスの位置を保存する
      haveY = mouseY;
      have_num = mouseHave;
      mouseHaveOption = haveOption;//マウスをクリックしたときの駒の種類が描画される
      haveChoose = true;
    }

    if (pop == 0 && turn_num == 1&&(mouseHaveChess==5 || mouseHaveChess == 6)) {
      haveX = mouseX;//持ち駒選択時のマウスの位置を保存する
      haveY = mouseY;
      have_num = mouseHaveChess;
      mouseHaveOption = haveOption;//マウスをクリックしたときの駒の種類が描画される
      haveChessChoose = true;
    }
    if (pop == 0 && turn_num == 2 &&(mouseHaveChess == 7 || mouseHaveChess == 8)) {
      haveX = mouseX;//持ち駒選択時のマウスの位置を保存する
      haveY = mouseY;
      have_num = mouseHaveChess;
      mouseHaveOption = haveOption;//マウスをクリックしたときの駒の種類が描画される
      haveChessChoose = true;
    }



    /*駒が成るときの処理*/
    if (pop == 1 && popCheck == 1) {
      promotion(proPiece, popCheck);
      pop = 0;
      popCheck = 0;
      turnChange();
    }
    if (pop == 1 && popCheck ==2) {
      pop = 0;
      popCheck = 0;
      turnChange();
    }
    if (pop == 2 && popCheck == 1) {
      promotion(proPiece, popCheck);
      pop = 0;
      popCheck = 0;
      turnChange();
    }
    if (pop == 3 && popCheck != 0) {
      promotion(proPiece, popCheck);
      pop = 0;
      popCheck = 0;
      turnChange();
    }
    /*降参のときの処理*/
    if (resign) {
      pop = 4;
    }
    if (canBackCheck) {
      pop = 5;
    }
    if (pop == 4 && popCheck == 1) {
      turnChange();
      win = turn_num;
      gear = 5;
      popCheck = 0;
    } else if (pop == 4 && popCheck == 2) {
      pop = 0;
      popCheck = 0;
    }
    if (pop == 5 && popCheck == 1) {
      backPiece();
      popCheck = 0;
      pop = 0;
    } else if (pop == 5 && popCheck == 2) {
      pop = 0;
      popCheck = 0;
    }
    /*キャスリングの処理*/
    if (canCastling) {
      castMode = true;
    }
    if (kingSide) {
      kingSideCastling();
      upCastling = false;
      castMode = false;
      kingSide = false;
      queenSide = false;
      turnChange();
    }
    if (queenSide) {
      queenSideCastling();
      upCastling = false;
      castMode = false;
      kingSide = false;
      queenSide = false;
      turnChange();
    }
    //将棋のキャスリング
    if (canSyogiCastling) {
      syogiCastMode = true;
    }
    if (leftSide) {
      leftSideCastling();
      downCastling = false;
      syogiCastMode = false;
      leftSide = false;
      rightSide = false;
      turnChange();
    }
    if (rightSide) {
      rightSideCastling();
      downCastling = false;
      syogiCastMode = false;
      leftSide = false;
      rightSide = false;
      turnChange();
    }
    if (canBreakTime) {
      gear = 8;
      stopTimer();
      canBreakTime = false;
    }
  }
  if (gear == 6) {
    if (back) {
      gear = 0;
      back = false;
    }

    if (option1) {
      option1_num = change_option1;
    }
    if (option2) {
      option2_num = change_option2;
    }
    if (option3) {
      option3_num = change_option3;
    }
    if (original_option) {
      option1_num = 2;
      option2_num = 1;
      option3_num = 3;
    }
    if (balance_option) {
      option1_num = 1;
      option2_num = 2;
      option3_num = 1;
    }
  }
  if (gear ==7) {
    if (back) {
      gear = 0;
      back = false;
    }
  }
  if (gear == 8) {
    if (backPlay) {
      gear = 1;
      startTimer();
      backPlay = false;
    }
  }
  if (gear == 9) {
    if (back) {
      gear = 0;
      back = false;
    }
    if (start) {
      gear = 1;
      start = false;
    }
  }
}
