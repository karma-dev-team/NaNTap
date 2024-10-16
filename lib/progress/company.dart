import 'package:nantap/progress/company_branches.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class Company extends MoneyEarner { 
  List<Upgrade> upgrades = []; 
  // филиалы компании
  List<CompanyBranches> branches = []; 

  double collectMoney() { 
    double result = 0; 

    for (var upgrade in this.upgrades)

    for (var upgrade in this.upgrades) { 
      result += upgrade.earn(); 
    }

    return result; 
  }
}