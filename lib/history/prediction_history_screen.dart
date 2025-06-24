import 'package:flutter/material.dart';
import 'package:stroke_prediction/history/prediction_history_detail_screen.dart';

class PredictionHistoryScreen extends StatelessWidget {
  final List<PredictionHistory> histories = [
    PredictionHistory(
      date: '01-12-2024',
      risk: 100,
      isHighRisk: true,
      detail: PredictionDetail(
        age: 65,
        gender: 'Nam',
        hypertension: 'Có',
        heartDisease: 'Không',
        everMarried: 'Có',
        workType: 'Nghỉ hưu',
        residenceType: 'Thành thị',
        avgGlucoseLevel: 180.5,
        bmi: 27.3,
        smokingStatus: 'Đã từng hút',
      ),
    ),
    PredictionHistory(
      date: '01-06-2024',
      risk: 80,
      isHighRisk: true,
      detail: PredictionDetail(
        age: 55,
        gender: 'Nữ',
        hypertension: 'Không',
        heartDisease: 'Có',
        everMarried: 'Có',
        workType: 'Nhân viên văn phòng',
        residenceType: 'Nông thôn',
        avgGlucoseLevel: 150.2,
        bmi: 24.1,
        smokingStatus: 'Không rõ',
      ),
    ),
    PredictionHistory(
      date: '01-01-2024',
      risk: 50,
      isHighRisk: false,
      detail: PredictionDetail(
        age: 40,
        gender: 'Nam',
        hypertension: 'Không',
        heartDisease: 'Không',
        everMarried: 'Không',
        workType: 'Tự doanh',
        residenceType: 'Thành thị',
        avgGlucoseLevel: 110.0,
        bmi: 22.0,
        smokingStatus: 'Chưa từng hút',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 40),
                    const Text(
                      'Lich sử dự đoán',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8),
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  final item = histories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PredictionDetailScreen(detail: item.detail),
                        ),
                      );
                    },
                    child: PredictionCard(item: item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PredictionHistory {
  final String date;
  final int risk;
  final bool isHighRisk;
  final PredictionDetail detail;

  PredictionHistory({
    required this.date,
    required this.risk,
    required this.isHighRisk,
    required this.detail,
  });
}

class PredictionDetail {
  final int age;
  final String gender;
  final String hypertension; // "Có" hoặc "Không"
  final String heartDisease; // "Có" hoặc "Không"
  final String everMarried; // "Có" hoặc "Không"
  final String workType;
  final String residenceType; // "Nông thôn" hoặc "Thành thị"
  final double avgGlucoseLevel;
  final double bmi;
  final String smokingStatus;

  PredictionDetail({
    required this.age,
    required this.gender,
    required this.hypertension,
    required this.heartDisease,
    required this.everMarried,
    required this.workType,
    required this.residenceType,
    required this.avgGlucoseLevel,
    required this.bmi,
    required this.smokingStatus,
  });
}

class PredictionCard extends StatelessWidget {
  final PredictionHistory item;

  const PredictionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final riskColor = item.isHighRisk ? Color(0xfff44336) : Color(0xff22c55e);
    final riskText = item.isHighRisk ? 'Nguy cơ cao' : 'Nguy cơ thấp';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date & Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Color(0xff6c6e71),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    item.date,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff6c6e71),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: riskColor,
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    riskText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          // Progress Bar
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xffe5e7eb),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                height: 8,
                width: MediaQuery.of(context).size.width * 0.85 * (item.risk / 100),
                decoration: BoxDecoration(
                  color: riskColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Mức độ rủi ro: ${item.risk}%',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff6c6e71),
            ),
          ),
        ],
      ),
    );
  }
}