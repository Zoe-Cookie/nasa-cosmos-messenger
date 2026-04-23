import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/apod_model.dart';

class FavoriteRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('apod_favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        date TEXT PRIMARY KEY,
        title TEXT,
        explanation TEXT,
        url TEXT,
        media_type TEXT,
        thumbnail_url TEXT
      )
    ''');
  }

  Future<List<ApodModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      orderBy: 'date DESC',
    );

    return maps.map((map) => ApodModel.fromJson(map)).toList();
  }

  Future<void> addFavorite(ApodModel apod) async {
    final db = await database;

    await db.insert(
      'favorites',
      apod.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, // 避免同一天的天文圖儲存多次
    );
  }

  Future<void> removeFavorite(String date) async {
    final db = await database;

    await db.delete(
      'favorites',
      where: 'date = ?',
      whereArgs: [date],
    );
  }
}