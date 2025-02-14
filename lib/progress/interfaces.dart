

import 'package:nantap/progress/state.dart';
import 'package:nantap/progress/upgrade.dart';

abstract class AbstractProgressManager {
  /// Saves the player's progress to storage.
  Future<void> saveProgress();

  /// Manages upgrades for the player.
  void levelUpUpgrade(String upgradeId, int level);

  AbstractUpgradesRegistry getUpgradesRegistry();

  GlobalState getState();   

  AbstractAchievmentManager getAchievmentManager(); 

  AbstractStorage getStorage(); 

  /// Calculates the total earnings from upgrades and companies.
  double calculateTotalEarnings();

  /// Checks and updates achievements based on the current state.
  void checkAchievements();
}

abstract class AbstractUpgradesRegistry {
  /// Adds a list of upgrades to the registry.
  void addUpgrade(Upgrade upgrade);

  /// checks upgrades 
  bool checkUpgrade(String id);

  Set<Upgrade> getUpgrades();

  void syncUpgradesWithState(GlobalState state);
}

abstract class AbstractAchievmentManager { 
  void addAchievment(AbstractAchievment achievment);
  void checkState(GlobalState state);
} 

abstract class AbstractAchievment {  
  int? check(GlobalState state); 
  String getAchievmentId(); 
  Map<String, Object> getData(); 
  AbstractAchievment? fromJson(Map<String, Object> data);  
}

abstract class AbstractStorage {
  Future<void> setup();

  Future<void> saveData(Map<String, dynamic> data);

  Future<Map<String, dynamic>> extractData();

  Future<Map<String, dynamic>> get(String key);

  Future<void> set(String key, Map<String, dynamic> data);

  Future<void> remove(String key);

  Future<String> getRaw(String key);

  Future<String> extractRaw();
}


abstract class MoneyEarner { 
  double breadEarned();
  double tapBooster(); 
  void levelUpUpgrade(String upgradeId, int levels); 
}

abstract class AbstractWallet { 
  double getAmount(); 
  bool increase(double amount); 
  bool decrease(double amount); 
}