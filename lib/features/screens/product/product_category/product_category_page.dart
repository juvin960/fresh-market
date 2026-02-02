import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/category_card.dart';
import '../../../core/app_colors.dart';
import 'category_view_model.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  static const primary = Color(0xFF13EC13);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<CategoryViewModel>(context, listen: false);
      vm.fetchCategory();
    });
  }


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _filters(),
            Expanded(child: _categoriesGrid(vm)),
          ],
        ),
      ),
      // bottomNavigationBar: _bottomNav(),
    );
  }



  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _iconButton(Icons.notifications, badge: true),
                  const SizedBox(width: 12),
                  _iconButton(Icons.shopping_bag, filled: true),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          _searchBar(false),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, {bool badge = false, bool filled = false}) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: filled ? AppColors.accent : Colors.white,
          child: Icon(icon, color: filled ? Colors.black : Colors.grey[800]),
        ),
        if (badge)
          const Positioned(
            top: 6,
            right: 6,
            child: CircleAvatar(radius: 4, backgroundColor: AppColors.accent),
          )
      ],
    );
  }

  Widget _searchBar(bool isDark) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2E1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          SizedBox(width: 12),
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search fresh produce...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _filters() {
    final filters = ["All", "On Sale", "New Batches", "Seasonal"];
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == 0;
          return Chip(
            label: Text(filters[index]),
            backgroundColor: selected ? Colors.black : Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }


  Widget _categoriesGrid(CategoryViewModel vm) {
    final vm = Provider.of<CategoryViewModel>(context);

    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null) {
      return Center(child: Text(vm.errorMessage!));
    }

    final categories = vm.category;

    if (categories.isEmpty) {
      return const Center(child: Text("No categories available"));
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return CategoryCard(
          title: cat.name,
          items: "${cat.name} items",
          image: 'https://via.placeholder.com/150',
        );
      },
    );
  }


  // Widget _bottomNav() {
  //   return Container(
  //     padding: const EdgeInsets.only(bottom: 16, top: 12),
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       border: Border(top: BorderSide(color: Colors.black12)),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         _navItem(Icons.home, "Home"),
  //         _navItem(Icons.grid_view, "Categories", active: true),
  //         FloatingActionButton(
  //           backgroundColor: CategoriesPage.primary,
  //           onPressed: () {},
  //           child: const Icon(Icons.qr_code_scanner, color: Colors.black),
  //         ),
  //         _navItem(Icons.shopping_cart, "Cart", badge: true),
  //         _navItem(Icons.person, "Profile"),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _navItem(IconData icon, String label, {bool active = false, bool badge = false}) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Stack(
  //         children: [
  //           Icon(icon, color: active ? CategoriesPage.primary : Colors.grey),
  //           if (badge)
  //             const Positioned(
  //               top: 0,
  //               right: 0,
  //               child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
  //             )
  //         ],
  //       ),
  //       const SizedBox(height: 4),
  //       Text(
  //         label,
  //         style: TextStyle(fontSize: 10, color: active ? CategoriesPage.primary : Colors.grey),
  //       ),
  //     ],
  //   );
  // }
}
