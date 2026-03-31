import 'package:flutter/material.dart';
import 'hello_screen.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HelloScreen(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
