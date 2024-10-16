

import 'package:nantap/progress/state.dart';

abstract class AbstractProgressManager { 

}

abstract class AbstractAchievmentManager { 
  void addAchievment(AbstractAchievment achievment);


}


abstract class AbstractAchievment { 
  AbstractAchievment? buildFromSaveData(Map<String, Object> data);   
  int? check(GlobalState state);   
}

abstract class AbstractStorage { 
  void saveData(Map<String, Object> data); 
  Map<String, Object> extractData(); 
}

abstract class MoneyEarner { 
  double collectMoney();
}

abstract class AbstractWallet { 
  void increase(double amount); 
  void decrease(double amount); 
}