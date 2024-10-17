

import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/state.dart';

class AchievmentManager implements AbstractAchievmentManager { 
  List<AbstractAchievment> globalAchievments = [];  

  @override
  void addAchievment(AbstractAchievment achiv) { 

  }

  @override
  void checkState(GlobalState state) { 
    for (var ach in globalAchievments) { 
      var activated = ach.check(state); 
      
    }
  }
}