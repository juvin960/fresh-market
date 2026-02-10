import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/screens/product/product_category/category_model.dart';
import 'package:fresh_market_app/features/screens/product/product_list/product.model.dart';
import 'package:fresh_market_app/features/screens/product/product_list/product_view_model.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../cart/cart_view_model.dart';
import '../../cart/shopping_cart_page.dart';
import '../product_category/category_view_model.dart';
import '../product_details/product_detail_page.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {

  final ScrollController _scrollController = ScrollController();
  late ProductViewModel productsViewModel;
  int _selectedCategoryId = 0;
  bool _isAllCategorySelected = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<CategoryViewModel>(context, listen: false);

      if (vm.isCategoryListEmpty()) {
        vm.fetchCategory();
      }

      productsViewModel = Provider.of<ProductViewModel>(context, listen: false);

      if (productsViewModel.isProductListEmpty()) {
        productsViewModel.fetchProducts();
      }
    });
    print('MarketplacePage initialized');
    _scrollController.addListener(_scrollListener);

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // final vm = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child:  _body(),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          _searchBar(),
          const SizedBox(height: 16),
          _chips(),
          _sectionHeader(),

          Expanded(
            child: _productGrid(),
          ),
          LinearProgressIndicator(
            value: Provider.of<ProductViewModel>(context).isLoading ? null : 0,
            backgroundColor: Colors.transparent,
            color: AppColors.accent,
          ),
        ],
      ),
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
              )
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
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
              )
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

  Widget _chips() {
    return Consumer<CategoryViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.errorMessage != null) {
          return SizedBox(
            height: 60,
            child: Center(child: Text(vm.errorMessage!)),
          );
        }

        return SizedBox(
          height: 60,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: vm.categories.length,
            itemBuilder: (context, index) {
              final category = vm.categories[index];
              productsViewModel = Provider.of<ProductViewModel>(context);
              return AbsorbPointer(
                absorbing: productsViewModel.isLoading,
                child: GestureDetector(
                    onTap: () {
                      productsViewModel.clearProducts();
                      category.isSelected = true;
                      _selectedCategoryId =  category.id;
                
                      category.id == 0 ? _isAllCategorySelected = true :  _isAllCategorySelected = false;
                
                      for (var cat in vm.categories) {
                        if (cat.id != category.id) {
                          cat.isSelected = false;
                        }
                      }
                
                      setState(() {});
                      // call method to fetch products in the selected category
                      if ( category.id == 0) {
                        productsViewModel.fetchProducts();
                      } else {
                        productsViewModel.fetchProducts(categoryId: category.id);
                      }
                
                
                
                    },
                    child: _chip(category: category)
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _chip({required Category category}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: category.isSelected ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            if (!category.isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 10,
              )
          ],
        ),
        child: Text(
          category.name,
          style: TextStyle(
            color: category.isSelected ? Colors.white : const Color(0xFF618961),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Fresh Arrivals",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "View All",
            style: TextStyle(
                color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _productGrid() {
    return Consumer<ProductViewModel>(
      builder: (context, vm, _) {
        // if (vm.isLoading) {
        //   return const SizedBox(
        //     height: 60,
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // }
        //
        // if (vm.errorMessage != null) {
        //   return SizedBox(
        //     height: 60,
        //     child: Center(child: Text(vm.errorMessage!)),
        //   );
        // }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: .65,
              ),
              itemCount: vm.products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = vm.products[index];

                return ProductCard(
                product: product,
                );
              }
          ),
        );

        // return Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: GridView.count(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 14,
        //     mainAxisSpacing: 14,
        //     childAspectRatio: .65,
        //     children: const [
        //       ProductCard(
        //         name: "Vine Tomatoes",
        //         price: "\$4.50",
        //         unit: "per kg",
        //         tag: "Organic",
        //         image:
        //         "https://lh3.googleusercontent.com/aida-public/AB6AXuAe4jXcYmORZ6fOmzXvIzxQtLorBNliZxWx2yrdyrcJGP3ulsCJtfn_VDvETCdLYZvV-HexbjGubQhPHyLAHbrLv0NolczXsZmv-0jRVYQYhjxjBgPF35W09vPr0a5W_GI9VlSbK2XQf6c_Hu1gyvbjMt9VIxHHOCkTCiLY4Qzqew9EqEpreCekQL-_sWqzQkrRKDGsBjVPDfxcALKR09bdNxRMgAW3IPBcHOk0jfuA8yBiwdM3b_bjKAzkcbRUUE4qKLa39I2WL0g",
        //       ),
        //       ProductCard(
        //         name: "Organic Kale",
        //         price: "\$3.00",
        //         unit: "per bunch",
        //         tag: "Fresh Picked",
        //         image:
        //         "https://lh3.googleusercontent.com/aida-public/AB6AXuBs5ApbiEI6cyteQaR8hOaeVhXwAF8ndV5KNgkxuAAQSzyXPXvOEvhedSchd3h6buXTgYbHACO9vBJTM2hTzphiKIQs6apJ2PLpshGhV1diKRwaa2ZUxBzpF2H8CYOlzRtKVwNOimq3HynuciT30V0u2YQaF6X5RZVMn39PIKbHG6Czb6tFVz36cEveZ02LpcXyzXSuQuxxSz7wNNHImooofxU5tXfv6bF6fte24hSizOm1iiE80fgCszlqm49Rdw5bQMWpo0Z2AD0",
        //       ),
        //       ProductCard(
        //         name: "Dutch Carrots",
        //         price: "\$2.50",
        //         unit: "per kg",
        //         tag: "Fresh Picked",
        //         image:
        //         "https://lh3.googleusercontent.com/aida-public/AB6AXuC4wRK7dAoW0n6Qqe1h6aDdtlamSHTPtkmZcUuHPt9LKNcqk0qeiiRb9wr9ElKCrG3ra5NwNOg3WYRQK3MjE9AThd0SV-J15LX_dbft_2nOGOMLyXObfVqsy1iDSSB2qhb0x4pcfmQ6tVObo-n5LCZkYvk9h6L7x2gqG9KT6w7W3YmyQakxCgH770m3NpOZHVAkta7E_bCrbBvumLjOm2df6V6MGjXOnMmqmuIHWu7c6aBuy0cVQkOYc70Ak6uKnCEbohppTa7sRl8",
        //       ),
        //       ProductCard(
        //         name: "Spring Onions",
        //         price: "\$1.50",
        //         unit: "per bunch",
        //         tag: "Organic",
        //         image:
        //         "https://lh3.googleusercontent.com/aida-public/AB6AXuAjR-xZ63suBp8k_gpkVAiJb83eoHlACh20gMJjRfGE4twNojNTRkhHQGtwuTcxiy21eGPyo7otHjXE_GU36dz5yCNygPQPnNYnZapS-YWACNjHYedobNLteyd3Yj9sxqQwpdB2p78ZI3hbsYgY-ZEyInxzpmX9RmhgSeReHib4-9faSqHO55vBquAjDO86AyR5S-I2bhtaN0vXHm1bbI6dgq1nWZCFXM_yY5QvijVHS8062iZdQsw8gx1Q6aPmN_m-83dbnUqemkI",
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      // You have reached the bottom of the list
      // Implement your logic here (e.g., fetch more data)
      print("Reached the bottom!");

      // Check if there are more pages to load
      _getProductsNextPage();
    }
  }

  void _getProductsNextPage() {
    print("next has called 1 current ${productsViewModel.currentPage} last ${productsViewModel.lastPage}");
    // Check if there are more pages to load
    if (productsViewModel.currentPage < productsViewModel.lastPage) {
      int nextPage = productsViewModel.currentPage + 1;
      print("next has called 2");

      if (_isAllCategorySelected) {
        productsViewModel.fetchProducts(page: nextPage );
      } else  {
        productsViewModel.fetchProducts(categoryId: _selectedCategoryId ,page: nextPage);
      }
    }
  }

}


class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,

  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _navigateToProductDetails(product: widget.product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: .05), blurRadius: 12)
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network( "https://lh3.googleusercontent.com/aida-public/AB6AXuAe4jXcYmORZ6fOmzXvIzxQtLorBNliZxWx2yrdyrcJGP3ulsCJtfn_VDvETCdLYZvV-HexbjGubQhPHyLAHbrLv0NolczXsZmv-0jRVYQYhjxjBgPF35W09vPr0a5W_GI9VlSbK2XQf6c_Hu1gyvbjMt9VIxHHOCkTCiLY4Qzqew9EqEpreCekQL-_sWqzQkrRKDGsBjVPDfxcALKR09bdNxRMgAW3IPBcHOk0jfuA8yBiwdM3b_bjKAzkcbRUUE4qKLa39I2WL0g",


                        width: double.infinity, fit: BoxFit.cover),
                  ),

                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: .9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(widget.product.category ?? "",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.price.toString(),
                          style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold)),
                      Text( "per ${widget.product.unit}",
                          style: const TextStyle(
                              fontSize: 10, color: Color(0xFF618961)))
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      final vm = context.read<CartViewModel>();

                      bool isSuccess = await vm.addSelectedToCart(
                        productId: widget.product.id,
                        selectedUnitTypeId: widget.product.unitId,
                        quantity: 2.0,

                      );
                      if (! mounted) return;
                      if(isSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart!')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartCheckoutPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(vm.errorMessage ?? 'Failed to add to cart')),
                        );
                        return;
                      }



                    },
                    icon: const Icon(Icons.add_shopping_cart, size: 16),
                    label: const Text("Add",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _navigateToProductDetails({required Product product}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product,)));
  }
}

//
// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool active;
//
//   const _NavItem(
//       {required this.icon, required this.label, this.active = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, color: active ? AppColors.accent : Colors.grey),
//         const SizedBox(height: 2),
//         Text(label,
//             style: TextStyle(
//                 fontSize: 10,
//                 fontWeight:
//                 active ? FontWeight.bold : FontWeight.normal,
//                 color: active
//                     ? AppColors.accent
//                     : Colors.grey))
//       ],
//     );
//   }
// }
