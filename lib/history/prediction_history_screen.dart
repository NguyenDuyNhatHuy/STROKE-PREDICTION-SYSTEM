import 'package:flutter/material.dart';
import 'package:stroke_prediction/history/prediction_history_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stroke_prediction/services/prediction_history_service.dart';

class PredictionHistoryScreen extends StatefulWidget {
  const PredictionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PredictionHistoryScreen> createState() => _PredictionHistoryScreenState();
}

class _PredictionHistoryScreenState extends State<PredictionHistoryScreen> {
  late Future<List<PredictionHistoryRecord>> _futureHistories;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _futureHistories = PredictionHistoryService().fetchUserPredictions(user?.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Container(
                padding: EdgeInsets.all(8.w),
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
                    SizedBox(width: 20.w),
                    Text(
                      'Lịch sử dự đoán',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<PredictionHistoryRecord>>(
                future: _futureHistories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Lỗi khi tải dữ liệu'));
                  }
                  final histories = snapshot.data ?? [];
                  if (histories.isEmpty) {
                    return Center(child: Text('Chưa có lịch sử dự đoán'));
                  }
                  return ListView.builder(
                    itemCount: histories.length,
                    itemBuilder: (context, index) {
                      final item = histories[index];
                      final dateStr = item.timestamp != null
                          ? '${item.timestamp!.day.toString().padLeft(2, '0')}-${item.timestamp!.month.toString().padLeft(2, '0')}-${item.timestamp!.year}'
                          : '';
                      final risk = (item.result is num)
                          ? (item.result as num).toInt()
                          : (item.result == true ? 100 : 0);
                      final isHighRisk = item.result == true || (item.result is num && item.result >= 50);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PredictionDetailScreen(record: item),
                            ),
                          );
                        },
                        child: PredictionCard(
                          date: dateStr,
                          risk: risk,
                          isHighRisk: isHighRisk,
                          riskProbability: item.risk,
                        ),
                      );
                    },
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

class PredictionCard extends StatelessWidget {
  final String date;
  final int risk;
  final bool isHighRisk;
  final double? riskProbability;

  const PredictionCard({super.key, required this.date, required this.risk, required this.isHighRisk, this.riskProbability});

  @override
  Widget build(BuildContext context) {
    final riskColor = isHighRisk ? Color(0xfff44336) : Color(0xff22c55e);
    final riskText = isHighRisk ? 'Nguy cơ cao' : 'Nguy cơ thấp';
    final riskPercent = riskProbability != null ? (riskProbability! * 100).toStringAsFixed(1) : '--';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
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
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 18.sp,
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
                    size: 20.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    riskText,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
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
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (riskProbability != null)
                    ? (riskProbability!.clamp(0.0, 1.0))
                    : 0.0,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: riskColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SizedBox(width: 8.w),
          Text(
            'Mức độ rủi ro: $riskPercent%',
            style: TextStyle(
              fontSize: 16.sp,
              color: Color(0xff6c6e71),
            ),
          ),
        ],
      ),
    );
  }
}