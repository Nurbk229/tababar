
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tababar/task_model.dart';


class DBHelper {
  DBHelper._();

  static DBHelper myDatabase = DBHelper._();


  Database database;

  initDb() async {
    if (database == null)
      return await createDatabase();
    else
      return database;
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');
      return openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute(Task.sqlCreateTable);
      });
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  insertTask(Task taskModel) async {
    var db = await initDb();
    var insert = db.insert(Task.tableName, Task.toMap(taskModel));
  }

  Future<List<Map>> getAllTask() async {
    var db = await initDb();
    return await db.query(Task.tableName);
  }

  Future<List<Map>> getTask(String taskName) async {
    var db = await initDb();
    return db
        .query(Task.tableName, where: "${Task.columnTaskName}=?", whereArgs: [Task.tableName]);
  }

  Future<List<Map>> getTaskWhere(bool value) async {
    var _value = value ? 1 : 0;
    var db = await initDb();
    return db
        .query(Task.tableName, where: "${Task.columnTaskValueName}=?", whereArgs: [_value]);
  }

  updateTask(Task taskModel) async {
    var db = await initDb();
    db.update(Task.tableName, Task.toMap(taskModel),
        where: "${Task.columnIdName}=${taskModel.id}");
  }

  deleteTask(int id) async {
    var db = await initDb();
    db.delete(Task.tableName, where: "${Task.columnIdName}=$id");
  }
}
