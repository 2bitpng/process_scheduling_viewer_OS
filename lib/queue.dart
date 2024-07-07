import 'process.dart';  // Processクラスのインポート

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
