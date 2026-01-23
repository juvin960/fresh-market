import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/auth/view/forgot_password.dart';
import 'package:fresh_market_app/features/auth/view/user_login_screen.dart';

import 'features/auth/view/user_profile.dart';
import 'features/auth/view/user_registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF13EC13)),
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans',
      ),
      home: const ShopperProfileScreen(),
    );
  }
}
