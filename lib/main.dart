import 'package:flutter/material.dart';
import 'package:stroke_prediction/db/database.dart';
import 'login/login_screen.dart';
import 'home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:stroke_prediction/providers/user_provider.dart';

final db = AppDatabase();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(username: 'User'),
      },
    );
  }
}
