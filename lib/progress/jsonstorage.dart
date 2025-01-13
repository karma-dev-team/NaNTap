import 'package:json_store/json_store.dart';
import 'package:nantap/progress/interfaces.dart';

class JsonStorage implements AbstractStorage {
  final JsonStore _store = JsonStore();
  final String keyPrefix;

  JsonStorage({this.keyPrefix = ''}); // Можно указать префикс ключей, например, "messages-".

  @override
  Future<void> setup() async {
    // json_store не требует явной настройки.
  }

  @override
  Future<void> saveData(Map<String, dynamic> data) async {
    // Сохраняем данные с использованием префикса.
    for (var key in data.keys) {
      await _store.setItem('$keyPrefix$key', data[key]);
    }
  }

  @override
  Future<Map<String, dynamic>> extractData() async {
    // Получаем все данные, соответствующие шаблону ключей.
    final List<Map<String, dynamic>> jsonList = await _store.getListLike('$keyPrefix%') ?? [];
    Map<String, dynamic> allData = {};

    for (var item in jsonList) {
      if (item.containsKey('_id')) {
        // Извлекаем ключ из служебного поля `_id`.
        String key = item['_id'];
        allData[key.replaceFirst(keyPrefix, '')] = item..remove('_id');
      }
    }

    return allData;
  }

  @override
  Future<Map<String, dynamic>> get(String key) async {
    // Получаем элемент по ключу с учётом префикса.
    return (await _store.getItem('$keyPrefix$key')) ?? {};
  }

  @override
  Future<void> set(String key, Map<String, dynamic> data) async {
    // Устанавливаем элемент с ключом и префиксом.
    await _store.setItem('$keyPrefix$key', data);
  }

  @override
  Future<void> remove(String key) async {
    // Удаляем элемент по ключу с учётом префикса.
    await _store.deleteItem('$keyPrefix$key');
  }

  @override
  Future<String> getRaw(String key) async {
    // Получаем "сырые" данные по ключу.
    final data = await _store.getItem('$keyPrefix$key');
    return data != null ? data.toString() : '';
  }

  @override
  Future<String> extractRaw() async {
    // Извлекаем все данные в сыром виде.
    final extractedData = await extractData();
    return extractedData.toString();
  }
}
