import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class DatabaseHelper {
  static const _databaseName = 'user_database.db';
  static const _databaseVersion = 1;

  static const table = 'users';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnPassword = 'password';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print("Initializing database...");
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    print("Creating table...");
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnEmail TEXT NOT NULL,
      $columnPassword TEXT NOT NULL
    )
  ''');
  }

  Future<int> insertUser(User user) async {
    final Database db = await database;
    print("Inserting user...");
    print("User values to be inserted: $user");
    final int insertedId = await db.insert(table, user.toMap());
    print("User inserted with ID: $insertedId");
    return insertedId;
  }

  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table,
        where: '$columnEmail = ? AND $columnPassword = ?',
        whereArgs: [email, password]);

    if (maps.isNotEmpty) {
      return User(
        id: maps[0][columnId],
        name: maps[0][columnName],
        email: maps[0][columnEmail],
        password: maps[0][columnPassword],
      );
    } else {
      return null;
    }
  }

  Future<List<User>> getUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i][columnId],
        name: maps[i][columnName],
        email: maps[i][columnEmail],
        password: maps[i][columnPassword],
      );
    });
  }
}
