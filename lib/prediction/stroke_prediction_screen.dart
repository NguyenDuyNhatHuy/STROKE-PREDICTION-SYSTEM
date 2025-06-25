import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:stroke_prediction/prediction/result_screen.dart';
import 'package:stroke_prediction/db/database.dart';
import 'package:stroke_prediction/db/daos/prediction_dao.dart';
import 'package:stroke_prediction/main.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_prediction/tflite/stroke_predictor.dart';

class StrokePredictionScreen extends StatefulWidget {
  const StrokePredictionScreen({super.key});

  @override
  State<StrokePredictionScreen> createState() => _StrokePredictionFormState();
}

class _StrokePredictionFormState extends State<StrokePredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();


  String? gender;
  String? hypertension;
  String? heartDisease;
  String? everMarried;
  String? workType;
  String? residence;
  String? smokingStatus;

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context, listen: false).userId;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 40),
                    const Text(
                      'Dự đoán đột quỵ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('Tuổi'),
                      buildTextField(ageController, 'Nhập tuổi'),

                      buildLabel('Giới tính'),
                      buildDropdown(
                        value: gender,
                        items: {
                          'Male': 'Nam',
                          'Female': 'Nữ',
                          'Other': 'Khác',
                        },
                        onChanged: (value) => setState(() => gender = value),
                        hint: 'Chọn giới tính',
                      ),

                      buildLabel('Tăng huyết áp'),
                      buildToggle(
                        leftValue: '1',
                        rightValue: '0',
                        leftLabel: 'Có',
                        rightLabel: 'Không',
                        current: hypertension,
                        onChanged: (value) => setState(() => hypertension = value),
                      ),

                      buildLabel('Bệnh tim'),
                      buildToggle(
                        leftValue: '1',
                        rightValue: '0',
                        leftLabel: 'Có',
                        rightLabel: 'Không',
                        current: heartDisease,
                        onChanged: (value) => setState(() => heartDisease = value),
                      ),

                      buildLabel('Đã từng kết hôn'),
                      buildToggle(
                        leftValue: 'Yes',
                        rightValue: 'No',
                        leftLabel: 'Có',
                        rightLabel: 'Không',
                        current: everMarried,
                        onChanged: (value) => setState(() => everMarried = value),
                      ),

                      buildLabel('Công việc'),
                      buildDropdown(
                        value: workType,
                        items: {
                          'Children': 'Trẻ em',
                          'Govt job': 'Công chức',
                          'Self-employed': 'Tự kinh doanh',
                          'Private': 'Tư nhân',
                          'Never worked': 'Thất nghiệp',
                        },
                        onChanged: (value) => setState(() => workType = value),
                        hint: 'Chọn công việc',
                      ),

                      buildLabel('Nơi cư trú'),
                      buildToggle(
                        leftValue: 'Rural',
                        rightValue: 'Urban',
                        leftLabel: 'Nông thôn',
                        rightLabel: 'Thành thị',
                        current: residence,
                        onChanged: (value) => setState(() => residence = value),
                      ),

                      buildLabel('Mức Glucose trung bình'),
                      buildTextField(glucoseController, 'Nhập mức Glucose trong máu'),

                      buildLabel('BMI'),
                      buildTextField(bmiController, 'Nhập chỉ số khối cơ thể'),

                      buildLabel('Tình trạng hút thuốc'),
                      buildDropdown(
                        value: smokingStatus,
                        items: {
                          'Never Smoked': 'Chưa từng hút',
                          'Smokes': 'Đang hút',
                          'Formerly Smoked': 'Đã từng hút',
                          'Unknown': 'Không rõ',
                        },
                        onChanged: (value) => setState(() => smokingStatus = value),
                        hint: 'Chọn tình trạng',
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Image.asset(
                            'assets/images/icons/check.png',
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Bắt đầu dự đoán',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7CE5ED),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              int genderValue;
                              switch (gender) {
                                case 'Female': genderValue = 0; break;
                                case 'Male': genderValue = 1; break;
                                case 'Other': genderValue = 2; break;
                                default: genderValue = 0; // fallback
                              }
                              int everMarriedValue = (everMarried == 'Yes') ? 1 : 0;
                              int workTypeValue;
                              switch (workType) {
                                case 'Children': workTypeValue = 0; break;
                                case 'Govt job': workTypeValue = 1; break;
                                case 'Never worked': workTypeValue = 2; break;
                                case 'Private': workTypeValue = 3; break;
                                case 'Self-employed': workTypeValue = 4; break;
                                default: workTypeValue = 3; // fallback Private
                              }
                              int residenceValue = (residence == 'Urban') ? 1 : 0;
                              int smokingValue;
                              switch (smokingStatus) {
                                case 'Formerly Smoked': smokingValue = 0; break;
                                case 'Never Smoked': smokingValue = 1; break;
                                case 'Smokes': smokingValue = 2; break;
                                case 'Unknown': smokingValue = 3; break;
                                default: smokingValue = 1; // fallback Never Smoked
                              }
                              final input = [
                                genderValue.toDouble(),
                                double.parse(ageController.text),
                                double.parse(hypertension!),
                                double.parse(heartDisease!),
                                everMarriedValue.toDouble(),
                                workTypeValue.toDouble(),
                                residenceValue.toDouble(),
                                double.parse(glucoseController.text),
                                double.parse(bmiController.text),
                                smokingValue.toDouble(),
                              ];
                              try {
                                final predictor = await StrokePredictor.create();
                                final hasRisk = await predictor.predict(input);
                                print('Kết quả dự đoán: $hasRisk');
                                await _savePrediction(hasRisk);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ResultScreen(hasRisk: hasRisk),
                                  ),
                                );
                              } catch (e) {
                                print('Lỗi khi chạy mô hình: $e');
                                // Hiển thị thông báo lỗi lên UI nếu muốn
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Vui lòng nhập dữ liệu' : null,
    );
  }

  Widget buildDropdown({
    required String? value,
    required Map<String, String> items, // value => label
    required void Function(String?) onChanged,
    required String hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items: items.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      validator: (value) => value == null ? 'Vui lòng chọn' : null,
    );
  }


  Widget buildToggle({
    required String leftValue,
    required String rightValue,
    required String leftLabel,
    required String rightLabel,
    required String? current,
    required void Function(String) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: buildChoiceButton(
            leftLabel,
            current == leftValue,
                () => onChanged(leftValue),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: buildChoiceButton(
            rightLabel,
            current == rightValue,
                () => onChanged(rightValue),
          ),
        ),
      ],
    );
  }


  Widget buildChoiceButton(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black54),
          color: selected ? const Color(0xFF7CE5ED) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _savePrediction(bool hasRisk) async {
    final userId = Provider.of<UserProvider>(context, listen: false).userId;
    final prediction = PredictionHistoriesCompanion(
      userId: Value(userId!),
      gender: Value(gender!),
      age: Value(int.parse(ageController.text)),
      hypertension: Value(int.parse(hypertension!)),
      heartDisease: Value(int.parse(heartDisease!)),
      everMarried: Value(everMarried!),
      workType: Value(workType!),
      residenceType: Value(residence!),
      avgGlucoseLevel: Value(double.parse(glucoseController.text)),
      bmi: Value(double.parse(bmiController.text)),
      smokingStatus: Value(smokingStatus!),
      stroke: Value(hasRisk),
    );

    await db.predictionDao.insertPrediction(prediction);
  }
}
