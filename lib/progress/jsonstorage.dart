import 'package:json_store/json_store.dart';
import 'package:nantap/progress/interfaces.dart';

class JsonStorage implements AbstractStorage {
  final JsonStore _store = JsonStore();
  final String keyPrefix;

  JsonStorage({this.keyPrefix = ''}); // Можно указать префикс ключей, например, "progress-".

  @override
  Future<void> setup() async {
    // json_store не требует явной настройки.
  }

  /// **Сохранение данных** (исправлено, теперь сохраняем корректный JSON)
  @override
  Future<void> saveData(Map<String, dynamic> data) async {
    for (var key in data.keys) {
      var value = {'value': data[key]}; // Оборачиваем в JSON

      print("СОХРАНЯЕМ ДАННЫЕ [$key]: $value"); // Логируем перед сохранением

      try {
        await _store.setItem('$keyPrefix$key', value);
      } catch (e) {
        print("ОШИБКА ПРИ СОХРАНЕНИИ [$key]: $e"); // Лог ошибки
      }
    }
  }

  /// **Извлечение всех данных**
  @override
  Future<Map<String, dynamic>> extractData() async {
    final List<Map<String, dynamic>> jsonList = await _store.getListLike('$keyPrefix%') ?? [];
    Map<String, dynamic> allData = {};

    for (var item in jsonList) {
      if (item.containsKey('_id')) {
        String key = item['_id'];
        allData[key.replaceFirst(keyPrefix, '')] = item['value'];
      }
    }

    return allData;
  }

  /// **Получение одного элемента по ключу**
  @override
  Future<Map<String, dynamic>> get(String key) async {
    final data = await _store.getItem('$keyPrefix$key');
    return data != null && data.containsKey('value') ? {'value': data['value']} : {};
  }

  /// **Сохранение конкретного элемента**
  @override
  Future<void> set(String key, Map<String, dynamic> data) async {
    await _store.setItem('$keyPrefix$key', {'value': data});
  }

  /// **Удаление элемента по ключу**
  @override
  Future<void> remove(String key) async {
    await _store.deleteItem('$keyPrefix$key');
  }

  /// **Получение сырых данных по ключу**
  @override
  Future<String> getRaw(String key) async {
    final data = await _store.getItem('$keyPrefix$key');
    return data != null && data.containsKey('value') ? data['value'].toString() : '';
  }

  /// **Извлечение всех данных в виде строки**
  @override
  Future<String> extractRaw() async {
    final extractedData = await extractData();
    return extractedData.toString();
  }
}
