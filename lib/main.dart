import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/auth/view/user_login_screen.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';

import 'features/screens/rider/rider_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namco App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans',
      ),
      home: const RiderDashboardPage(),
    );
  }
}
