class Process{
  //投入時間
  int? intime;
  //残り時間
  int? rem;
  Process(this.intime,this.rem);
  //プロセスの残り時間をnumだけ消費する
  void consum(int? num){
    if(num != null && rem != null){
      rem = rem!- num;
      rem = rem! <0 ? 0 : rem;
    }
  }
  //プロセスの処理が終了したかを判定する関数
  bool is_end(){
    return rem == 0;
  }
  int get_intime(){
    return intime!;
  }
  int get_rem(){
    return rem!;
  }
}
