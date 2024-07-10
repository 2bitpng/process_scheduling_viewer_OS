import 'process.dart';  // Processクラスのインポート
import 'package:collection/collection.dart';

class ProcessQueue {
  List<Process> _queue = [];  // プライベートなリスト

  // プロセスを追加するメソッド
  void push(Process? p) {
    if (p != null) {
      _queue.add(p);
    }
  }

  // プロセスを取り出すメソッド
  Process pop() {
    Process res = _queue.first;
    _queue.removeAt(0);
    return res;
  }

  // Queueが空かどうかを判定するメソッド
  bool is_empty() {
    return _queue.isEmpty;
  }
}
class PriorityProcessQueue extends ProcessQueue {
  PriorityQueue<Process> _priorityQueue;

  PriorityProcessQueue()
      : _priorityQueue = PriorityQueue<Process>((a, b) => a.get_rem().compareTo(b.get_rem()));

  @override
  void push(Process? p) {
    if (p != null) {
      _priorityQueue.add(p);
    }
  }

  @override
  Process pop() {
    return _priorityQueue.removeFirst();
  }

  @override
  bool is_empty() {
    return _priorityQueue.isEmpty;
  }
}
