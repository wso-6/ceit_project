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
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
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
      
  CREATE TABLE quiz_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    quiz_id TEXT NOT NULL,
    score INTEGER NOT NULL,
    total INTEGER NOT NULL,
    correct INTEGER NOT NULL,
    wrong INTEGER NOT NULL,
    date TEXT NOT NULL
  )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS quiz_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        quiz_id TEXT NOT NULL,
        score INTEGER NOT NULL,
        total INTEGER NOT NULL,
        correct INTEGER NOT NULL,
        wrong INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
    }
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

  // Quiz skorunu güncelle (sadece daha yüksekse)
  Future<void> updateQuizScore(String username, int score) async {
    Database db = await database;
    // Mevcut skoru al
    List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['quiz_score'],
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      int currentScore = result.first['quiz_score'] as int? ?? 0;
      if (score > currentScore) {
        await db.update(
          'users',
          {'quiz_score': score},
          where: 'username = ?',
          whereArgs: [username],
        );
      }
    }
  }

  // Quiz geçmişini kaydet
  Future<void> saveQuizHistory({
    required String username,
    required String quizId,
    required int score,
    required int total,
    required int correct,
    required int wrong,
  }) async {
    Database db = await database;
    await db.insert('quiz_history', {
      'username': username,
      'quiz_id': quizId,
      'score': score,
      'total': total,
      'correct': correct,
      'wrong': wrong,
      'date': DateTime.now().toString().substring(0, 16).replaceAll('T', ' '),
    });
  }

  // Son 4 quiz geçmişini getir
  Future<List<Map<String, dynamic>>> getQuizHistory(
    String username,
    String quizId,
  ) async {
    Database db = await database;
    return await db.query(
      'quiz_history',
      where: 'username = ? AND quiz_id = ?',
      whereArgs: [username, quizId],
      orderBy: 'id DESC',
      limit: 4,
    );
  }
}
