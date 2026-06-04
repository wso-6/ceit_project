import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cyber_detective.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        surname TEXT NOT NULL,
        grade TEXT NOT NULL,
        gender TEXT NOT NULL,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        badge TEXT DEFAULT 'Rookie Detective 🔍',
        quiz_score INTEGER DEFAULT 0,
        game_score INTEGER DEFAULT 0
      )
    ''');
  }

  // Yeni kullanıcı kaydı
  Future<int> registerUser({
    required String name,
    required String surname,
    required String grade,
    required String gender,
    required String username,
    required String password,
  }) async {
    Database db = await database;
    return await db.insert('users', {
      'name': name,
      'surname': surname,
      'grade': grade,
      'gender': gender,
      'username': username,
      'password': password,
    });
  }

  // Giriş kontrolü
  Future<Map<String, dynamic>?> loginUser(
    String username,
    String password,
  ) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Kullanıcı bilgilerini getir
  Future<Map<String, dynamic>?> getUser(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Kullanıcı adı zaten var mı?
  Future<bool> usernameExists(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty;
  }
}
