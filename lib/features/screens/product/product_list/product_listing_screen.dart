import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/product_card.dart';
import '../../../core/app_colors.dart';
import '../product_list/product.model.dart';
import '../product_list/product_view_model.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  String _activeChip = "All";
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<ProductViewModel>(context, listen: false);
      if (vm.products.isEmpty) vm.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) return const Center(child: CircularProgressIndicator());
        if (vm.errorMessage != null) return Center(child: Text(vm.errorMessage!));


        final filteredProducts = vm.products.where((p) {
          final matchesCategory = _activeChip == "All" || p.category == _activeChip;
          final matchesSearch = p.name.toLowerCase().contains(_searchQuery.toLowerCase());
          return matchesCategory && matchesSearch;
        }).toList();


        final chipList = ["All", ...vm.categories];

        return Scaffold(
          backgroundColor: AppColors.bgLight,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topBar(),
                  const SizedBox(height: 10),
                  _searchBar(),
                  const SizedBox(height: 10),
                  _chips(chipList),
                  const SizedBox(height: 10),
                  _sectionHeader(),
                  const SizedBox(height: 10),
                  _productGrid(filteredProducts),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.menu, size: 26),
              SizedBox(width: 10),
              Text(
                "Marketplace",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  const Icon(Icons.shopping_basket, size: 26),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: AppColors.accent,
                      child: const Text(
                        "3",
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 16),
              const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCImd7jEYUESX_0D37gDyTqeDLG4ppBcWqL_MqtjqSF4UqVKlJehR4WCa9sNqZuSXwKGxMQERH_GRbWI7B6Jnd9i_DhZb90dIE_GkcOqtmlfdyvwVBkXGjJxiIt31szkcGi7R4dxT3IwBuhNbMW56M_pVyfKvqcuW0YPrf0TCE502hULrMHUUYO0phQMXix1rA81xIk8kO3uX-68bkJBgfjqNo2r2FgVPAYwoX4DW4guKw0QXuEu3GZ915nXMxeHJnWwpx1ySal0d8",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: "Search fresh vegetables, fruits...",
          hintStyle: const TextStyle(color: Color(0xFF618961)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF618961)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }


  Widget _chips(List<String> chipList) {
    if (chipList.isEmpty) return const SizedBox();

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: chipList.length,
        itemBuilder: (context, index) {
          final cat = chipList[index];
          final isActive = _activeChip == cat;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _activeChip = cat),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.accent : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    if (!isActive)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      )
                  ],
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: isActive ? Colors.white : const Color(0xFF618961),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _sectionHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Fresh Arrivals",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "View All",
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }


  Widget _productGrid(List<Product> products) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text("No products found.")),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: .65,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            name: product.name,
            price: "\$${product.price}",
            unit: product.unit ?? "per unit",
            tag: product.category ?? "Fresh",
            image: product.imageUrl ?? "https://via.placeholder.com/150",
          );
        },
      ),
    );
  }
}
