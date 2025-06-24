import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'login/login_screen.dart';
import 'login/otp_screen.dart';
import 'register/register_screen.dart';
import 'forgetpassword/forgetpassword_screen.dart';
import 'home/home_screen.dart';
import 'prediction/stroke_prediction_screen.dart';
import 'hopital/nearby_hospitals_screen.dart';
import 'info/stroke_info_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stroke Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) {
          return LoginScreen();
        },
        '/register': (_) => const RegisterScreen(),
        '/forgot': (_) => ForgetPasswordScreen(),
        '/otp': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as Map<String, dynamic>;
          return OtpScreen(
            uid: args['uid'] as String,
            mode: args['mode'] as String,
          );
        },
        '/home': (_) => const HomeScreen(username: 'User'),
        '/prediction': (_) => const StrokePredictionScreen(),
        '/nearby': (_) => const NearbyHospitalsScreen(),
        '/info': (_) => const StrokeInfoScreen(),
      },
    );
  }
}