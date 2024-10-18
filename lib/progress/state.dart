import 'dart:ffi';

import 'package:nantap/pages/acievments.dart';
import 'package:nantap/progress/company.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class GlobalState { 
  int level; 
  double breadCount;
  List<Upgrade> upgrades = [];
  // Компании
  List<Company> companies = []; 
  List<String> achievments = []; 
  
  GlobalState(this.level, this.breadCount, this.upgrades); 

  void addLevel(int leveltoAdd) { 
    level += leveltoAdd; 
  }

  void addBread(double bread) { 
    breadCount = breadCount + bread; 
  }

  double calcBread() { 
    double result = 0;

    for (var upgrade in upgrades) { 
      result += upgrade.earn(); 
    } 

    for (var company in companies) { 
      result += company.breadEarned(); 
    }

    return result; 
  }
}