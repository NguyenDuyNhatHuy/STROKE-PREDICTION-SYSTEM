import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeeder {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _otpCollection = 'emailOtps';

  /// Lưu OTP vào Firestore, hết hạn sau 15 phút
  Future<void> saveOtp({
    required String userId,
    required String code,
    Duration expiresIn = const Duration(minutes: 15),
  }) async {
    final expiry = DateTime.now().add(expiresIn);
    await _db
        .collection(_otpCollection)
        .doc(userId)
        .set({'code': code, 'expiresAt': Timestamp.fromDate(expiry)});
  }

  /// Verify OTP, in ra log chi tiết nếu fail
  Future<bool> verifyOtp({
    String? userId,
    String? otpKey,
    required String code,
  }) async {
    final key = userId ?? otpKey;
    if (key == null) {
      print('🔴 verifyOtp: missing key');
      return false;
    }

    final snap = await _db.collection(_otpCollection).doc(key).get();
    if (!snap.exists) {
      print('🔴 verifyOtp: no document for key=$key');
      return false;
    }

    final data   = snap.data()!;
    final stored = data['code'] as String;
    final expiry = (data['expiresAt'] as Timestamp).toDate();
    final now    = DateTime.now();

    print('ℹ️ verifyOtp: key=$key, stored="$stored", '
        'input="${code.trim()}", expiry=$expiry, now=$now');

    if (stored != code.trim()) {
      print('🔴 verifyOtp: code mismatch');
      return false;
    }
    if (now.isAfter(expiry)) {
      print('🔴 verifyOtp: expired (now>$expiry)');
      return false;
    }

    // Xoá document sau khi verify thành công
    await _db.collection(_otpCollection).doc(key).delete();
    return true;
  }

  /// Lấy danh sách bệnh viện từ Firestore
  Future<List<Map<String, dynamic>>> fetchHospitals() async {
    final snapshot = await _db.collection('hospitals').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
