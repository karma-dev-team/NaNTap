import 'package:nantap/progress/upgrade.dart';

class UpgradesRegistry { 
  Set<Upgrade> upgrades = {}; 
  DateTime lastUpdated = DateTime.now(); 

  UpgradesRegistry(this.upgrades); 

  static UpgradesRegistry buildFromSaveData() { 
    return UpgradesRegistry({}); 
  }
}