import 'package:flutter/material.dart';
import 'core/constants/strings.dart';
import 'core/constants/theme.dart';
import 'features/auth/presentation/view/login.dart';
import 'features/auth/presentation/view/splash.dart';
import 'features/customer_requests/presentation/view/customer_requests_view.dart';

class AccurateApp extends StatelessWidget {
  const AccurateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      themeMode: ThemeMode.light,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: _buildRoutes(),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/': (context) => const SplashView(),
      '/Login': (context) => const LoginView(),
      '/CustomerRequests': (context) => const CustomerRequestsView(),
    };
  }
}
