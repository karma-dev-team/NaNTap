import 'package:nantap/progress/company_branches.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class Company implements MoneyEarner { 
  List<Upgrade> upgrades = []; 
  // филиалы компании
  List<CompanyBranches> branches = []; 

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