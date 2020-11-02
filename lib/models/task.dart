class Task {
  String _name;
  DateTime _date;
  bool _done;

  Task(String name) {
    _name = name;
    _date = DateTime.now();
    _done = false;
  }

  turnDone() => _done = true;
  turnUndone() => _done = false;

  get name => _name;
  get date => _date;
  get done => _done;

  @override
  String toString() {
    return '$_name $_date $_done';
  }
}
