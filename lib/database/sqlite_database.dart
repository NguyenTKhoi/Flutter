import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute('''
       CREATE TABLE CATALOG (
          idCatalog INTEGER PRIMARY KEY,
          Name_Catalog TEXT
        )
      ''');

        await database.execute('''
        CREATE TABLE TASK (
          idTask INTEGER PRIMARY KEY AUTOINCREMENT,
          idCatalog INTEGER,
          FOREIGN KEY (idCatalog) REFERENCES CATALOG(idCatalog)
        )
      ''');

        await database.execute('''
        CREATE TABLE DetailTask (
          idTask INTEGER,
          FOREIGN KEY (idTask) REFERENCES TASK(idTask),
          Detail TEXT,
          Day TEXT,
          Start_Time TEXT,
          End_Time TEXT
        )
      ''');
      },
      version: 1,
    );
  }

  Future<int> createCatalog(CATALOG catalog) async {
    int result = 0;
    final Database db = await initializeDB();
    final id = await db.insert('CATALOG', catalog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    return id;
  }

  Future<List<Map<String, dynamic>>> getCatalogData() async {
    final Database db = await initializeDB();

    // Execute a query to fetch all data from the CATALOG table
    final List<Map<String, dynamic>> catalogData = await db.query('CATALOG');
    print(catalogData);
    return catalogData;
  }

  Future<int> deleteAllCatalogData() async {
    final Database db = await initializeDB();

    // Delete all rows from the CATALOG table
    final int rowsAffected = await db.delete('CATALOG');

    return rowsAffected;
  }

  Future<List<String>> getCatalogNames() async {
    final Database db = await initializeDB();

    // Execute a query to fetch the Name_Catalog column from the CATALOG table
    final List<Map<String, dynamic>> catalogData =
        await db.query('CATALOG', columns: ['Name_Catalog']);

    // Extract the Name_Catalog values from the query results
    final List<String> catalogNames =
        catalogData.map((row) => row['Name_Catalog'] as String).toList();
    print(catalogNames);
    return catalogNames;
  }

  Future<void> deleteItemByCatalogName(String catalogName) async {
    final Database db = await initializeDB();

    await db.delete(
      'CATALOG',
      where: 'Name_Catalog = ?',
      whereArgs: [catalogName],
    );
  }
}

class CATALOG {
  // final int idCatalog;
  final String Name_Catalog;
  CATALOG(this.Name_Catalog);
  CATALOG.fromMap(Map<String, dynamic> item)
      : Name_Catalog = item["Name_Catalog"];
  Map<String, Object> toMap() {
    return {"Name_Catalog": Name_Catalog};
  }
}

class TASK {
  final int idTask;
  final String idCatalog;
  TASK(this.idTask, this.idCatalog);
  TASK.fromMap(Map<String, dynamic> item)
      : idTask = item["idTask"],
        idCatalog = item["idCatalog"];
  Map<String, Object> toMap() {
    return {"idTask": idTask, "idCatalog": idCatalog};
  }
}

class DETAIL_TASK {
  final int idTask;
  final String Detail_Task;
  final String Day;
  final String Start_Time;
  final String End_Time;
  DETAIL_TASK(
      this.idTask, this.Detail_Task, this.Day, this.Start_Time, this.End_Time);
  DETAIL_TASK.fromMap(Map<String, dynamic> item)
      : idTask = item["idTask"],
        Detail_Task = item["Detail_Task"],
        Day = item["Day"],
        Start_Time = item["Start_Time"],
        End_Time = item["End_Time"];
  Map<String, Object> toMap() {
    return {
      "idTask": idTask,
      "Detail_Task": Detail_Task,
      "Day": Day,
      "Start_Time": Start_Time,
      "End_Time": End_Time,
    };
  }
}
