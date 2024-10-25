// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app_button.dart';
import '../../../../core/common/app_field.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helper/function_helper.dart';
import '../../data/models/login_request.dart';
import '../view_model/auth_provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final loginUsernameController = TextEditingController();
    final loginPasswordController = TextEditingController();

    return FullScrollScreenContainer(
      hasHight: true,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          _listenForErrors(context, authProvider);

          return Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                AppSizes.verticalSpace(AppSizes.defaultSpace),
                _buildUsernameField(loginUsernameController),
                AppSizes.verticalSpace(AppSizes.defaultBtwFields),
                _buildPasswordField(loginPasswordController),
                AppSizes.verticalSpace(AppSizes.defaultSpace),
                _buildLoginButton(
                    authProvider, loginFormKey, loginUsernameController, loginPasswordController, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(AppImages.logo, height: 100);
  }

  Widget _buildUsernameField(TextEditingController controller) {
    return AppField(
      hintText: AppStrings.usernameEmail,
      controller: controller,
      prefixIcon: const Icon(Icons.person),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username or email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return AppField(
      hintText: AppStrings.password,
      controller: controller,
      prefixIcon: const Icon(Icons.vpn_key),
      isPasswordField: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton(AuthProvider authProvider, GlobalKey<FormState> formKey,
      TextEditingController usernameController, TextEditingController passwordController, BuildContext context) {
    return (authProvider.authStatus == AuthStatus.loading)
        ? FunctionHelper.showLoader()
        : AppButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                _login(usernameController.text.trim(), passwordController.text.trim(), context);
              }
            },
            child: _buildButtonContent(context),
          );
  }

  Widget _buildButtonContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.lock,
          color: AppColors.white,
          size: AppSizes.iconSm,
        ),
        AppSizes.horizontalSpace(AppSizes.sm),
        Text(
          AppStrings.login,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
        ),
      ],
    );
  }

  void _login(String username, String password, BuildContext context) {
    final loginRequest = LoginRequest(username: username, password: password);
    Provider.of<AuthProvider>(context, listen: false).login(loginRequest);

    // Navigate to Home Page after a successful login
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Welcome to the Home Page!')),
            ),
          ),
        );
      },
    );
  }

  void _listenForErrors(BuildContext context, AuthProvider authProvider) {
    if (authProvider.authStatus == AuthStatus.error && authProvider.errorMessage != null) {
      Future.delayed(Duration.zero, () {
        FunctionHelper.showErrorDialog(context, authProvider.errorMessage!);
      });
    }
  }
}
