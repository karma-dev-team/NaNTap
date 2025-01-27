import 'package:flutter_test/flutter_test.dart';
import 'package:progress/upgrade.dart';

void main() {
  group('Upgrade Tests', () {
    test('Upgrade initializes correctly', () {
      final upgrade = Upgrade(name: 'Speed Boost', cost: 100, effect: 2.0);
      expect(upgrade.name, equals('Speed Boost'));
      expect(upgrade.cost, equals(100));
      expect(upgrade.effect, equals(2.0));
    });

    test('Apply upgrade returns correct result', () {
      final upgrade = Upgrade(name: 'Speed Boost', cost: 100, effect: 2.0);
      final result = upgrade.apply(5);
      expect(result, equals(10)); // Assuming effect multiplies the input
    });
  });
}
