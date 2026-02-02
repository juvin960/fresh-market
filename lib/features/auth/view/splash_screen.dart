import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/auth/view/user_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/dashboard/bottom_navigation_bar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSignupStatus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }


  Future<void> _checkSignupStatus() async {
    await Future.delayed(Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    debugPrint('Stored token: $token');

    final isLoggedIn = token != null && token.trim().isNotEmpty;

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavigation()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserLoginScreen()),
      );
    }
  }


}
