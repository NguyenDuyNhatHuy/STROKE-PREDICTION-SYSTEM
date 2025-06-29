// lib/screens/forgetpassword_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../services/email_service.dart';
import '../services/firestore_seeder.dart';

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
      appBar: AppBar(title: const Text('Quên mật khẩu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailC,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                v != null && v.contains('@') ? null : 'Email không hợp lệ',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _sendOtp,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Gửi mã OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
