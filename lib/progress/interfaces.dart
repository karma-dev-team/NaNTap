

import 'package:nantap/progress/state.dart';

abstract class AbstractProgressManager { 

}

abstract class AbstractAchievmentManager { 
  void addAchievment(AbstractAchievment achievment);
  void checkState(GlobalState state);

} 

abstract class AchievmentScheme { 
  String getAchievmentId();
  AbstractAchievment? buildFromSaveData(Map<String, Object> data);  
  Map<String, Object> export(); 
}
 
abstract class AbstractAchievment {  
  int? check(GlobalState state); 
}

abstract class AbstractStorage { 
  void saveData(Map<String, Object> data); 
  Map<String, Object> extractData(); 
}

abstract class MoneyEarner { 
  double breadEarned();
}

abstract class AbstractWallet { 
  void increase(double amount); 
  void decrease(double amount); 
}