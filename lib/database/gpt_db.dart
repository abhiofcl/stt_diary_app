import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DiaryEntry {
  int? id;
  String date;
  String content;
  int isFavorite;

  DiaryEntry(
      {this.id,
      required this.date,
      required this.content,
      required this.isFavorite});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'content': content,
      'isFavorite': isFavorite,
    };
  }

  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'],
      date: map['date'],
      content: map['content'],
      isFavorite: map['isFavorite'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'diary.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        content TEXT,
        isFavorite BOOLEAN
      )
    ''');
  }

  Future<int> insertEntry(DiaryEntry entry) async {
    Database db = await database;
    return await db.insert('entries', entry.toMap());
  }

  Future<List<DiaryEntry>> getAllEntries() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('entries');
    return List.generate(maps.length, (index) {
      return DiaryEntry.fromMap(maps[index]);
    });
  }

  Future<void> deleteAllEntries() async {
    Database db = await database;
    await db.delete('entries');
  }

  Future<void> updateEntry(DiaryEntry entry) async {
    Database db = await database;
    await db.update(
      'entries',
      entry.toMap(),
      where: 'id=?',
      whereArgs: [entry.id],
    );
  }
}
