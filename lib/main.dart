import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Core
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';

// Screens
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/account_screen.dart';
import 'presentation/screens/agent_screen.dart';
import 'presentation/screens/history_screen.dart';
import 'presentation/screens/login_screen.dart';

// Widgets
import 'presentation/widgets/virtual_assistant_overlay.dart';

// Original screens (kept)
import 'screens/search_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/register_screen.dart';

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
      initialRoute: AppRoutes.home,
      routes: {
        // Main tabs (clean architecture screens)
        AppRoutes.home: (_) => const VirtualAssistantOverlay(
              child: HomeScreen(),
            ),
        AppRoutes.account: (_) => const VirtualAssistantOverlay(
              child: AccountScreen(),
            ),
        AppRoutes.agent: (_) => const VirtualAssistantOverlay(
              child: AgentScreen(),
            ),
        AppRoutes.history: (_) => const VirtualAssistantOverlay(
              child: HistoryScreen(),
            ),
        AppRoutes.login: (_) => const VirtualAssistantOverlay(
              child: LoginScreen(),
            ),

        // Feature screens
        AppRoutes.search: (_) => const VirtualAssistantOverlay(
              child: SearchScreen(),
            ),
        AppRoutes.detail: (_) => const VirtualAssistantOverlay(
              child: DetailScreen(),
            ),
        AppRoutes.booking: (_) => const VirtualAssistantOverlay(
              child: BookingScreen(),
            ),
        AppRoutes.payment: (_) => const VirtualAssistantOverlay(
              child: PaymentScreen(),
            ),
        AppRoutes.register: (_) => const VirtualAssistantOverlay(
              child: RegisterScreen(),
            ),
      },
    );
  }
}
