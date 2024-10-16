import 'dart:ffi';

import 'package:nantap/progress/company.dart';
import 'package:nantap/progress/upgrade.dart';

class GlobalState { 
  int level; 
  Long breadCount;
  List<Upgrade> upgrades = [];
  // Компании
  List<Company> companies = []; 
  
  GlobalState(this.level, this.breadCount, this.upgrades); 
}