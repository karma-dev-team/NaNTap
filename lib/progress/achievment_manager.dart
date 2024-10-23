import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/state.dart';

class AchievmentManager implements AbstractAchievmentManager {
  List<AbstractAchievment> globalAchievements = [];
  AbstractStorage storage;

  AchievmentManager(this.storage);

  @override
  void addAchievment(AbstractAchievment achievement) {
    globalAchievements.add(achievement);
  }

  @override
  void checkState(GlobalState state) {
    for (var achievement in globalAchievements) {
      var activated = achievement.check(state);
      if (activated != null) {
        // Handle achievement completed logic, e.g., notify user, grant rewards, etc.
      }
    }
  }

  Future<void> restoreAchievements() async {
    Map<String, Object> savedData = await storage.extractData();

    var achievementList = savedData['achievements'] as List<dynamic>;
    for (var achData in achievementList) {
      for (var achievement in globalAchievements) {
        var restoredAchievement = achievement.fromJson(achData as Map<String, Object>);
        if (restoredAchievement != null) {
          globalAchievements.add(restoredAchievement);
        }
      }
    }
  }

  Future<void> saveAchievements() async {
    List<Map<String, Object>> achievementData = [];
    for (var achievement in globalAchievements) {
      achievementData.add(achievement.getData());
    }

    await storage.saveData({
      'achievements': achievementData,
    });
  }
}
