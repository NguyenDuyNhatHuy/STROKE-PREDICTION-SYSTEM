import 'dart:math';
import 'package:flutter/material.dart';
import '../services/email_service.dart';
import '../services/firestore_seeder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailC  = TextEditingController();
  bool _loading  = false;

  final _emailSv = EmailService();
  final _seeder  = FirestoreSeeder();

  String _rand6() => (Random.secure().nextInt(900000) + 100000).toString();

  @override
  void dispose() {
    _emailC.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final email = _emailC.text.trim();
      final otp   = _rand6();

      // 1. Lưu OTP vào Firestore
      await _seeder.saveOtp(userId: email, code: otp);

      // 2. Gửi OTP qua email
      await _emailSv.sendOtp(email: email, code: otp);

      // 3. Điều hướng sang màn nhập OTP
      if (!mounted) return;
      Navigator.pushNamed(context, '/otp', arguments: {
        'uid' : email,
        'mode': 'resetPassword',
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Stack(
          children: [
            // Nội dung chính
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Center(
                    child: SizedBox(
                      width: 175.w,
                      child: Image.asset('assets/images/logo_stroke_prediction.png'),
                    ),
                  ),

                  Center(
                    child: Text(
                      'Quên mật khẩu',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 12.h),
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailC,
                            decoration: InputDecoration(
                              hintText: 'Nhập email',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) =>
                              v != null && v.contains('@') ? null : 'Email không hợp lệ',
                          ),
                          SizedBox(height: 24.h),
                          SizedBox(
                            width: double.infinity,
                            height: 36.h,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7AE7EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _loading
                                ? const CircularProgressIndicator()
                                : Text(
                                    'Xác nhận Email',
                                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Nút back ở góc trên cùng bên trái, luôn nổi phía trên
            Positioned(
              top: 10,
              left: 10,
              child: SafeArea(
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
