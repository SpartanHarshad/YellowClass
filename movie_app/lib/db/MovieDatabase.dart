import 'package:movie_app/model/Movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
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
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final String tableCreateQuery = '''CREATE TABLE $tableMoview (
    ${MoviewFields.id} $idType,
    ${MoviewFields.movieName} $textType,
    ${MoviewFields.directorName} $textType, 
    ${MoviewFields.posterImgUrl} $textType
  )''';
    await db.execute(tableCreateQuery);
  }
//insert movie details
  Future<Movie> saveMovie(Movie movie) async {
    final db = await dbInstance.database;
    // final json = movie.toJson();
    // final columns =
    //     '${MoviewFields.movieName}, ${MoviewFields.directorName}, ${MoviewFields.posterImgUrl}';
    // final value = '${json[MoviewFields.movieName]},${json[MoviewFields.directorName]}, ${json[MoviewFields.posterImgUrl]}';
    // final id = await db
    //     .rawInsert('INSERT INTO $tableMoview ($columns) VALUES ($value)');
    final id = await db.insert(tableMoview, movie.toJson());
    return movie.copy(id: id);
  }

  Future<Movie> showPerticularMovieDetails(int id) async {
    final db = await dbInstance.database;
    final maps = await db.query(
      tableMoview,
      columns: MoviewFields.values,
      where: '${MoviewFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('ID $id Not Found');
    }
  }
//show all movie details 
Future<List<Movie>> showAllMovieDetails() async{
final db = await dbInstance.database;
//final result = await db.rawQuery('SELECT * FROM $tableMoview ORDER BY $orderBy');
final orderBy = '${MoviewFields.movieName} ASC';
final result = await db.query(tableMoview,orderBy:orderBy);
return result.map((json)=> Movie.fromJson(json)).toList();
  }

//update movie details
  Future<int> editMovieDetails(Movie movie) async{
final db = await dbInstance.database;
return db.update(
  tableMoview, 
  movie.toJson(),
  where: '${MoviewFields.id} = ?',
  whereArgs: [movie.id],
);
  }

  //delete movie details
  Future<int> deleteMovieDetails(int id) async{
final db = await dbInstance.database;
return await db.delete(
  tableMoview, 
  where: '${MoviewFields.id} = ?',
  whereArgs: [id],
);
  }

//close db
Future closeDB() async{
  final db = await dbInstance.database;
  db.close();
}
}

