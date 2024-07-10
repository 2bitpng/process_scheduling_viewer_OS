import "cpu.dart";
import "queue.dart";
import "process.dart";

class Scheduler<QueueType extends ProcessQueue> {
  int? preemption;
  List<Process> rem_process;
  List<int> timestamp =[];
  QueueType que;
  CPU? cpu = null;
  int time = 0;
  int sum_time = 0;
  int process_num = 0;
  //各プロセスの投入時間
  Map<int,int> Starttime= {-1:-1};

  Scheduler(this.preemption, this.rem_process, this.que) {
    time = 0;
    sum_time = 0;
    timestamp.clear();
    cpu = CPU(this.preemption);
    this.rem_process.sort((a, b) {
      if (a.get_intime() == b.get_intime()) {
        return a.get_pid().compareTo(b.get_pid());
      } else {
        return a.get_intime().compareTo(b.get_intime());
      }
    });
    process_num = this.rem_process.length;
    for(Process a in this.rem_process){
      Starttime[a.get_pid()] = a.get_intime();
    }
  }

  void next_time() {
    // queにrem_processを追加する
    if(!que.is_empty()) {
      if (cpu!.is_empty()) {
        // queの先頭を加える
        cpu!.swap_process(que.pop());
      }
    }
    //現在のCPUの処理を終えた時
    if(!cpu!.is_empty()){
      timestamp.add(cpu!.get_process_pid());
      if (!cpu!.next_time()) {
        print("TIME is ${time}");
        //(time-Starttime[cpu?.get_process_pid()]!)
        print("process_id is ${cpu?.get_process_pid()}");
        //プロセスの処理自体が終了した場合
        if(!cpu!.is_empty()){
          if(que.is_empty()){
            que.push(cpu!.swap_process(null));
          }else{
            que.push(cpu!.swap_process(que.pop()));
          }
        }else{
          sum_time+=time-Starttime[ cpu?.get_process_pid()]!;
        }
      }
    }
    if (rem_process.isNotEmpty) {
      // 現在の時刻と同じものを追加できるだけ追加する.
      while(rem_process.isNotEmpty){
        var now = rem_process.first;
        if(now.get_intime()==time){
          que.push(now);
          rem_process.removeAt(0);
        }else{
          break;
        }
      }
    }
    time++;
  }
  bool is_end(){
    return (que.is_empty()) && (rem_process.isEmpty) && (cpu!.is_empty());
  }
  double get_average_time(){
    return sum_time / (process_num);
  }
  List<int> get_timestamp(){
    return timestamp;
  }
}

//void main() {
//  var rem_process = [Process(0, 15, 0), Process(5, 10, 1), Process(8, 5, 2)];
////  var rem_process = [Process(0, 1, 1), Process(0, 1, 2), Process(0, 1, 3),Process(0, 100, 10)];
//  var que = ProcessQueue(); // ここで ProcessQueue のインスタンスを作成
//  var S = Scheduler<ProcessQueue>(1, rem_process, que);
//  while(true){
//    S.next_time();
//    if(S.is_end())break;
//  }
//  print(S.get_average_time());
//  print(S.get_timestamp());
//}
