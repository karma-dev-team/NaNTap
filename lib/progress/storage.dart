import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Для поддержки ffi
import 'package:path/path.dart';
import 'dart:convert';
import 'package:nantap/progress/interfaces.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SQLiteStorage implements AbstractStorage {
  Database? db;

  // Initialize and open the SQLite database
  @override
  Future<void> setup() async {
    // Инициализация databaseFactory для sqflite_common_ffi
    databaseFactory = databaseFactoryFfiWeb; 

    // Получаем путь к базе данных
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'general.db');

    // Открываем базу данных
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Создаём таблицу, если она отсутствует
        await db.execute('''
          CREATE TABLE data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key TEXT NOT NULL UNIQUE,
            data TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Get a specific field's raw data for a key from the SQLite database
  @override
  Future<String> getRaw(String key) async {
    try {
      if (db == null) throw Exception('Database is not initialized');
      List<Map<String, dynamic>> result = await db!.query(
        'data',
        where: 'key = ?',
        whereArgs: [key],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return result.first['data'] as String;
      }

      return '';
    } catch (e) {
      throw Exception('Failed to get raw data: $e');
    }
  }

  // Extract raw data for all rows from the SQLite database
  @override
  Future<String> extractRaw() async {
    try {
      if (db == null) throw Exception('Database is not initialized');
      List<Map<String, dynamic>> result = await db!.query('data');
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to extract raw data: $e');
    }
  }

  // Save multiple key-value pairs in the SQLite database
  @override
  Future<void> saveData(Map<String, Object> data) async {
    try {
      if (db == null) throw Exception('Database is not initialized');
      for (var entry in data.entries) {
        String key = entry.key;
        String jsonData = jsonEncode(entry.value);

        await db!.insert(
          'data',
          {'key': key, 'data': jsonData},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      throw Exception('Failed to save data: $e');
    }
  }

  // Extract all data from the SQLite database
  @override
  Future<Map<String, Object>> extractData() async {
    try {
      if (db == null) throw Exception('Database is not initialized');
      List<Map<String, dynamic>> result = await db!.query('data');
      Map<String, Object> extractedData = {};
      for (var row in result) {
        extractedData[row['key']] = jsonDecode(row['data']);
      }
      return extractedData;
    } catch (e) {
      throw Exception('Failed to extract data: $e');
    }
  }

  // Get data for a key from the SQLite database
  @override
  Future<Map<String, Object>> get(String key) async {
    try {
      if (db == null) throw Exception('Database is not initialized');
      List<Map<String, dynamic>> result = await db!.query(
        'data',
        where: 'key = ?',
        whereArgs: [key],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return jsonDecode(result.first['data']);
      }

      return {};
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  // Set data for a key in the SQLite database
  @override
  Future<void> set(String key, Map<String, Object> data) async {
    try {
      if (db == null) throw Exception('Database is not initialized');
      String jsonData = jsonEncode(data);

      await db!.insert(
        'data',
        {'key': key, 'data': jsonData},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Failed to set data: $e');
    }
  }

  // Remove a row from the SQLite database for a specific key
  @override
  Future<void> remove(String key) async {
    try {
      if (db == null) throw Exception('Database is not initialized');
      await db!.delete(
        'data',
        where: 'key = ?',
        whereArgs: [key],
      );
    } catch (e) {
      throw Exception('Failed to remove data: $e');
    }
  }
}
