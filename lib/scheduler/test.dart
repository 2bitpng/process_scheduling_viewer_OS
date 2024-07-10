import "scheduler.dart"; 
import "cpu.dart";
import "queue.dart";
import "process.dart";
import 'package:collection/collection.dart';
void main(){
  var rem_process = [Process(0, 15, 0), Process(5, 10, 1), Process(8, 5, 2)];
  var que = PriorityProcessQueue();
  var S = Scheduler<PriorityProcessQueue>(100000, rem_process, que);
  while(true){
    S.next_time();
    if(S.is_end())break;
  }
  print(S.get_average_time());
  print(S.get_timestamp());
}
