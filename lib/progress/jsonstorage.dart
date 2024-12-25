import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:nantap/progress/interfaces.dart';

class JsonStorageAdapter implements AbstractStorage {
  late File _jsonFile;
  late Map<String, dynamic> _storage;

  // Инициализация JSON-хранилища
  @override
  Future<void> setup() async {
    final directory = await getApplicationDocumentsDirectory();
    _jsonFile = File('${directory.path}/storage.json');

    // Если файл не существует, создаём его с пустым JSON
    if (await _jsonFile.exists()) {
      final content = await _jsonFile.readAsString();
      _storage = jsonDecode(content);
    } else {
      _storage = {};
      await _saveToFile();
    }
  }

  // Получение данных в сыром виде по ключу
  @override
  Future<String> getRaw(String key) async {
    return jsonEncode(_storage[key] ?? '');
  }

  // Экспорт всех данных в сыром виде
  @override
  Future<String> extractRaw() async {
    return jsonEncode(_storage);
  }

  // Сохранение нескольких пар ключ-значение
  @override
  Future<void> saveData(Map<String, Object> data) async {
    _storage.addAll(data);
    await _saveToFile();
  }

  // Извлечение всех данных
  @override
  Future<Map<String, Object>> extractData() async {
    return Map<String, Object>.from(_storage);
  }

  // Получение данных по ключу
  @override
  Future<Map<String, Object>> get(String key) async {
    if (_storage.containsKey(key)) {
      return Map<String, Object>.from(_storage[key]);
    }
    return {};
  }

  // Установка данных по ключу
  @override
  Future<void> set(String key, Map<String, Object> data) async {
    _storage[key] = data;
    await _saveToFile();
  }

  // Удаление данных по ключу
  @override
  Future<void> remove(String key) async {
    _storage.remove(key);
    await _saveToFile();
  }

  // Сохранение данных в файл
  Future<void> _saveToFile() async {
    final content = jsonEncode(_storage);
    await _jsonFile.writeAsString(content);
  }
}
