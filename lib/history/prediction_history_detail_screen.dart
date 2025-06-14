import 'package:flutter/material.dart';
import 'package:stroke_prediction/history/prediction_history_screen.dart';

class PredictionDetailScreen extends StatelessWidget {
  final PredictionDetail detail;

  const PredictionDetailScreen({super.key, required this.detail});

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
                      'Chi tiết dự đoán',
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
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelValue('Tuổi', detail.age.toString()),
                      SizedBox(height: 16),
                      _buildLabelValue('Giới tính', detail.gender),
                      SizedBox(height: 16),
                      _buildToggleRow('Tăng huyết áp', detail.hypertension),
                      SizedBox(height: 16),
                      _buildToggleRow('Bệnh tim', detail.heartDisease),
                      SizedBox(height: 16),
                      _buildToggleRow('Đã từng kết hôn', detail.everMarried),
                      SizedBox(height: 16),
                      _buildLabelValue('Công việc', detail.workType),
                      SizedBox(height: 16),
                      _buildToggleRow('Nơi cư trú', detail.residenceType),
                      SizedBox(height: 16),
                      _buildLabelValue('Mức Glucose trung bình (mg/dL)', detail.avgGlucoseLevel.toString()),
                      SizedBox(height: 16),
                      _buildLabelValue('BMI (kg/m)', detail.bmi.toString()),
                      SizedBox(height: 16),
                      _buildLabelValue('Tình trạng hút thuốc', detail.smokingStatus),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xff23272f),
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffe5e7eb)),
            borderRadius: BorderRadius.circular(10),
            color: Color(0xfff7f8f9),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: value == '...' ? Colors.grey : Color(0xff23272f),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow(String label, String value) {
    // value: "Có" hoặc "Không" hoặc "Nông thôn"/"Thành thị"
    bool isFirstActive = value == "Có" || value == "Nông thôn";
    bool isSecondActive = value == "Không" || value == "Thành thị";
    String firstLabel = (label == "Nơi cư trú") ? "Nông thôn" : "Có";
    String secondLabel = (label == "Nơi cư trú") ? "Thành thị" : "Không";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xff23272f),
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildToggleButton(firstLabel, isFirstActive),
            SizedBox(width: 12),
            _buildToggleButton(secondLabel, isSecondActive),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool active) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? Color(0xffaaf0fa) : Colors.white,
          border: Border.all(color: Color(0xffbdbdbd)),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff23272f),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}