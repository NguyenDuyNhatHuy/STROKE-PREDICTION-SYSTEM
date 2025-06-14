import 'package:flutter/material.dart';
import 'package:stroke_prediction/hopital/nearby_hospitals_screen.dart';

class ResultScreen extends StatelessWidget {
  final bool hasRisk;

  const ResultScreen({super.key, required this.hasRisk});

  @override
  Widget build(BuildContext context) {
    final icon = hasRisk
        ? Icons.warning_amber_rounded
        : Icons.check_circle_rounded;
    final iconColor = hasRisk ? Colors.red : Colors.green;
    final titleText = hasRisk
        ? 'Nguy cơ đột quỵ cao'
        : 'Không có nguy cơ đột quỵ';
    final descriptionText = hasRisk
        ? 'Dựa trên thông tin sức khỏe của bạn, phân tích của chúng tôi cho thấy bạn có nguy cơ đột quỵ cao.'
        : 'Dựa trên thông tin sức khỏe của bạn, phân tích của chúng tôi cho thấy bạn không có nguy cơ đột quỵ.';


    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
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
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.black87),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Kết quả dự đoán',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(16),
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: hasRisk ? const Color(0xFFFFE5E5) : const Color(0xFFE5FFE5),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                icon,
                                size: 64,
                                color: iconColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              titleText,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              descriptionText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Image.asset(
                            'assets/images/icons/location.png',
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Tìm Bệnh viện gần đây',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const NearbyHospitalsScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: Image.asset(
                            'assets/images/icons/info.png',
                            width: 24,
                            height: 24,
                            color: const Color(0xFF7CE5ED),
                          ),
                          label: const Text(
                            'Tìm hiểu thêm về đột quỵ',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF7CE5ED),
                            side: const BorderSide(color: Color(0xFF7CE5ED)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // ...existing code...
                          },
                        ),
                      ),
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
}