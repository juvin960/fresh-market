import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/auth/view/forgot_password.dart';
import 'package:fresh_market_app/features/auth/view/user_login_screen.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';

import 'features/auth/view/user_profile.dart';
import 'features/auth/view/user_registration_screen.dart';
import 'features/screens/cart/shopping_cart_page.dart';
import 'features/screens/dashboard/home_screen.dart';
import 'features/screens/order_tracking/order_tracking_page.dart';
import 'features/screens/product_category/product_category_page.dart';
import 'features/screens/product_details/product_detail_page.dart';
import 'features/screens/product_list/product_listing_screen.dart';

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
      home: const UserLoginScreen(),
    );
  }
}
