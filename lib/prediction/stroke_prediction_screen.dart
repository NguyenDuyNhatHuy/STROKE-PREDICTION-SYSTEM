import 'package:flutter/material.dart';
import 'package:stroke_prediction/prediction/result_screen.dart';
import 'package:stroke_prediction/tflite/stroke_predictor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StrokePredictionScreen extends StatefulWidget {
  final String username;
  const StrokePredictionScreen({super.key, required this.username});

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
  
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.w,
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
                        SizedBox(width: 20.w),
                        Text(
                          'Dự đoán đột quỵ',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8.w,
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

                          SizedBox(height: 24.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Image.asset(
                                'assets/images/icons/check.png',
                                width: 24.w,
                                height: 24.h,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Bắt đầu dự đoán',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7CE5ED),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _loading ? null : () async {
                                if (_formKey.currentState!.validate()) {
                                  // Validate các trường chọn
                                  if (gender == null || hypertension == null || heartDisease == null || everMarried == null || workType == null || residence == null || smokingStatus == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
                                    );
                                    return;
                                  }
                                  // Validate số
                                  double? age, glucose, bmi;
                                  try {
                                    age = double.parse(ageController.text);
                                    glucose = double.parse(glucoseController.text);
                                    bmi = double.parse(bmiController.text);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Tuổi, Glucose, BMI phải là số hợp lệ!')),
                                    );
                                    return;
                                  }
                                  setState(() { _loading = true; });
                                  int genderValue;
                                  switch (gender) {
                                    case 'Female': genderValue = 0; break;
                                    case 'Male': genderValue = 1; break;
                                    case 'Other': genderValue = 2; break;
                                    default: genderValue = 0;
                                  }
                                  int everMarriedValue = (everMarried == 'Yes') ? 1 : 0;
                                  int workTypeValue;
                                  switch (workType) {
                                    case 'Children': workTypeValue = 0; break;
                                    case 'Govt job': workTypeValue = 1; break;
                                    case 'Never worked': workTypeValue = 2; break;
                                    case 'Private': workTypeValue = 3; break;
                                    case 'Self-employed': workTypeValue = 4; break;
                                    default: workTypeValue = 3;
                                  }
                                  int residenceValue = (residence == 'Urban') ? 1 : 0;
                                  int smokingValue;
                                  switch (smokingStatus) {
                                    case 'Formerly Smoked': smokingValue = 0; break;
                                    case 'Never Smoked': smokingValue = 1; break;
                                    case 'Smokes': smokingValue = 2; break;
                                    case 'Unknown': smokingValue = 3; break;
                                    default: smokingValue = 1;
                                  }
                                  double hypertensionValue, heartDiseaseValue;
                                  try {
                                    hypertensionValue = double.parse(hypertension!);
                                    heartDiseaseValue = double.parse(heartDisease!);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Tăng huyết áp và Bệnh tim phải là số hợp lệ!')),
                                    );
                                    setState(() { _loading = false; });
                                    return;
                                  }
                                  final input = [
                                    genderValue.toDouble(),
                                    age,
                                    hypertensionValue,
                                    heartDiseaseValue,
                                    everMarriedValue.toDouble(),
                                    workTypeValue.toDouble(),
                                    residenceValue.toDouble(),
                                    glucose,
                                    bmi,
                                    smokingValue.toDouble(),
                                  ];
                                  try {
                                    // Lưu thông tin dự đoán vào Firestore
                                    final user = FirebaseAuth.instance.currentUser;
                                    if (user == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Bạn cần đăng nhập để dự đoán!')),
                                      );
                                      setState(() { _loading = false; });
                                      return;
                                    }
                                    final docRef = await FirebaseFirestore.instance.collection('predictions').add({
                                      'userId': user.uid,
                                      'timestamp': FieldValue.serverTimestamp(),
                                      'gender': gender,
                                      'age': ageController.text,
                                      'hypertension': hypertension,
                                      'heartDisease': heartDisease,
                                      'everMarried': everMarried,
                                      'workType': workType,
                                      'residence': residence,
                                      'avgGlucoseLevel': glucoseController.text,
                                      'bmi': bmiController.text,
                                      'smokingStatus': smokingStatus,
                                    });
                                    final predictor = await StrokePredictor.create();
                                    final riskProbability = await predictor.predictProbability(input);
                                    final hasRisk = riskProbability >= 0.5;
                                    print('Kết quả dự đoán: $hasRisk, tỉ lệ: $riskProbability');
                                    await docRef.update({'result': hasRisk, 'risk': riskProbability});
                                    predictor.close();
                                    setState(() { _loading = false; });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ResultScreen(hasRisk: hasRisk, username: widget.username),
                                      ),
                                    );
                                  } catch (e) {
                                    print('Lỗi khi chạy mô hình hoặc lưu Firestore: $e');
                                    setState(() { _loading = false; });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Lỗi khi dự đoán hoặc lưu dữ liệu: $e')),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_loading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
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
      hint: Text(hint, style: TextStyle(fontSize: 15.sp, color: Colors.grey[600])),
      items: items.entries
          .map((e) => DropdownMenuItem(
                value: e.key,
                child: Text(
                  e.value,
                  style: TextStyle(fontSize: 15.sp),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Color(0xFF7CE5ED), width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      ),
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 28.w),
      dropdownColor: Colors.white,
      style: TextStyle(fontSize: 15.sp, color: Colors.black87),
      elevation: 4,
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
        SizedBox(width: 12.w),
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
        height: 40.h, // nhỏ lại
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // nhỏ lại
          border: Border.all(color: Colors.black54),
          color: selected ? const Color(0xFF7CE5ED) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp, // chữ lớn hơn
            ),
          ),
        ),
      ),
    );
  }
}
