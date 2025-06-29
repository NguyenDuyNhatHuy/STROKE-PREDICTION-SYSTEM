// lib/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:stroke_prediction/history/prediction_history_screen.dart';
import 'package:stroke_prediction/hopital/nearby_hospitals_screen.dart';
import 'package:stroke_prediction/info/stroke_info_screen.dart';
import 'package:stroke_prediction/prediction/stroke_prediction_screen.dart';
import 'package:stroke_prediction/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar với nút Back và Home
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Xin chào, $username!',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black87),
            onPressed: () {
              // nếu đã ở Home, không làm gì hoặc cuộn lên đầu
            },
          ),
        ],
      ),

      // Drawer bên cạnh (task bar dọc)
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context); // đóng Drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Đăng xuất'),
                onTap: () {
                  // Quay về màn Login, xóa stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),

      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
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
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Stroke Prediction',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
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

              // Các thẻ chức năng
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => StrokePredictionScreen()),
                ),
                child: buildInfoCard(
                  title: 'Dự đoán đột quỵ',
                  subtitle: 'Dự đoán nguy cơ đột quỵ của bạn',
                  iconAsset: _getInfoIconAsset('Dự đoán'),
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NearbyHospitalsScreen()),
                ),
                child: buildInfoCard(
                  title: 'Bệnh viện gần đây',
                  subtitle: 'Tìm bệnh viện gần bạn nhất',
                  iconAsset: _getInfoIconAsset('Bệnh viện'),
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PredictionHistoryScreen()),
                ),
                child: buildInfoCard(
                  title: 'Lịch sử dự đoán',
                  subtitle: 'Xem những dự đoán trước đây của bạn',
                  iconAsset: _getInfoIconAsset('Lịch sử'),
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => StrokeInfoScreen()),
                ),
                child: buildInfoCard(
                  title: 'Thông tin đột quỵ',
                  subtitle: 'Những kiến thức cần biết về đột quỵ',
                  iconAsset: _getInfoIconAsset('Thông tin'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Xây dựng một thẻ thông tin chung
  Widget buildInfoCard({
    required String title,
    required String subtitle,
    required String iconAsset,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Image.asset(iconAsset, width: 32, height: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  /// Chọn icon tương ứng với tiêu đề
  String _getInfoIconAsset(String title) {
    if (title.contains('Bệnh viện')) {
      return 'assets/images/icons/location.png';
    } else if (title.contains('Lịch sử')) {
      return 'assets/images/icons/clock.png';
    } else if (title.contains('Thông tin')) {
      return 'assets/images/icons/info.png';
    }
    // Mặc định
    return 'assets/images/icons/info.png';
  }
}
