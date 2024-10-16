import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class CompanyBranches implements MoneyEarner { 
  List<Upgrade> upgrades = []; 

  @override
  double breadEarned() { 
    return 0; 
  }
}