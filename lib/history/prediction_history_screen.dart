import 'package:flutter/material.dart';

class PredictionHistoryScreen extends StatelessWidget {
  final List<PredictionHistory> histories = [
    PredictionHistory(date: '01-12-2024', risk: 100, isHighRisk: true),
    PredictionHistory(date: '01-06-2024', risk: 80, isHighRisk: true),
    PredictionHistory(date: '01-01-2024', risk: 50, isHighRisk: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8f9),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded, size: 28, color: Color(0xff23272f)),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Lịch sử dự đoán',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff23272f),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8),
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  final item = histories[index];
                  return PredictionCard(item: item);
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

  PredictionHistory({
    required this.date,
    required this.risk,
    required this.isHighRisk,
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
                  Icon(Icons.calendar_today, color: Color(0xff6c6e71), size: 22),
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
                  Icon(Icons.warning_amber_rounded, color: riskColor, size: 22),
                  SizedBox(width: 6),
                  Text(
                    riskText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
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