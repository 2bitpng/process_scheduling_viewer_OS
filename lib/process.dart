class Process{
  //投入時間
  int? _intime;
  //残り時間
  int? _rem;
  //プロセスid
  int? _pid;
  Process(this._intime,this._rem,this._pid);
  //プロセスの残り時間をnumだけ消費する
  void consum(){
    if(_rem != null){
      _rem = _rem! - 1;
      _rem = _rem! <0 ? 0 : _rem;
    }
  }
  //プロセスの処理が終了したかを判定する関数
  bool is_end(){
    return _rem == 0;
  }
  int get_intime(){
    return _intime!;
  }
  int get_rem(){
    return _rem!;
  }
  int get_pid(){
    return _pid!;
  }
}
