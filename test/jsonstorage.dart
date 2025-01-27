import 'package:flutter_test/flutter_test.dart';
import 'package:progress/jsonstorage.dart';

void main() {
  group('JsonStorage Tests', () {
    late JsonStorage storage;

    setUp(() {
      storage = JsonStorage();
    });

    test('Save and retrieve data works', () {
      storage.save('key', {'data': 123});
      final result = storage.load('key');
      expect(result, equals({'data': 123}));
    });

    test('Returns null for missing key', () {
      final result = storage.load('non_existent_key');
      expect(result, isNull);
    });

    test('Clears data correctly', () {
      storage.save('key', {'data': 123});
      storage.clear();
      final result = storage.load('key');
      expect(result, isNull);
    });
  });
}
