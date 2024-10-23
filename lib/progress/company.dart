import 'package:nantap/progress/company_branches.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class Company implements MoneyEarner {
  List<Upgrade> upgrades = [];
  List<CompanyBranches> branches = [];

  Company(this.upgrades, this.branches);

  // Factory constructor to create an instance from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    // Parsing upgrades from JSON
    var upgradesFromJson = json['upgrades'] as List<dynamic>;
    List<Upgrade> upgrades = upgradesFromJson.map((upgradeJson) => Upgrade.fromJson(upgradeJson)).toList();

    // Parsing branches from JSON
    var branchesFromJson = json['branches'] as List<dynamic>;
    List<CompanyBranches> branches = branchesFromJson.map((branchJson) => CompanyBranches.fromJson(branchJson)).toList();

    return Company(upgrades, branches);
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
}