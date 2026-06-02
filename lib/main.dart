import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/account_screen.dart';
import 'presentation/screens/agent_screen.dart';
import 'presentation/screens/history_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/vehicle_detail_screen.dart';
import 'presentation/screens/booking_screen.dart';
import 'presentation/screens/qris_payment_screen.dart'; // ← FIX: tambah import ini
import 'presentation/widgets/virtual_assistant_overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MobiTravelApp());
}

class MobiTravelApp extends StatelessWidget {
  const MobiTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobiTravel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.login,
      routes: {
        // Halaman yang TIDAK pakai chatbot (Login & Register)
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),

        // Halaman yang PAKAI chatbot
        AppRoutes.home: (_) =>
            const VirtualAssistantOverlay(child: HomeScreen()),
        AppRoutes.account: (_) =>
            const VirtualAssistantOverlay(child: AccountScreen()),
        AppRoutes.agent: (_) =>
            const VirtualAssistantOverlay(child: AgentScreen()),
        AppRoutes.history: (_) =>
            const VirtualAssistantOverlay(child: HistoryScreen()),
        AppRoutes.detail: (_) =>
            const VirtualAssistantOverlay(child: VehicleDetailScreen()),
        AppRoutes.vehicleDetail: (_) =>
            const VirtualAssistantOverlay(child: VehicleDetailScreen()),
        AppRoutes.booking: (_) =>
            const VirtualAssistantOverlay(child: BookingScreen()),
        AppRoutes.qrisPayment: (context) => const QrisPaymentScreen(),
      },
    );
  }
}
