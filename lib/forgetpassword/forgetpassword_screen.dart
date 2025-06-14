import 'package:flutter/material.dart';

class ForgetpasswordScreen extends StatelessWidget {
  const ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: Stack(
        children: [
          SafeArea(
            top: true,
            child: Positioned(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Logo
                  SizedBox(
                    width: 200,
                    child: Image.asset('assets/images/logo_stroke_prediction.png'),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // Xử lý quên mật khẩu
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7AE7EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Xác nhận Email',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
