import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';
import 'package:nantap/progress/state.dart';

class UpgradesRegistry implements AbstractUpgradesRegistry {
  Set<Upgrade> upgrades = {};
  DateTime lastUpdated = DateTime.now();

  UpgradesRegistry(this.upgrades);

  @override
  void addUpgrade(Upgrade upgrade) {
    upgrades.add(upgrade);
    lastUpdated = DateTime.now();
  }

  @override
  bool checkUpgrade(String upgradeId) {
    // Check if the upgrade exists in the registry
    return upgrades.any((upgrade) => upgrade.upgradeId == upgradeId);
  }

  @override
  void syncUpgradesWithState(GlobalState state) {
    // Sync upgrades in the registry with those in the GlobalState
    for (var upgrade in state.upgrades) {
      if (!upgrades.contains(upgrade)) {
        upgrades.add(upgrade);
      }
    }
    lastUpdated = DateTime.now();
  }

  static UpgradesRegistry fromJson() {
    return UpgradesRegistry({});
  }
}
