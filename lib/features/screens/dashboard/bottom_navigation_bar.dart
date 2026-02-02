import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/auth/view/user_profile.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';
import 'package:fresh_market_app/features/screens/cart/shopping_cart_page.dart';
import 'package:fresh_market_app/features/screens/dashboard/home_screen.dart';
import 'package:fresh_market_app/features/screens/product/product_category/product_category_page.dart';

import '../product/product_list/product_listing_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  final PageStorageBucket _bucket = PageStorageBucket();
  Widget _currentScreen = const FreshMarketHome();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        bucket: _bucket,
        child: _currentScreen,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        shape:  RoundedRectangleBorder( // <= Change BeveledRectangleBorder to RoundedRectangularBorder
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          _navigateToCart();
        },
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.shopping_basket,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        notchMargin: 3.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const FreshMarketHome();
                        _selectedIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: _selectedIndex == 0 ? AppColors.primary : AppColors.textSecondary,
                        ),
                        Text("Home", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
                        // AppTextStyle().customizableTex(
                        //     'Dashboard',
                        //     _selectedIndex == 0 ? _appColors.orangeYellow : _appColors.normalTextColor,
                        //     FontWeight.w400,
                        //     12)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const CategoriesPage();
                        _selectedIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category,
                          color: _selectedIndex == 1 ? AppColors.primary : AppColors.textSecondary,
                        ),
                        Text("Explore", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
                        // AppTextStyle().customizableTex(
                        //     'Quotes',
                        //     _selectedIndex == 1 ? _appColors.orangeYellow : _appColors.normalTextColor,
                        //     FontWeight.w400,
                        //     12)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const MarketplacePage();
                        _selectedIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shop,
                          color: _selectedIndex == 2 ? AppColors.primary : AppColors.textSecondary,
                        ),
                        Text("Market", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
                        // AppTextStyle().customizableTex(
                        //     'Activities',
                        //     _selectedIndex == 2 ? _appColors.orangeYellow : _appColors.normalTextColor,
                        //     FontWeight.w400,
                        //     12)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const ShopperProfileScreen();
                        _selectedIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu,
                          color: _selectedIndex == 3 ? AppColors.primary : AppColors.textSecondary,
                        ),
                        Text("Profile", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _navigateToCart() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CartCheckoutPage()));
  }
}
