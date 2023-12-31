import 'package:diary_app/database/database_service.dart';
import 'package:diary_app/models/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDB {
  final tableName = 'notes';

  Future<void> createTable(Database database) async {
    await database.execute("""
CREATE TABLE IF NOT EXISTS $tableName(
  "id" INTEGER NOT NULL,
  "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s",'now') as int)),
  "updated_at" INTEGER,
  PRIMARY KEY("id" AUTOINCREMENT);
  ""
 )
""");
  }
}
