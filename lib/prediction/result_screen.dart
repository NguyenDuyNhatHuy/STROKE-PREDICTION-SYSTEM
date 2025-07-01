import 'package:flutter/material.dart';
import 'package:stroke_prediction/hopital/nearby_hospitals_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stroke_prediction/home/home_screen.dart';

class ResultScreen extends StatelessWidget {
  final bool hasRisk;
  final String username;

  const ResultScreen({super.key, required this.hasRisk, required this.username});

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
              margin: EdgeInsets.all(16.w),
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
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.black87),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => HomeScreen(username: username)),
                        (route) => false,
                      );
                    },
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Kết quả dự đoán',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(16.w),
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
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: hasRisk ? const Color(0xFFFFE5E5) : const Color(0xFFE5FFE5),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                icon,
                                size: 64.w,
                                color: iconColor,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              titleText,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              descriptionText,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Image.asset(
                            'assets/images/icons/location.png',
                            width: 24.w,
                            height: 24.h,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Tìm Bệnh viện gần đây',
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const NearbyHospitalsScreen()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: Image.asset(
                            'assets/images/icons/info.png',
                            width: 24.w,
                            height: 24.h,
                            color: const Color(0xFF7CE5ED),
                          ),
                          label: Text(
                            'Tìm hiểu thêm về đột quỵ',
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF7CE5ED),
                            side: const BorderSide(color: Color(0xFF7CE5ED)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
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