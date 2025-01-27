import 'package:flutter_test/flutter_test.dart';
import 'package:progress/upgrades_registry.dart';
import 'package:progress/upgrade.dart';

void main() {
  group('UpgradesRegistry Tests', () {
    late UpgradesRegistry registry;

    setUp(() {
      registry = UpgradesRegistry();
    });

    test('Add and retrieve upgrades works', () {
      final upgrade = Upgrade(name: 'Speed Boost', cost: 100, effect: 2.0);
      registry.addUpgrade(upgrade);
      expect(registry.getUpgrades(), contains(upgrade));
    });

    test('Retrieve specific upgrade works', () {
      final upgrade = Upgrade(name: 'Speed Boost', cost: 100, effect: 2.0);
      registry.addUpgrade(upgrade);
      final result = registry.getUpgrade('Speed Boost');
      expect(result, equals(upgrade));
    });

    test('Non-existent upgrade returns null', () {
      final result = registry.getUpgrade('Non Existent');
      expect(result, isNull);
    });
  });
}
