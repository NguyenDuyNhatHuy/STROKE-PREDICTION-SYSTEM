import 'package:flutter/material.dart';
import 'package:stroke_prediction/history/prediction_history_screen.dart';
import 'package:stroke_prediction/hopital/nearby_hospitals_screen.dart';
import 'package:stroke_prediction/prediction/stroke_prediction_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

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
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    Image.asset(
                      'assets/images/logo_stroke_prediction.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Xin chào $username!',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text(
                            'Hãy kiểm tra tình trạng sức khỏe của bạn',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // Thay icon notification bằng icon từ máy
                    Image.asset(
                      'assets/images/icons/notification.png',
                      width: 24,
                      height: 24,
                      color: Colors.black54,
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
                child: Column(
                  children: [
                    // Dự đoán đột quỵ
                    buildFeatureCard(
                      title: 'Dự đoán đột quỵ.',
                      subtitle: 'Dự đoán nguy cơ đột quỵ của bạn',
                      buttonText: 'Bắt đầu dự đoán',
                      color: const Color(0xFF7CE5ED),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => StrokePredictionScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Bệnh viện gần đây
                    buildInfoCard(
                      title: 'Bệnh viện gần đây',
                      subtitle: 'Tìm cơ sở y tế gần bạn',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NearbyHospitalsScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Lịch sử dự đoán
                    buildInfoCard(
                      title: 'Lịch sử dự đoán',
                      subtitle: 'Xem những dự đoán trước đây của bạn',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PredictionHistoryScreen()),
                        );
                      },
                    ),
                    const SizedBox(height:24),

                    // Thông tin về đột quỵ
                    buildInfoCard(
                      title: 'Thông tin về đột quỵ.',
                      subtitle: 'Tìm hiểu về phòng ngừa đột quỵ.',
                      onTap: () {
                        // TODO: Navigate to stroke info
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFeatureCard({
    required String title,
    required String subtitle,
    required String buttonText,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/icons/heart.png',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(buttonText),
          )
        ],
      ),
    );
  }

  Widget buildInfoCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  _getInfoIconAsset(title),
                  width: 28,
                  height: 28,
                  color: const Color(0xFF7CE5ED),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm phụ để chọn icon asset phù hợp cho InfoCard
  String _getInfoIconAsset(String title) {
    if (title.contains('Bệnh viện')) {
      return 'assets/images/icons/location.png';
    } else if (title.contains('Lịch sử')) {
      return 'assets/images/icons/clock.png';
    } else if (title.contains('Thông tin')) {
      return 'assets/images/icons/info.png';
    }
    // Mặc định
    return 'assets/icons/info.png';
  }
}
