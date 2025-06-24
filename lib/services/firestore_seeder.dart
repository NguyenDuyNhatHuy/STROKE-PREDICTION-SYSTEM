import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeeder {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Seed nhiều bản ghi predictionHistories một lần
  Future<void> seedPredictions(List<Map<String, dynamic>> data) async {
    final batch = _db.batch();
    final col   = _db.collection('predictionHistories');
    for (var record in data) {
      final docRef = col.doc();
      batch.set(docRef, {
        ...record,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }

  // Thêm user vào 'users' (không lưu mật khẩu thô)
  Future<void> addUser({
    required String userId,
    required String name,
    required String email,
  }) {
    return _db.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
  Future<void> saveOtp({
    required String userId,
    required String code,
  }) {
    return _db.collection('emailOtps').doc(userId).set({
      'code': code,
      'expiresAt': DateTime.now().add(const Duration(minutes: 10)),
    });
  }

  Future<bool> verifyOtp({
    required String userId,
    required String code,
  }) async {
    final doc = await _db.collection('emailOtps').doc(userId).get();
    if (!doc.exists) return false;
    final data = doc.data()!;
    final expires = (data['expiresAt'] as Timestamp).toDate();
    if (DateTime.now().isAfter(expires)) return false;
    return data['code'] == code;
  }
  // Thêm một bản ghi prediction mới
  Future<void> addPrediction({
    required String userId,
    required String gender,
    required int age,
    required bool hypertension,
    required bool heartDisease,
    required String everMarried,
    required String workType,
    required String residenceType,
    required double avgGlucoseLevel,
    required double bmi,
    required String smokingStatus,
    required bool stroke,
  }) {
    return _db.collection('predictionHistories').add({
      'userId': userId,
      'gender': gender,
      'age': age,
      'hypertension': hypertension,
      'heartDisease': heartDisease,
      'everMarried': everMarried,
      'workType': workType,
      'residenceType': residenceType,
      'avgGlucoseLevel': avgGlucoseLevel,
      'bmi': bmi,
      'smokingStatus': smokingStatus,
      'stroke': stroke,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
