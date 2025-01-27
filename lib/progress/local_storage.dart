import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String userIdKey = 'userId';

  // Save the userId locally
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  // Load the userId from local storage
  static Future<String?> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // Clear the userId from local storage
  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
  }
}
