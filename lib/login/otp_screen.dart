import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> _verify() async {
    setState(() => _loading = true);
    final ok = await _seeder.verifyOtp(userId: widget.uid, code: _codeC.text.trim());
    if (!mounted) return;
    setState(() => _loading = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mã không hợp lệ hoặc đã hết hạn')));
      return;
    }
    if (widget.mode == 'register') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.uid);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link đổi mật khẩu đã được gửi')));
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.mode == 'register' ? 'Xác nhận đăng ký' : 'Xác nhận đổi mật khẩu';
    final button = widget.mode == 'register' ? 'Xác nhận' : 'Gửi link đổi mật khẩu';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Nhập mã xác nhận đã gửi qua email', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              TextField(controller: _codeC, maxLength: 6, keyboardType: TextInputType.number, decoration: const InputDecoration(border: OutlineInputBorder())),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _verify,
                  child: _loading ? const CircularProgressIndicator(color: Colors.white) : Text(button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}