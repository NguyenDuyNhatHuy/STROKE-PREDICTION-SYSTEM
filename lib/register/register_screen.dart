// lib/screens/register_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_seeder.dart';
import '../services/email_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _seeder = FirestoreSeeder();
  final _emailSvc = EmailService();

  final _form = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _mailC = TextEditingController();
  final _passC = TextEditingController();
  final _confC = TextEditingController();

  bool _loading = false;

  String _rand6() => List.generate(6, (_) => Random.secure().nextInt(10)).join();

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: _mailC.text.trim(),
        password: _passC.text,
      );
      final uid = cred.user!.uid;
      final code = _rand6();

      await _seeder.addUser(
        userId: uid,
        name: _nameC.text.trim(),
        email: _mailC.text.trim(),
      );
      await _seeder.saveOtp(userId: uid, code: code);

      final ok = await _emailSvc.sendOtp(email: _mailC.text.trim(), code: code);
      if (!ok) throw Exception('Không gửi được email xác nhận');

      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        '/otp',
        arguments: {'uid': uid, 'mode': 'register'},
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Lỗi đăng ký')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  InputDecoration _dec(String h) => InputDecoration(
    hintText: h,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 100, 32, 0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                Text(
                  'Đăng ký',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameC,
                  decoration: _dec('Nhập tên'),
                  validator: (v) =>
                  (v == null || v.isEmpty) ? 'Vui lòng nhập tên' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mailC,
                  decoration: _dec('Nhập email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Vui lòng nhập email';
                    final r = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    return r.hasMatch(v) ? null : 'Email không hợp lệ';
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passC,
                  decoration: _dec('Mật khẩu'),
                  obscureText: true,
                  validator: (v) =>
                  (v == null || v.length < 6) ? 'Tối thiểu 6 ký tự' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confC,
                  decoration: _dec('Xác nhận mật khẩu'),
                  obscureText: true,
                  validator: (v) =>
                  (v != _passC.text) ? 'Mật khẩu xác nhận không khớp' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Tạo tài khoản'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
