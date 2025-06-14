import 'package:flutter/material.dart';
import 'package:stroke_prediction/prediction/result_screen.dart';

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
                          onPressed: () {
                            //if (_formKey.currentState!.validate()) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) => const ResultScreen(hasRisk: false),
                              ));
                            //}
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
}
