import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class MovieDatabase{
  static final MovieDatabase dbInstance = MovieDatabase._init();

  static Database? _database;
  MovieDatabase._init();

  //in this funtion we are just returning db instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('note.db');
      return _database!;
    }
  }

  // in this funtion we are setting db storage path
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
  //   final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  //   final boolType = 'BOOLEAN NOT NULL';
  //   final integerType = 'INTEGER NOT NULL';
  //   final textType = 'TEXT NOT NULL';
  //   String tableCreateQuery = '''CREATE TABLE $tableNotes (
  //   ${NoteFields.id} $idType,
  //   ${NoteFields.isImportant} $boolType, 
  //   ${NoteFields.number} $integerType,
  //   ${NoteFields.title} $textType,
  //   ${NoteFields.description} $textType, 
  //   ${NoteFields.title} $textType
  // )''';
    //await db.execute(tableCreateQuery);
  }


}