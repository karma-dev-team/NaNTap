import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/state.dart';

class Achievement implements AbstractAchievment {
  String achievementId;
  String description;
  int progress;  // Current progress for this achievement
  int goal;      // The goal needed to complete this achievement

  Achievement({
    required this.achievementId,
    required this.description,
    required this.progress,
    required this.goal,
  });

  @override
  int? check(GlobalState state) {
    // Example logic for checking if the achievement is complete
    // You can adjust this based on what "state" you need to check
    if (state.breadCount >= goal) {
      return progress = goal; // Achievement complete
    } else {
      progress = state.breadCount.toInt(); // Update progress
    }
    return null;
  }

  @override
  String getAchievmentId() {
    return achievementId;
  }

  @override
  Map<String, Object> getData() {
    return {
      'achievmentId': achievementId,
      'description': description,
      'progress': progress,
      'goal': goal,
    };
  }

  @override
  AbstractAchievment? fromJson(Map<String, Object> data) {
    if (data['achievmentId'] == achievementId) {
      return Achievement(
        achievementId: data['achievmentId'].toString(),
        description: data['description'].toString(),
        progress: data['progress'] as int,
        goal: data['goal'] as int,
      );
    }
    return null;
  }
}
