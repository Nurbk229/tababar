import 'package:tababar/db_helper.dart';

class Task {
  String taskName;
  bool isComplete;
  int id;

  Task(this.taskName, this.isComplete);

  static final String dbName = 'task.db';
  static final String tableName = 'tasks';
  static final String columnIdName = 'id';
  static final String columnTaskName = 'name';
  static final String columnTaskValueName = 'value';

  static final String sqlCreateTable = '''CREATE TABLE $tableName (
  $columnIdName INTEGER PRIMARY KEY AUTOINCREMENT ,
  $columnTaskName TEXT NOT NULL,
  $columnTaskValueName INTEGER NOT NULL
  );''';


  static Task fromMap(Map map) {
    bool value;
    if (map[columnTaskValueName] == 1)
      value = true;
    else
      value = false;
    var task = Task(map[columnTaskName], value);
    task.id = map[columnIdName];
    return task;
  }

  static toMap(Task taskModel) {
    return {
      columnTaskName: taskModel.taskName,
      columnTaskValueName: taskModel.isComplete ? 1 : 0
    };
  }
}
