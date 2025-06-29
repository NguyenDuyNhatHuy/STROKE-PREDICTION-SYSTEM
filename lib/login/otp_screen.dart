// lib/login/otp_screen.dart

import 'package:flutter/material.dart';
import '../services/firestore_seeder.dart';

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
      userId: widget.mode == 'register'     ? widget.uid : null,
      otpKey: widget.mode == 'resetPassword' ? widget.uid : null,
      code: code,
    );
    setState(() => _loading = false);

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mã không đúng hoặc đã hết hạn')),
      );
      return;
    }

    // OTP đúng → chuyển về màn Login và xóa hết lịch sử route
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nhập OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _codeC,
              decoration: const InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _verify,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }
}
