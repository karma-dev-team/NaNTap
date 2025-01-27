import 'package:flutter_test/flutter_test.dart';
import 'package:progress/state.dart';

void main() {
  group('ProgressState Tests', () {
    test('Default state is initialized correctly', () {
      final state = ProgressState();
      expect(state.level, equals(1));
      expect(state.progress, equals(0));
    });

    test('State updates correctly', () {
      final state = ProgressState();
      state.updateProgress(50);
      expect(state.progress, equals(50));
    });

    test('State resets correctly', () {
      final state = ProgressState()..updateProgress(50);
      state.reset();
      expect(state.progress, equals(0));
      expect(state.level, equals(1));
    });
  });
}
