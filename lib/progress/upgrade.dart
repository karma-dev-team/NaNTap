import 'dart:math';

import 'package:nantap/progress/interfaces.dart';

class Upgrade<E> { 
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

  int earn({int booster = 0}) { 
    return (this.level * this.baseEarning) + (booster * this.boostedTimes); 
  }

  num get levelUpPrice => pow((this.level * this.cost), 1.4); 

  void addLevel({int levels = 1}) { 
    this.level += levels;
  }

  void buyUpgrade(AbstractWallet wallet, {int quantity = 1}) { 
    wallet.decrease((quantity * this.level).toDouble()); 
    this.addLevel(levels: quantity); 
  }
}