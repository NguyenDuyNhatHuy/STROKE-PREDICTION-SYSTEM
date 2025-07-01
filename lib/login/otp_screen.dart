import 'package:flutter/material.dart';
import '../services/firestore_seeder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  final String uid;
  final String mode; // 'register' hoặc 'resetPassword'

  const OtpScreen({Key? key, required this.uid, required this.mode}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _codeC = TextEditingController();
  final _seeder = FirestoreSeeder();
  bool _loading = false;

  @override
  void dispose() {
    _codeC.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    final code = _codeC.text.trim();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP phải có 6 chữ số')),
      );
      return;
    }

    setState(() => _loading = true);
    final ok = await _seeder.verifyOtp(
      userId: widget.uid,
      otpKey: widget.uid,
      code: code,
    );
    setState(() => _loading = false);

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mã không đúng hoặc đã hết hạn')),
      );
      return;
    }

    // Điều hướng theo mode
    if (widget.mode == 'register') {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else if (widget.mode == 'resetPassword') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/resetPassword',
        (route) => false,
        arguments: widget.uid,
      );
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
                      'Nhập mã OTP',
                      style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
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
                          blurRadius: 8.w,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _codeC,
                          decoration: InputDecoration(
                            labelText: 'OTP',
                            hintText: 'Nhập mã OTP',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          height: 36.h,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _verify,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7AE7EB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _loading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Xác nhận',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10.h,
              left: 10.w,
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
