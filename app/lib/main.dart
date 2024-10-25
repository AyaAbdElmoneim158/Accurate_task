import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'accurate_app.dart';
import 'core/helper/cache_helper.dart';
import 'core/helper/graph_ql_config.dart';
import 'features/auth/data/repo/auth_repo_impl.dart';
import 'features/auth/presentation/view_model/auth_provider.dart';

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
    ],
    child: const AccurateApp(),
  );
}
