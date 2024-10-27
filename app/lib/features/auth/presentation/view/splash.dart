// ignore_for_file: use_build_context_synchronously
import 'package:app/core/helper/extension_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper/function_helper.dart';
import '../../../customer_requests/presentation/view_model/customer_requests_provider.dart';
import '../view_model/auth_provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullScrollScreenContainer(
      hasHight: true,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          _startDelayedNavigation(context, authProvider);
          return _buildSplashContent();
        },
      ),
    );
  }

  void _startDelayedNavigation(BuildContext context, AuthProvider authProvider) {
    Future.delayed(const Duration(seconds: 3), () {
      if (authProvider.authStatus == AuthStatus.authenticated) {
        _navigateToHome(context);
      } else {
        Navigator.of(context).pushReplacementNamed('/Login');
      }
    });
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/CustomerRequests');
  }

  Widget _buildSplashContent() {
    return Consumer<CustomerRequestProvider>(
      builder: (context, provider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(AppImages.logo, height: 100).fadeIn(milliseconds: 1500, delay: 500),
          FunctionHelper.showLoader().bounce(milliseconds: 1000),
        ],
      ),
    );
  }
}
