import 'dart:math';

import 'package:nantap/progress/achievment_manager.dart';
import 'package:nantap/progress/company.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/state.dart';
import 'package:nantap/progress/upgrade.dart';
import 'package:nantap/progress/upgrades_registry.dart';

class ProgressManager implements AbstractProgressManager {
  GlobalState state = new GlobalState(0, 0, [], [], []);
  AbstractStorage storage;
  AbstractAchievmentManager achievementManager;
  AbstractUpgradesRegistry upgradesRegistry = UpgradesRegistry({});

  ProgressManager(
    this.storage, 
    this.achievementManager, 
  );

  @override
  Future<void> saveProgress() async {
    // Save the current state to storage
    await storage.saveData({
      'level': state.level,
      'breadCount': state.breadCount,
      'upgrades': state.upgrades.map((u) => {
        'upgradeId': u.upgradeId,
        'level': u.level,
        'baseEarning': u.baseEarning,
        'cost': u.cost,
        'description': u.description,
        'displayName': u.displayName
      }).toList(),
      'companies': state.companies.map((c) => {
        'upgrades': c.upgrades.map((u) => u.upgradeId).toList(),
        'branches': c.branches.map((b) => {
          'upgrades': b.upgrades.map((u) => u.upgradeId).toList(),
        }).toList(),
      }).toList(),
      'achievements': state.achievements,
    });
  }

  @override
  void levelUpUpgrade(String upgradeId, int level) {
    // Check if the upgrade exists in the state
    if (!upgradesRegistry.checkUpgrade(upgradeId)) {
      throw Exception("Upgrade with ID $upgradeId not found in the registry.");
    }

    var upgrade = state.upgrades.firstWhere(
      (u) => u.upgradeId == upgradeId,
      orElse: () => throw Exception("Upgrade not found")
    );

    upgrade.buyUpgrade(state, quantity: level); 
  }

  @override
  double calculateTotalEarnings() {
    double totalEarnings = 0;

    // Calculate earnings from upgrades
    for (var upgrade in state.upgrades) {
      totalEarnings += upgrade.earn();
    }

    // Calculate earnings from companies and branches
    for (var company in state.companies) {
      totalEarnings += company.breadEarned();
    }

    return totalEarnings;
  }

  @override
  void checkAchievements() {
    // Use achievement manager to check and update achievements
    achievementManager.checkState(state);
  }

  @override
  GlobalState getState() {
    return state;
  }

  /// Restores player progress from storage.
  Future<void> restoreProgress() async {
    var savedData = await storage.extractData();

    // Restore state properties from saved data
    state.level = savedData['level'] as int;
    state.breadCount = savedData['breadCount'] as double;

    // Restore upgrades
    var upgradesList = savedData['upgrades'] as List<dynamic>;
    state.upgrades = upgradesList.map((u) => Upgrade.fromJson(u)).toList();

    // Sync the restored upgrades with the upgrades registry
    upgradesRegistry.syncUpgradesWithState(state);

    // Restore companies
    var companiesList = savedData['companies'] as List<dynamic>;
    state.companies = companiesList.map((c) => Company.fromJson(c)).toList();

    // Restore achievements
    // state.achievements = List<String>.from(savedData['achievements']);
  }
}
