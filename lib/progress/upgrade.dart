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
  int? tapStrengthBoost = 0; 
  String imagePath;

  Upgrade(this.upgradeId, this.displayName, this.description, this.cost, this.baseEarning, this.imagePath, [this.tapStrengthBoost]);

  @override
  bool operator ==(Object other) =>
      other is Upgrade && upgradeId == other.upgradeId;
  @override
  int get hashCode => Object.hash(upgradeId, displayName);

  double earn({int booster = 0}) {
    return ((level * baseEarning) + (booster * boostedTimes)).toDouble();
  }

  int earnTapStrength() { 
    return tapStrengthBoost ?? 0 * level; 
  }

  double get levelUpPrice => pow((level * cost), 1.4).toDouble();

  void addLevel({int levels = 1}) {
    level += levels;
  }

  void buyUpgrade(AbstractWallet wallet, {int quantity = 1}) {
    wallet.decrease((quantity * level).toDouble());
    addLevel(levels: quantity);
  }

  static Upgrade fromJson(Map<String, Object> data) {
    var upgradeId = data['upgradeId'].toString();
    var displayName = data['displayName'].toString();
    var description = data['description'].toString();
    var cost = double.parse(data['cost'].toString());
    var baseEarning = int.parse(data['baseEarning'].toString());
    var imagePath = data['imagePath'].toString();
    var upgrade = Upgrade(upgradeId, displayName, description, cost, baseEarning, imagePath);

    return upgrade;
  }
}