import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'accurate_app.dart';
import 'core/constants/queries_and_mutations.dart';
import 'core/helper/cache_helper.dart';
import 'core/helper/graph_ql_config.dart';
import 'features/auth/data/repo/auth_repo_impl.dart';
import 'features/auth/presentation/view_model/auth_provider.dart';
import 'features/customer_requests/data/repos/customer_requests_repo_impl.dart';
import 'features/customer_requests/presentation/view_model/button_provider.dart';
import 'features/customer_requests/presentation/view_model/customer_requests_provider.dart';
import 'features/customer_requests/presentation/view_model/date_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(_buildApp());
}

Future<void> _initializeApp() async {
  await CacheHelper.init();
  await GraphQLConfig().init();
}

Widget _buildApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(AuthRepoImpl())..authenticated(),
      ),
      ChangeNotifierProvider<CustomerRequestProvider>(
        create: (_) => CustomerRequestProvider(CustomerRequestsRepoImpl())..fetchCustomerRequests(TypeCode.PMNT),
      ),
      ChangeNotifierProvider<ButtonProvider>(create: (_) => ButtonProvider()),
      ChangeNotifierProvider<DateProvider>(create: (_) => DateProvider()),
    ],
    child: const AccurateApp(),
  );
}
