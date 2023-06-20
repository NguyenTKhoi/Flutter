import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute('''
       CREATE TABLE IF NOT EXISTS Task (
          idTask INTEGER PRIMARY KEY AUTOINCREMENT,
          Name_Task TEXT
        )
      ''');

        await database.execute('''
        CREATE TABLE Information (
          idTask INTEGER,
          detail TEXT,
          time_start TEXT,
          FOREIGN KEY (idTask) REFERENCES Task(idTask)
        )
      ''');
      },
      version: 1,
    );
  }

  Future<void> createTask(Task task) async {
    final database = await initializeDB();
    await database.insert('Task', task.toMap());
    print(task);
  }

  Future<List<String>> getAllTaskNames() async {
    final database = await initializeDB();
    final List<Map<String, dynamic>> taskData =
    await database.query('Task', columns: ['Name_Task']);

    final List<String> taskNames =
    taskData.map((row) => row['Name_Task'] as String).toList();
    print(taskNames);
    return taskNames;
  }


  Future<void> deleteTask(String _name) async {
    final database = await initializeDB();
    await database.delete('Task', where: 'Name_Task = ?', whereArgs: [_name]);
  }
}

class Task {
 final String nameTask;
  Task(this.nameTask);

  Task.fromMap(Map<String, dynamic> item)
      :  nameTask = item["Name_Task"];

  Map<String, dynamic> toMap() {
    return {"Name_Task": nameTask};
  }
}

class Information {

  final String detail;
  final String timeStart;

  Information( this.detail, this.timeStart);

  Information.fromMap(Map<String, dynamic> item)
      : detail = item["detail"],
        timeStart = item["time_start"];

  Map<String, dynamic> toMap() {
    return {"detail": detail, "time_start": timeStart};
  }
}
