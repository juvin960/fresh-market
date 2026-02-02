import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/auth/view/user_login_screen.dart';
import 'package:fresh_market_app/features/auth/view/user_registration_screen.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';
import 'package:provider/provider.dart';
import 'features/auth/view/splash_screen.dart';
import 'features/auth/view_model/auth_view-model.dart';
import 'features/services/locations.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthViewModel>()),

      ],
      child: MaterialApp(
        title: 'Namco App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
          useMaterial3: true,
          fontFamily: 'PlusJakartaSans',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
