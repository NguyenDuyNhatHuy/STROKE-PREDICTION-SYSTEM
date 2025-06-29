// lib/register/register_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/email_service.dart';
import '../services/firestore_seeder.dart';

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
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // username
              TextFormField(
                controller: _usernameC,
                decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
                validator: (v) => v != null && v.isNotEmpty ? null : 'Nhập tên đăng nhập',
              ),
              const SizedBox(height: 16),
              // email
              TextFormField(
                controller: _emailC,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v != null && v.contains('@') ? null : 'Email không hợp lệ',
              ),
              const SizedBox(height: 16),
              // password
              TextFormField(
                controller: _passC,
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true,
                validator: (v) => v != null && v.length >= 6 ? null : 'Tối thiểu 6 ký tự',
              ),
              const SizedBox(height: 16),
              // confirm
              TextFormField(
                controller: _confirmC,
                decoration: const InputDecoration(labelText: 'Nhập lại mật khẩu'),
                obscureText: true,
                validator: (v) => v != null && v == _passC.text ? null : 'Mật khẩu không khớp',
              ),
              const SizedBox(height: 24),
              // button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7AE7EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Đăng ký', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}