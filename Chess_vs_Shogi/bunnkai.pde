int[] bunnkai(int ex_num) {//3または4桁の数字を3つに分解する,例1234→1,2,34の3つに分ける
  int[]data;
  data = new int[3];
  int num1, num2, num3;
  if (ex_num < 1000) {//桁数の確認
    num3 = ex_num%10;
    num2 = ((ex_num%100) - num3) / 10;
    num1 = (ex_num - (num2+num3)) / 100;
  } else {
    num3 = ex_num%100;
    num2 = ((ex_num%1000)-num3)/100;
    num1 = (ex_num - (num3+num2))/1000;
  }
  data[0] = num1;//上側陣営か下側陣営か
  data[1] = num2;//将棋かチェスか
  data[2] = num3;//駒の種類

  return data;
}
