import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/strings.dart';
import 'core/constants/theme.dart';
import 'features/auth/presentation/view/login.dart';
import 'features/auth/presentation/view/splash.dart';
import 'features/customer_requests/data/models/response_customer_request_fetching.dart';
import 'features/customer_requests/presentation/view/customer_request_details.dart';
import 'features/customer_requests/presentation/view/customer_requests_view.dart';
import 'features/customer_requests/presentation/view/request_addition_or_updating.dart';
import 'features/customer_requests/presentation/view_model/customer_requests_provider.dart';
import 'features/customer_requests/data/repos/customer_requests_repo_impl.dart';

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
      '/CustomerRequestsDetails': (context) {
        final id = ModalRoute.of(context)!.settings.arguments as int;
        return ChangeNotifierProvider(
          create: (_) => CustomerRequestProvider(CustomerRequestsRepoImpl()),
          child: CustomerRequestDetailsView(id: id),
        );
      },
      '/CustomerRequestAdditionOrUpdating': (context) {
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        final int id = args['id'];
        final bool isEdit = args['isEdit'];
        final ResponseCustomerRequestFetching request = args['request'];
        return RequestAdditionOrUpdating(id: id, isEdit: isEdit, request: request);
      },
    };
  }
}
