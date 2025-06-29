// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login/login_screen.dart';
import 'register/register_screen.dart';
import 'forgetpassword/forgetpassword_screen.dart';
import 'login/otp_screen.dart';
import 'forgetpassword/reset_password_screen.dart';
import 'home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stroke Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (ctx) => const LoginScreen(),
        '/register': (ctx) => const RegisterScreen(),
        '/forgotPassword': (ctx) => const ForgetPasswordScreen(),
        '/otp': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as Map;
          return OtpScreen(
            uid: args['uid'] as String,
            mode: args['mode'] as String,
          );
        },
        '/resetPassword': (ctx) {
          final email = ModalRoute.of(ctx)!.settings.arguments as String;
          return ResetPasswordScreen(email: email);
        },
        '/home': (ctx) => const HomeScreen(username: '',),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      },
    );
  }
}
