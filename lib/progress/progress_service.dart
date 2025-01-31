import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nantap/progress/state.dart';

class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Получаем текущий userId
  String? get _userId => _auth.currentUser?.uid;

  /// **Сохранение прогресса**
  Future<void> saveProgress(GlobalState state) async {
    if (_userId == null) return;
    
    try {
      await _firestore.collection('users').doc(_userId).set(state.toJson());
    } catch (e) {
      print("Ошибка при сохранении прогресса: $e");
    }
  }

  /// **Загрузка прогресса**
  Future<GlobalState?> loadProgress() async {
    if (_userId == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(_userId).get();
      if (doc.exists && doc.data() != null) {
        return GlobalState.fromJson(doc.data()!);
      }
    } catch (e) {
      print("Ошибка при загрузке прогресса: $e");
    }

    return null;
  }
}
