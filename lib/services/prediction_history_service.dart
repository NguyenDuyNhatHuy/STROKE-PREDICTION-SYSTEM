import 'package:cloud_firestore/cloud_firestore.dart';

class PredictionHistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<PredictionHistoryRecord>> fetchUserPredictions(String userId) async {
    final query = await _db
        .collection('predictions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return query.docs.map((doc) => PredictionHistoryRecord.fromFirestore(doc)).toList();
  }
}

class PredictionHistoryRecord {
  final String id;
  final DateTime? timestamp;
  final String gender;
  final String age;
  final String hypertension;
  final String heartDisease;
  final String everMarried;
  final String workType;
  final String residence;
  final String avgGlucoseLevel;
  final String bmi;
  final String smokingStatus;
  final dynamic result;
  final double? risk;

  PredictionHistoryRecord({
    required this.id,
    required this.timestamp,
    required this.gender,
    required this.age,
    required this.hypertension,
    required this.heartDisease,
    required this.everMarried,
    required this.workType,
    required this.residence,
    required this.avgGlucoseLevel,
    required this.bmi,
    required this.smokingStatus,
    required this.result,
    this.risk,
  });

  factory PredictionHistoryRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PredictionHistoryRecord(
      id: doc.id,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      gender: data['gender'] ?? '',
      age: data['age'] ?? '',
      hypertension: data['hypertension'] ?? '',
      heartDisease: data['heartDisease'] ?? '',
      everMarried: data['everMarried'] ?? '',
      workType: data['workType'] ?? '',
      residence: data['residence'] ?? '',
      avgGlucoseLevel: data['avgGlucoseLevel'] ?? '',
      bmi: data['bmi'] ?? '',
      smokingStatus: data['smokingStatus'] ?? '',
      result: data['result'],
      risk: (data['risk'] is num) ? (data['risk'] as num).toDouble() : null,
    );
  }
} 