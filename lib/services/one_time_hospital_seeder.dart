import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Chạy file này chỉ một lần để seed dữ liệu bệnh viện lên Firestore
Future<void> oneTimeSeedHospitals() async {
  final String jsonString = await rootBundle.loadString('assets/data/hospitals_dotquy_vietnam.json');
  final List<dynamic> hospitals = json.decode(jsonString);

  final CollectionReference hospitalsRef = FirebaseFirestore.instance.collection('hospitals');

  for (final hospital in hospitals) {
    await hospitalsRef.add(hospital);
  }
  print('Đã tải xong dữ liệu bệnh viện lên Firestore!');
} 