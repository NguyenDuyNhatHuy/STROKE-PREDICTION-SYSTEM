import 'package:flutter/material.dart';
import 'package:stroke_prediction/history/prediction_history_screen.dart';
import 'package:stroke_prediction/hopital/nearby_hospitals_screen.dart';
import 'package:stroke_prediction/info/stroke_info_screen.dart';
import 'package:stroke_prediction/prediction/stroke_prediction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    Image.asset(
                      'assets/images/logo_stroke_prediction.png',
                      width: 50.w,
                      height: 50.h,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Xin chào $username!',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4.h),
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
                      width: 24.w,
                      height: 24.h,
                      color: Colors.black54,
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
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.w,
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
                          MaterialPageRoute(builder: (_) => StrokePredictionScreen(username: username,)),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),

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
                    SizedBox(height: 24.h),

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
                    SizedBox(height:24.h),

                    // Thông tin về đột quỵ
                    buildInfoCard(
                      title: 'Thông tin về đột quỵ',
                      subtitle: 'Tìm hiểu về phòng ngừa đột quỵ.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => StrokeInfoScreen()),
                        );
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.w,
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
                width: 32.w,
                height: 32.h,
                color: Colors.white,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          SizedBox(height: 12.h),
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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.w,
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
                  width: 28.w,
                  height: 28.h,
                  color: const Color(0xFF7CE5ED),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
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
