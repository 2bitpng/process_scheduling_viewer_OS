import "cpu.dart";
import "queue.dart";
import "process.dart";

class Scheduler<QueueType extends ProcessQueue> {
  int? preemption;
  List<Process> rem_process;
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
    print(time+1);
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
    if(!que.is_empty()) {
      if (cpu!.is_empty()) {
        // queの先頭を加える
        cpu!.swap_process(que.pop());
      }
    }
    if(cpu!.is_empty()){
      time++;
      return;
    }
    if (!cpu!.next_time()) {
      //プロセスの処理自体が終了した場合
      print("TIME is");
      sum_time+=time-Starttime[ cpu?.get_process_pid()]!+1;
      print((time-Starttime[ cpu?.get_process_pid()]!+1));
      if(!cpu!.is_empty()){
        if(que.is_empty()){
          que.push(cpu!.swap_process(null));
        }else{
          que.push(cpu!.swap_process(que.pop()));
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
}

void main() {
  var rem_process = [Process(0, 10, 0), Process(2, 20, 1), Process(6, 5, 2)];
  var que = ProcessQueue(); // ここで ProcessQueue のインスタンスを作成
  var S = Scheduler<ProcessQueue>(1000, rem_process, que);
  while(true){
    S.next_time();
    if(S.is_end())break;
  }
  print(S.get_average_time());
}

