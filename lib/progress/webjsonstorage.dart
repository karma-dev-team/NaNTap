import 'dart:convert';
import 'dart:html';
import 'package:nantap/progress/interfaces.dart';

class WebJsonStorageAdapter implements AbstractStorage {
  final Storage _storage = window.localStorage;

  // Инициализация хранилища (для веб ничего не нужно)
  @override
  Future<void> setup() async {
    // No setup needed for localStorage
  }

  // Получение данных в сыром виде по ключу
  @override
  Future<String> getRaw(String key) async {
    return _storage[key] ?? '';
  }

  // Экспорт всех данных в сыром виде
  @override
  Future<String> extractRaw() async {
    final Map<String, dynamic> allData = {};
    for (var i = 0; i < _storage.length; i++) {
      final key = _storage.keys.elementAt(i);
      allData[key] = jsonDecode(_storage[key]!);
    }
    return jsonEncode(allData);
  }

  // Сохранение нескольких пар ключ-значение
  @override
  Future<void> saveData(Map<String, Object> data) async {
    data.forEach((key, value) {
      _storage[key] = jsonEncode(value);
    });
  }

  // Извлечение всех данных
  @override
  Future<Map<String, Object>> extractData() async {
    final Map<String, Object> allData = {};
    for (var i = 0; i < _storage.length; i++) {
      final key = _storage.keys.elementAt(i);
      allData[key] = jsonDecode(_storage[key]!);
    }
    return allData;
  }

  // Получение данных по ключу
  @override
  Future<Map<String, Object>> get(String key) async {
    final data = _storage[key];
    if (data != null) {
      return jsonDecode(data);
    }
    return {};
  }

  // Установка данных по ключу
  @override
  Future<void> set(String key, Map<String, Object> data) async {
    _storage[key] = jsonEncode(data);
  }

  // Удаление данных по ключу
  @override
  Future<void> remove(String key) async {
    _storage.remove(key);
  }
}
