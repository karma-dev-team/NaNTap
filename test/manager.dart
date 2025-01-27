import 'package:flutter_test/flutter_test.dart';
import 'package:progress/manager.dart';

void main() {
  group('Manager Tests', () {
    late Manager manager;

    setUp(() {
      manager = Manager();
    });

    test('Initializes correctly', () {
      expect(manager.state.level, equals(1));
    });

    test('Handles invalid progress input', () {
      expect(() => manager.updateProgress(-10), throwsA(isA<ArgumentError>()));
    });
  });
}
