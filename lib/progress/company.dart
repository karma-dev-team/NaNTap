import 'package:nantap/progress/company_branches.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class Company implements MoneyEarner {
  String name;
  List<Upgrade> upgrades = [];
  List<CompanyBranches> branches = [];

  Company(this.name, this.upgrades, this.branches);

  // Factory constructor to create an instance from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    // Parsing upgrades from JSON
    var upgradesFromJson = json['upgrades'] as List<dynamic>;
    List<Upgrade> upgrades =
        upgradesFromJson.map((upgradeJson) => Upgrade.fromJson(upgradeJson)).toList();

    // Parsing branches from JSON
    var branchesFromJson = json['branches'] as List<dynamic>;
    List<CompanyBranches> branches =
        branchesFromJson.map((branchJson) => CompanyBranches.fromJson(branchJson)).toList();

    var name = json['name'] as String;

    return Company(name, upgrades, branches);
  }

  @override
  double breadEarned() {
    double result = 0;

    for (var branch in branches) {
      result += branch.breadEarned();
    }

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

    for (var branch in branches) {
      result += branch.tapBooster();
    }

    for (var upgrade in upgrades) {
      result += upgrade.earnTapStrength();
    }

    return result;
  }

  // Convert Company to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'upgrades': upgrades.map((upgrade) => upgrade.toJson()).toList(),
      'branches': branches.map((branch) => branch.toJson()).toList(),
    };
  }
}
