import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user.dart';

class DatabaseProvider {
  static const String tableName = 'users';

  static Future<Database> open() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, name TEXT, email TEXT,  password TEXT)',
        );
      },
      version: 1,
    );

    return database;
  }

  static Future<void> insertUser(User user) async {
    final Database db = await open();
    await db.insert(
      tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // database_provider.dart
  static Future<List<User>> getUsersByEmail(String email) async {
    final Database db = await open();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    return List.generate(
      maps.length,
      (index) {
        return User(
          id: maps[index]['id'],
          name: maps[index]['name'],
          email: maps[index]['email'],
          password: maps[index]['password'],
        );
      },
    );
  }

  static Future<List<User>> getUsers() async {
    final Database db = await open();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(
      maps.length,
      (index) {
        return User(
          id: maps[index]['id'],
          name: maps[index]['name'],
          email: maps[index]['email'],
          password: maps[index]['password'],
        );
      },
    );
  }
}
