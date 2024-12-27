import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class CompanyBranches implements MoneyEarner {
  List<Upgrade> upgrades;

  CompanyBranches(this.upgrades);

  factory CompanyBranches.fromJson(Map<String, dynamic> json) {
    var upgradesFromJson = json['upgrades'] as List<dynamic>;
    List<Upgrade> upgrades = upgradesFromJson.map((upgradeJson) => Upgrade.fromJson(upgradeJson)).toList();

    return CompanyBranches(upgrades);
  }

  @override
  double breadEarned() {
    double result = 0;

    for (var upgrade in upgrades) {
      result += upgrade.earn();
    }

    return result;
  }

  void levelUpUpgrade(String upgradeId, int levels) { 
    for (var upg in upgrades) { 
      if (upg.upgradeId == upgradeId) { 
        upg.level += levels; 
      }
    }
  }

  @override
  double tapBooster() {
    double result = 0;

    for (var upgrade in upgrades) {
      result += upgrade.earnTapStrength();
    }

    return result;
  }
}
