import 'dart:math';

import 'package:nantap/progress/interfaces.dart';

class Upgrade { 
  String upgradeId; 
  String displayName;
  String description; 
  int level = 0; 
  double cost;  
  int baseEarning; 
  int boostedTimes = 0;  

  Upgrade(this.upgradeId, this.displayName, this.description, this.cost, this.baseEarning); 

  @override
  bool operator ==(Object other) =>
      other is Upgrade && this.upgradeId == other.upgradeId; 
  @override 
  int get hashCode => Object.hash(this.upgradeId, this.displayName);

  double earn({int booster = 0}) { 
    return ((this.level * this.baseEarning) + (booster * this.boostedTimes)).toDouble(); 
  }

  num get levelUpPrice => pow((this.level * this.cost), 1.4); 

  void addLevel({int levels = 1}) { 
    this.level += levels;
  }

  void buyUpgrade(AbstractWallet wallet, {int quantity = 1}) { 
    wallet.decrease((quantity * this.level).toDouble()); 
    this.addLevel(levels: quantity); 
  }

  static Upgrade? buildFromSaveData(Map<String, Object> data) {  
    var upgradeId = data['upgradeId'].toString(); 
    var displayName = data['displayName'].toString(); 
    var description = data['description'].toString(); 
    var cost = double.tryParse(data['cost'].toString()); 
    if (cost == null) { 
      return null; 
    } // TODO
    var baseEarning = int.tryParse(data['baseEarning'].toString());  
    if (baseEarning == null) { 
      return null; 
    }
    var upgrade = Upgrade(upgradeId, displayName, description, cost, baseEarning);

    return upgrade; 
  }
}