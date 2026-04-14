import 'package:flutter/material.dart';

// Pembayang Screens
import 'screens/screen_5.dart';
import 'screens/screen_6.dart';
import 'screens/screen_7.dart';
import 'screens/screen_8.dart';
import 'screens/screen_9.dart';

// MobiTravel Screens
import 'screens/home_screen_new.dart'; // 🏠 HOME UTAMA
import 'screens/home_screen.dart'; // 👤 ACCOUNT
import 'screens/detail_screen.dart';
import 'screens/search_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/agent_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combined App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFEF9F1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A3328),
          surface: const Color(0xFFFEF9F1),
        ),
        fontFamily: 'Inter',
      ),

      // 🔥 START DARI HOME UTAMA
      initialRoute: '/',

      routes: {
        // 🏠 HOME (Travel)
        '/': (context) => const HomeMainScreen(),

        // 🔍 FITUR
        '/detail': (context) => const DetailScreen(),
        '/search': (context) => const SearchScreen(),
        '/booking': (context) => const BookingScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/agent': (context) => const AgentScreen(),

        // 👤 ACCOUNT / PROFILE
        '/account': (context) => const AccountScreen(),

        // 🧪 PEMBAYANG
        '/screen5': (context) => const Screen5(),
        '/screen6': (context) => const Screen6(),
        '/screen7': (context) => const Screen7(),
        '/screen8': (context) => const Screen8(),
        '/screen9': (context) => const Screen9(),
      },
    );
  }
}
