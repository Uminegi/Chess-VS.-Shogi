/*ボタン関係の処理が入ります(クラス化すればよかった…)*/
void originalButton() {//オリジナルモードで始めるためのボタン
  int[] textColor = {0, 0, 0};//ボタンの文字の色
  int[] rectColor = {235, 246, 247};//ボタンの四角の色
  int t_s = 30;//文字サイズ
  textSize(t_s);
  String moji = "オリジナルモード";
  textRect(width/2 - (moji.length())/2*t_s, height/2, moji, t_s, rectColor, textColor);
  float x = (width/2 - (moji.length())/2*t_s) + 5;
  float y =  height/2 + 5;
  float x_s = moji.length()*t_s + 10;
  float y_s = t_s + 10;
  originalMode = false;
  if ( mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    originalMode = true;
  }
}

void balanceButton() {//バランスモードで始めるためのボタン

  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s = 30;
  textSize(t_s);
  String moji = "バランスモード";
  textRect(width/2 - (moji.length())/2*t_s, height/2 + t_s*2, moji, t_s, rectColor, textColor);//文字を四角付きで表示する関数
  float x = (width/2 - (moji.length())/2*t_s) + 5;
  float y =  height/2 + t_s*2+ 5;
  float x_s = moji.length()*t_s + 10;
  float y_s = t_s + 10;
  balanceMode = false;
  if ( mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    balanceMode = true;
  }
}

void customButton() {//カスタムモードで始めるためのボタン

  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s = 30;
  textSize(t_s);
  String moji = "カスタムモード";
  textRect(width/2 - (moji.length())/2*t_s, height/2 + t_s*4, moji, t_s, rectColor, textColor);
  float x = (width/2 - (moji.length())/2*t_s) + 5;
  float y =  height/2 + t_s*4+ 5;
  float x_s = moji.length()*t_s + 10;
  float y_s = t_s + 10;
  customMode = false;
  if ( mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    customMode = true;
  }
}

void optionButton() {//カスタムモードの設定画面に行くためのボタン

  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s = 30;
  textSize(t_s);
  String moji = "設定";
  textRect(width/2 - (moji.length())/2*t_s + 170, height/2 + t_s*4, moji, t_s, rectColor, textColor);
  float x = (width/2 - (moji.length())/2*t_s + 170) + 5;
  float y =  height/2 + t_s*4+ 5;
  float x_s = moji.length()*t_s + 10;
  float y_s = t_s + 10;
  optionMode = false;
  if ( mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    optionMode = true;
  }
}
void explainButton() {//特殊ルール(チェスの成りと将棋のキャスリング)の説明

  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s = 30;
  textSize(t_s);
  String moji = "特殊ルールの説明";
  textRect(width/2 - (moji.length())/2*t_s, height/2 + t_s*6, moji, t_s, rectColor, textColor);
  float x = (width/2 - (moji.length())/2*t_s) + 5;
  float y =  height/2 + t_s*6+ 5;
  float x_s = moji.length()*t_s + 10;
  float y_s = t_s + 10;
  explainMode = false;
  if ( mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    explainMode = true;
  }
}
boolean breakTimeButton(boolean can) {//休憩するためのボタン
  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s = 30;
  textSize(t_s);
  String moji = "休憩をとる";
  boolean canBreakTime;
  canBreakTime = false;
  textRect(width-consoleSize + 20, 600, moji, t_s, rectColor, textColor);
  float x = width-consoleSize + 20 + 5;
  float y = 600 + 5;
  float x_s = moji.length() * t_s + 10;
  float y_s = t_s + 10;
  if (mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s && can) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    canBreakTime = true;
  }


  return canBreakTime;
}
void playButton() {
  backPlay = false;
  String moji = "ゲームに戻る";
  int t_s = 30;
  textSize(t_s);
  int[] rectColor = {240, 240, 240};
  int[] textColor = {0, 0, 0};
  textRect(0, 0, moji, t_s, rectColor, textColor);
  int x_s, y_s;
  x_s = moji.length() * t_s + 10;
  y_s = t_s + 10;
  if (mouseX >= 5 && mouseX <= 5 + x_s && mouseY >= 5 && mouseY <= 5 + y_s) {
    backPlay = true;
    fill(0, 0, 0, 80);
    rect(5, 5, x_s, y_s);
  }
}
void resignButton(boolean can) {//投了・リザインボタン
  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s = 30;
  textSize(t_s);
  String moji;
  if (turn_num == 1) {
    moji = "投了";
  } else {
    moji = "リザイン";
  }

  resign = false;
  textRect(width-consoleSize + 20, 500, moji, t_s, rectColor, textColor);
  float x = width-consoleSize + 20 + 5;
  float y = 500 + 5;
  float x_s = moji.length() * t_s + 10;
  float y_s = t_s + 10;
  if (mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s && can) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    resign = true;
  }
}
void viewOptionButtons() {//設定画面のボタン
  option1 = false;
  option2 = false;
  option3 = false;
  original_option = false;
  balance_option = false;

  float x, y, x_size, y_size;
  int[] rectColor = new int[3];
  int[] textColor = new int[3];
  String[] mojis = new String[4];
  int t_s = 20;
  textSize(t_s);
  x = width /2 + 80;
  y = 250;
  x_size = 100;
  y_size = 60;
  fill(235, 246, 247, 255);
  rect(x, y, x_size, y_size);
  fill(0, 0, 0);
  text("チェスのみ", x, y + (y_size+t_s)/2);//基準
  rectColor[0] = 235;
  rectColor[1] = 246;
  rectColor[2] = 247;
  textColor[0] = 0;
  textColor[1] = 0;
  textColor[2] = 0;
  mojis[0] = "両方無し";
  mojis[1] = "両方あり";
  mojis[2] = "将棋のみ";
  mojis[3] = "チェスのみ";
  /*効率が悪いコードになるがif文のなかが違うのでしょうがない←配列化していないのが悪い*/
  for (int n = 0; n < 4; n++) {//option1の内容
    float m_x;//yはそのままだったので必要無し
    m_x = x + (x_size + 10)*n;
    fill(235, 246, 247);
    rect(m_x, y, x_size, y_size);
    fill(0, 0, 0);
    text(mojis[n], x + (x_size + 10)*n, y + (y_size+t_s)/2);
    if (option1_num != n) {
      fill(0, 0, 0, 160);
      rect(x + (x_size + 10)*n, y, x_size, y_size);
    }
    if (mouseX >= m_x && mouseX <= m_x + x_size && mouseY >= y && mouseY <= y + y_size) {
      option1 = true;
      change_option1 = n;
    }
  }
  y += 80;
  for (int n = 0; n < 4; n++) {//option2の内容
    float m_x;//yはそのままだったので必要無し
    m_x = x + (x_size + 10)*n;
    fill(235, 246, 247);
    rect(m_x, y, x_size, y_size);
    fill(0, 0, 0);
    text(mojis[n], x + (x_size + 10)*n, y + (y_size+t_s)/2);
    if (option2_num != n) {
      fill(0, 0, 0, 160);
      rect(x + (x_size + 10)*n, y, x_size, y_size);
    }
    if (mouseX >= m_x && mouseX <= m_x + x_size && mouseY >= y && mouseY <= y + y_size) {
      option2 = true;
      change_option2 = n;
    }
  }
  y += 80;
  for (int n = 0; n < 4; n++) {//option3の内容
    float m_x;//yはそのままだったので必要無し
    m_x = x + (x_size + 10)*n;
    fill(235, 246, 247);
    rect(m_x, y, x_size, y_size);
    fill(0, 0, 0);
    text(mojis[n], x + (x_size + 10)*n, y + (y_size+t_s)/2);
    if (option3_num != n) {
      fill(0, 0, 0, 160);
      rect(x + (x_size + 10)*n, y, x_size, y_size);
    }
    if (mouseX >= m_x && mouseX <= m_x + x_size && mouseY >= y && mouseY <= y + y_size) {
      option3 = true;
      change_option3 = n;
    }
  }

  /*この下は固定セットのボタン*/
  String moji;
  float b_x, b_y, b_x_s, b_y_s;
  t_s = 30;
  textSize(t_s);
  moji = "オリジナルセット";
  x = width/2 - 300;
  y = height - 100;
  textRect(x, y, moji, t_s, rectColor, textColor);
  b_x = x + 5;
  b_y = y + 5;
  b_x_s = moji.length() * t_s + 10;
  b_y_s = t_s + 10;
  if (mouseX >= b_x && mouseX <= b_x + b_x_s && mouseY >= b_y && mouseY <= b_y + b_y_s) {
    original_option = true;
    fill(255, 255, 0, 80);
    rect(b_x, b_y, b_x_s, b_y_s);
  }

  x += 300;
  moji = "バランスセット";
  textRect(x, y, moji, t_s, rectColor, textColor);
  b_x = x + 5;
  b_y = y + 5;
  b_x_s = moji.length() * t_s + 10;
  b_y_s = t_s + 10;
  if (mouseX >= b_x && mouseX <= b_x + b_x_s && mouseY >= b_y && mouseY <= b_y + b_y_s) {
    balance_option = true;
    fill(255, 255, 0, 80);
    rect(b_x, b_y, b_x_s, b_y_s);
  }
}

void backButton() {//メニュー画面に戻るためのボタン
  back = false;
  int t_s = 40;
  int[] rectColor = {255, 255, 0};
  int[] textColor = {0, 0, 0};
  textSize(t_s);
  textRect(0, 0, "戻る", t_s, rectColor, textColor);
  int x, y, x_s, y_s;
  x = 5;
  y = 5;
  x_s = t_s*2 + 10;
  y_s = t_s + 10;
  if (mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    back = true;
  }
}
void startButton() {//ゲームを始めるボタン
  start = false;
  int t_s = 40;
  int[] rectColor = {255, 255, 0};
  int[] textColor = {0, 0, 0};
  String moji;
  moji = "ゲームを始める";
  textSize(t_s);
  textRect(width/2 - moji.length()/2 * t_s, height-120, moji, t_s, rectColor, textColor);
  int x, y, x_s, y_s;
  x = width/2 - moji.length()/2 * t_s + 5;
  y = height-120 + 5;
  x_s = t_s*moji.length() + 10;
  y_s = t_s + 10;
  if (mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    start = true;
  }
}

void backPieceButton(boolean can) {
  int[] textColor = {0, 0, 0};
  int[] rectColor = {235, 246, 247};
  int t_s = 30;
  textSize(t_s);
  String moji;
  moji = "一手戻る";

  canBackCheck = false;
  textRect(width-consoleSize + 20, 700, moji, t_s, rectColor, textColor);
  float x = width-consoleSize + 20 + 5;
  float y = 700 + 5;
  float x_s = moji.length() * t_s + 10;
  float y_s = t_s + 10;
  if (mouseX >= x && mouseX <= x + x_s && mouseY >= y && mouseY <= y + y_s && can) {
    fill(0, 0, 255, 80);
    rect(x, y, x_s, y_s);
    canBackCheck = true;
  }
}
