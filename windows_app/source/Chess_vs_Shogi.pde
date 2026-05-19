/*
チェスVS将棋
AIは作っていないので、一緒に遊ぶ友達を用意していください
 */
import ddf.minim.*;//ライブラリ

float consoleSize;//画面右の領域の横幅
float stage_x, stage_y;//盤面の座標
float stage_size;//盤面のサイズ
float[][] s_size;
float box_size;//盤のマス目の大きさ
int choose_x, choose_y;//選択している駒
int upHave[] = new int[7];//持ち駒
int downHave[] = new int[7];
int upHaveChess[] = new int[5];//チェスの持ち駒
int downHaveChess[] = new int[5];
boolean choose;//駒の選択をしているか判別する変数
boolean haveChoose;//持ち駒の選択をしているか判別する変数
boolean haveChessChoose;
boolean backPlay;//ゲーム画面に戻るための変数
int FPS;//フレームレート
boolean canPut;//駒が動かせるか判断する変数
boolean canHavePut;//持ち駒が置けるか判断する処理
boolean canHaveChessPut;//チェスの持ち駒が置けるか判断する処理
int turn_num = 0;//ターンの番号が入る処理(1で下側、2で上側)
int mouseHave;
int mouseHaveChess;
int mouseHaveOption;//クリックした瞬間の持ち駒の種類が入る
int have_num;
float haveX=0, haveY=0; //持ち駒選択した瞬間の座標
int pop;//ポップアップを出すか判断する変数
boolean[] castlingPieces = new boolean[3];//キャスリングができるかどうかを判定するときに使う変数
boolean[] syogiCastlingPieces = new boolean[3];//将棋側のキャスリングができるかどうか判定する変数
boolean castlingQueen, castlingKing;//クイーンサイドキャスリングかキングサイドキャスリングができるか判断する変数
boolean syogiCastlingLeft, syogiCastlingRight;//将棋のレフトキャスリングかライトキャスリングができるか判断する変数
boolean upCastling;//キャスリングを1回だけにする変数
boolean downCastling;//将棋のキャスリングを1回だけにする変数
boolean canCastling;//
boolean canSyogiCastling;//
boolean castMode;//キャスリングモードか判断する変数
boolean syogiCastMode;
boolean queenSide, kingSide;
boolean leftSide, rightSide;
boolean resign;//降参するボタンを押したかどうかの判定に使われる
boolean fixTesu;//ゲーム終了時の手数の表示を直すために使用する変数
int gear;//複数タブの表現を行う
int win;//どちらが勝ったかを判定する変数(1で下2で上)
boolean[] rules = new boolean[6];
int[] options = new int[6];//カスタムモードの設定に使う
int tesu;//手数を記録、表示する
boolean canBackCheck;
void setup() {//いろんな変数の初期化を行う
  size(1420, 800);//画面サイズの設定
  PFont font = createFont("Meiryo", 30);//ここで日本語化を行っている
  textFont(font);
  consoleSize = 200;//画面右の領域のサイズの設定
  stage_size = 600;//盤面の大きさの設定
  FPS = 60;//フレームレートの設定(タイマーはこの値を利用している)
  frameRate(FPS);
  initView();//盤面の初期化
  initImage();//画像の初期化
  initMove();//駒の動き関係の初期化
  initHave();//持ち駒関係の初期化
  initCastling();//キャスリング関係の初期化
  initSound();//音の初期化
  initTimer();//タイマーの初期化
  initElse();//その他の初期化
  initPopUp();//駒の成りなどで使うポップアップの初期化
}

void draw() {
  switch(gear) {//[break;]忘れに要注意
  case 0:
    menu();//メニュー画面
    break;

  case 1:
    startTimer();//タイマーをスタートする関数
    play();//ゲームプレイ画面
    break;

  case 2://プレイ画面
    originalSet();//オリジナルモードでのプレイ
    gear = 9;
    break;

  case 3:
    balanceSet();//バランスモードでのプレイ
    gear = 9;
    break;

  case 4:
    customSet();//カスタムモードでのプレイ
    gear = 9;
    break;

  case 5:
    gameEnd();//ゲームを終える画面
    break;

  case 6:
    option();//設定画面
    break;

  case 7:
    explain();//特殊ルールを説明するモード
    break;

  case 8:
    breakTime();//休憩モード
    break;

  case 9:
    confirm();//
    break;
  }
  if (time_han) {
    time++;
  }
}

void move(int x, int y) {//駒を選択したときに通る処理
  int move;
  move = stage_piece_num[y][x];

  choose = true;//選択モード
  choose_x = x;//選択した駒の位置
  choose_y = y;
}

boolean turnCheck(int y, int x, int turn_num ) {//指定した座標の駒の陣営と現在のターンとあっているか確認する関数
  boolean check = false;
  int[] soeji = bunnkai(stage_piece_num[y][x]);
  if (soeji[0] == turn_num) {
    check = true;
  }
  return check;
}
