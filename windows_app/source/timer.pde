int time;//タイマーを動かすときに使われる変数
boolean time_han;
void initTimer() {
  time = 0;
  time_han = false;//タイマーを動かない状態にする
}

void startTimer() {//タイマーをスタートする関数
  time_han = true;
}
void stopTimer() {//タイマーを止める関数
  time_han = false;
}
void resetTimer() {//タイマーの数値をリセットする関数
  time = 0;
}
void viewTimer(float x, float y, int time) {
  String hour, minute, second;//分と秒が文字列として入る
  int hourValue, minuteValue, secondValue;
  hourValue = (time/FPS) / 3600;//時間の値がここに入る
  minuteValue = (time/FPS)/60 % 60;//分の値がここに入る
  secondValue = (time/FPS)%60;//秒の値がここに入る

  hour = str(hourValue);
  minute = str(minuteValue);
  second = str(secondValue);
  if (minute.length() == 1) {//もし分が1桁だったらここの処理が行われる
    minute = "0" + minute;//数字の左に0をつける
  }
  if (second.length() == 1) {//もし秒が1桁だったらここの処理が行われる
    second = "0" + second;
  }
  text(hour+":"+minute + ":" + second, x, y);
}

void viewRightTimer(float x, float y, int time, int t_s) {//座標を左上ではなく右上基準で描画するタイマー
  String hour, minute, second;//分と秒が文字列として入る
  String timeMoji;
  int hourValue, minuteValue, secondValue;
  hourValue = (time/FPS) / 3600;//時間の値がここに入る
  minuteValue = (time/FPS)/60 % 60;//分の値がここに入る
  secondValue = (time/FPS)%60;//秒の値がここに入る

  hour = str(hourValue);
  minute = str(minuteValue);
  second = str(secondValue);
  if (minute.length() == 1) {//もし分が1桁だったらここの処理が行われる
    minute = "0" + minute;//数字の左に0をつける
  }
  if (second.length() == 1) {//もし秒が1桁だったらここの処理が行われる
    second = "0" + second;
  }
  timeMoji = hour+":"+minute + ":" + second;
  text(timeMoji, x-(timeMoji.length()/2 * t_s), y);
}
