import 'dart:io';
import 'package:diary_app/database/note._db.dart';
import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class NoteDbProvider {
  Database? db;
  init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "notes.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        //only called when the application is opened for the first time
        newDb.execute("""
CREATE TABLE Notes (
  "id" INTEGER NOT NULL,
  "note" TEXT,
  "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s",'now') as int)),
  "updated_at" INTEGER,
  PRIMARY KEY("id" AUTOINCREMENT);
)
""");
      },
    );
  }
}

// class DatabaseService {
//   Database? _database;
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initialize();
//     return _database!;
//   }
// }

// Future<String> get fullPath async {
//   const name = 'todo.db';
//   final path = await getDatabasesPath();
//   return join(path, name);
// }

// Future<Database> _initialize() async {
//   final path = await fullPath;
//   var database = await openDatabase(
//     path,
//     version: 1,
//     onCreate: create,
//     singleInstance: true,
//   );
//   return database;
// }

// Future<void> create(Database database, int version) async =>
//     await NoteDB().createTable(database);
