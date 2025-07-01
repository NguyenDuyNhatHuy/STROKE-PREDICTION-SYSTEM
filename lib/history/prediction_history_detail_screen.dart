import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/prediction_history_service.dart';

class PredictionDetailScreen extends StatelessWidget {
  final PredictionHistoryRecord record;

  const PredictionDetailScreen({super.key, required this.record});

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
                    SizedBox(width: 20.w),
                    Text(
                      'Chi tiết dự đoán',
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
                      _buildLabelValue('Tuổi', record.age),
                      SizedBox(height: 16.h),
                      _buildLabelValue('Giới tính', _genderLabel(record.gender)),
                      SizedBox(height: 16.h),
                      _buildToggleRow('Tăng huyết áp', _hypertensionLabel(record.hypertension)),
                      SizedBox(height: 16.h),
                      _buildToggleRow('Bệnh tim', _heartDiseaseLabel(record.heartDisease)),
                      SizedBox(height: 16.h),
                      _buildToggleRow('Đã từng kết hôn', _everMarriedLabel(record.everMarried)),
                      SizedBox(height: 16.h),
                      _buildLabelValue('Công việc', _workTypeLabel(record.workType)),
                      SizedBox(height: 16.h),
                      _buildToggleRow('Nơi cư trú', _residenceLabel(record.residence)),
                      SizedBox(height: 16.h),
                      _buildLabelValue('Mức Glucose trung bình (mg/dL)', record.avgGlucoseLevel),
                      SizedBox(height: 16.h),
                      _buildLabelValue('BMI (kg/m)', record.bmi),
                      SizedBox(height: 16.h),
                      _buildLabelValue('Tình trạng hút thuốc', _smokingStatusLabel(record.smokingStatus)),
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
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 8.h),
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
              fontSize: 16.sp,
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
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildToggleButton(firstLabel, isFirstActive),
            SizedBox(width: 12.w),
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
          color: active ? Color(0xFF7CE5ED) : Colors.white,
          border: Border.all(color: Color(0xffbdbdbd)),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Color(0xff23272f), // chỉnh màu chữ
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  String _genderLabel(String value) {
    switch (value) {
      case 'Male': return 'Nam';
      case 'Female': return 'Nữ';
      case 'Other': return 'Khác';
      default: return value;
    }
  }
  String _hypertensionLabel(String value) {
    if (value == '1' || value.toLowerCase() == 'yes' || value == 'Có') return 'Có';
    return 'Không';
  }
  String _heartDiseaseLabel(String value) {
    if (value == '1' || value.toLowerCase() == 'yes' || value == 'Có') return 'Có';
    return 'Không';
  }
  String _everMarriedLabel(String value) {
    if (value == 'Yes' || value == 'Có' || value == '1') return 'Có';
    return 'Không';
  }
  String _workTypeLabel(String value) {
    switch (value) {
      case 'Children': return 'Trẻ em';
      case 'Govt job': return 'Công chức';
      case 'Self-employed': return 'Tự kinh doanh';
      case 'Private': return 'Tư nhân';
      case 'Never worked': return 'Thất nghiệp';
      default: return value;
    }
  }
  String _residenceLabel(String value) {
    if (value == 'Rural' || value == 'Nông thôn') return 'Nông thôn';
    return 'Thành thị';
  }
  String _smokingStatusLabel(String value) {
    switch (value) {
      case 'Never Smoked': return 'Chưa từng hút';
      case 'Smokes': return 'Đang hút';
      case 'Formerly Smoked': return 'Đã từng hút';
      case 'Unknown': return 'Không rõ';
      default: return value;
    }
  }
}