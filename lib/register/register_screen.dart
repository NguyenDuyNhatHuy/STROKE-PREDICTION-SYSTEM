import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/email_service.dart';
import '../services/firestore_seeder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey    = GlobalKey<FormState>();
  final _usernameC = TextEditingController();
  final _emailC    = TextEditingController();
  final _passC     = TextEditingController();
  final _confirmC  = TextEditingController();
  bool _isLoading  = false;

  final _auth    = FirebaseAuth.instance;
  final _seeder  = FirestoreSeeder();
  final _emailSv = EmailService();

  @override
  void dispose() {
    _usernameC.dispose();
    _emailC.dispose();
    _passC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      // tạo tài khoản
      final cred = await _auth.createUserWithEmailAndPassword(
        email:    _emailC.text.trim(),
        password: _passC.text,
      );
      final uid = cred.user!.uid;
      // lưu displayName && Firestore
      await cred.user!.updateDisplayName(_usernameC.text.trim());
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': _usernameC.text.trim(),
        'email':    _emailC.text.trim(),
      });
      // gửi OTP
      final otp = (Random.secure().nextInt(900000) + 100000).toString();
      await _seeder.saveOtp(userId: uid, code: otp);
      await _emailSv.sendOtp(email: _emailC.text.trim(), code: otp);
      if (!mounted) return;
      Navigator.pushNamed(context, '/otp', arguments: {'uid': uid, 'mode': 'register'});
    } on FirebaseAuthException catch (e) {
      String msg;
      if (e.code == 'weak-password') {
        msg = 'Mật khẩu quá yếu';
      } else if (e.code == 'email-already-in-use') {
        msg = 'Email đã tồn tại';
      } else {
        msg = e.message ?? 'Đăng ký thất bại';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Có lỗi xảy ra')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                  // Title
                  Center(
                    child: Text(
                      'Đăng ký',
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // username
                          TextFormField(
                            controller: _usernameC,
                            decoration: InputDecoration(
                              hintText: 'Nhập tên',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                            validator: (v) => v != null && v.isNotEmpty ? null : 'Nhập tên đăng nhập',
                          ),
                          SizedBox(height: 16.h),
                          // email
                          TextFormField(
                            controller: _emailC,
                            decoration: InputDecoration(
                              hintText: 'Nhập email',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                            validator: (v) => v != null && v.contains('@') ? null : 'Email không hợp lệ',
                          ),
                          SizedBox(height: 16.h),
                          // password
                          TextFormField(
                            controller: _passC,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Nhập mật khẩu',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                            validator: (v) => v != null && v.length >= 6 ? null : 'Tối thiểu 6 ký tự',
                          ),
                          SizedBox(height: 16.h),
                          // confirm password
                          TextFormField(
                            controller: _confirmC,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Nhập lại mật khẩu',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                            validator: (v) => v != null && v == _passC.text ? null : 'Mật khẩu không khớp',
                          ),
                          SizedBox(height: 24.h),
                          SizedBox(
                            width: double.infinity,
                            height: 36.h,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7AE7EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      'Đăng ký',
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