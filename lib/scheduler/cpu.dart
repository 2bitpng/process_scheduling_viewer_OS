import "process.dart";
class CPU{
  //プリエンプションの時間
  int? preemption;
  //現在処理中のプロセス
  Process? p = null;
  int pid = -1;
  //現在のプロセスを処理し始めてからの経過時間
  int time = 0;
  CPU(this.preemption);
  //次もまだ処理できる場合はtrue
  //そうでない場合はfalse
  //次も処理できないとは
  //timeがプリエンプションに達した
  //Processの残り時間がなくなってしまった
  bool next_time(){
    time++;
    p!.consum();
    if(p!.is_end()){
      p = null;
      return false;
    }
    if(time == preemption)return false;
    return true;
  }
  bool is_empty(){
    return p == null;
  }
  //現在のプロセスと新たに処理するプロセスを入れ替える関数
  //新たに処理するプロセスを受け取り、処理していたプロセスを返す
  //処理していたプロセスが終了していた場合はnulを返す
  Process? swap_process(Process? other){
    //pがnullの場合
    time = 0;
    Process? res = p;
    p = other;
    if(p!=null)pid = p!.get_pid();
    else pid = -1;
    return res;
  }
  int get_process_pid(){
    return pid;
  }
}
