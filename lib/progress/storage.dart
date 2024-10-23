import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:nantap/progress/interfaces.dart';

class SQLiteStorage implements AbstractStorage {
  Database? db;

  // Initialize and open the SQLite database
  @override
  Future<void> setup() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'general.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the data table if it doesn't exist
        await db.execute('''
          CREATE TABLE data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key TEXT,
            data TEXT
          )
        ''');
      },
    );
  }

  // Get a specific field's raw data for a key from the SQLite database
  @override
  Future<String> getRaw(String key) async {
    try {
      List<Map<String, dynamic>> result = await db!.query(
        'data',
        where: 'key = ?',
        whereArgs: [key],
        limit: 1,
      );

      if (result.isNotEmpty) {
        var dataMap = jsonDecode(result.first['data']) as Map<String, dynamic>;
        return dataMap.toString();
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
      List<Map<String, dynamic>> result = await db!.query('data');

      List<Map<String, dynamic>> extractedData = result.map((row) {
        return {
          'key': row['key'],
          'data': jsonDecode(row['data']),
        };
      }).toList();

      return jsonEncode(extractedData);
    } catch (e) {
      throw Exception('Failed to extract raw data: $e');
    }
  }

  // Save data for a key in the SQLite database
  @override
  Future<void> saveData(Map<String, Object> data) async {
    try {
      await Future.forEach(data.entries, (MapEntry<String, Object> entry) async {
        String key = entry.key;
        String jsonData = jsonEncode(entry.value);

        // Check if the key already exists
        List<Map<String, dynamic>> existingRow = await db!.query(
          'data',
          where: 'key = ?',
          whereArgs: [key],
          limit: 1,
        );

        if (existingRow.isNotEmpty) {
          // Update the existing row
          await db!.update(
            'data',
            {'data': jsonData},
            where: 'key = ?',
            whereArgs: [key],
          );
        } else {
          // Insert a new row
          await db!.insert('data', {
            'key': key,
            'data': jsonData,
          });
        }
      });
    } catch (e) {
      throw Exception('Failed to save data: $e');
    }
  }

  // Extract all data from the SQLite database
  @override
  Future<Map<String, Object>> extractData() async {
    try {
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
      String jsonData = jsonEncode(data);

      // Check if the key already exists
      List<Map<String, dynamic>> existingRow = await db!.query(
        'data',
        where: 'key = ?',
        whereArgs: [key],
        limit: 1,
      );

      if (existingRow.isNotEmpty) {
        // Update the existing row
        await db!.update(
          'data',
          {'data': jsonData},
          where: 'key = ?',
          whereArgs: [key],
        );
      } else {
        // Insert a new row
        await db!.insert('data', {
          'key': key,
          'data': jsonData,
        });
      }
    } catch (e) {
      throw Exception('Failed to set data: $e');
    }
  }

  // Remove a row from the SQLite database for a specific key
  @override
  Future<void> remove(String key) async {
    try {
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
