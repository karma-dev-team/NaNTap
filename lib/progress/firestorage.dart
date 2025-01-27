import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nantap/progress/interfaces.dart';

class FirestoreStorage implements AbstractStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName;

  FirestoreStorage({this.collectionName = 'default_storage'});

  @override
  Future<void> setup() async {
    // Firestore не требует явной настройки в коде.
  }

  @override
  Future<void> saveData(Map<String, dynamic> data) async {
    for (var key in data.keys) {
      await _firestore.collection(collectionName).doc(key).set(data[key]);
    }
  }

  @override
  Future<Map<String, dynamic>> extractData() async {
    final querySnapshot = await _firestore.collection(collectionName).get();
    return {for (var doc in querySnapshot.docs) doc.id: doc.data()};
  }

  @override
  Future<Map<String, dynamic>> get(String key) async {
    final doc = await _firestore.collection(collectionName).doc(key).get();
    return doc.exists ? doc.data() ?? {} : {};
  }

  @override
  Future<void> set(String key, Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).doc(key).set(data);
  }

  @override
  Future<void> remove(String key) async {
    await _firestore.collection(collectionName).doc(key).delete();
  }

  @override
  Future<String> getRaw(String key) async {
    final doc = await _firestore.collection(collectionName).doc(key).get();
    return doc.exists ? doc.data().toString() : '';
  }

  @override
  Future<String> extractRaw() async {
    final data = await extractData();
    return data.toString();
  }
}
