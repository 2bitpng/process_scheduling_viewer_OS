class Process{
  //投入時間
  int? intime;
  //残り時間
  int? rem;
  //プロセスid
  int? pid;
  Process(this.intime,this.rem,this.pid);
  //プロセスの残り時間をnumだけ消費する
  void consum(){
    if(rem != null){
      rem = rem!- 1;
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
  int get_pid(){
    return pid!;
  }
}
