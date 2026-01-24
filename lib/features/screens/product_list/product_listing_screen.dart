import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';
import 'package:fresh_market_app/features/screens/product_details/product_detail_page.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child:  _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          _searchBar(),
          _chips(),
          _sectionHeader(),
          _productGrid(),
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
    return SizedBox(
      height: 60,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          _chip("All", active: true),
          _chip("Vegetables", dropdown: true),
          _chip("Fruits", dropdown: true),
          _chip("Organic"),
        ],
      ),
    );
  }

  Widget _chip(String text, {bool active = false, bool dropdown = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            if (!active)
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 10,
              )
          ],
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : Colors.black,
              ),
            ),
            if (dropdown) const SizedBox(width: 4),
            if (dropdown)
              Icon(Icons.keyboard_arrow_down,
                  size: 18, color: active ? Colors.white : Colors.black)
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: .65,
        children: const [
          ProductCard(
            name: "Vine Tomatoes",
            price: "\$4.50",
            unit: "per kg",
            tag: "Organic",
            image:
            "https://lh3.googleusercontent.com/aida-public/AB6AXuAe4jXcYmORZ6fOmzXvIzxQtLorBNliZxWx2yrdyrcJGP3ulsCJtfn_VDvETCdLYZvV-HexbjGubQhPHyLAHbrLv0NolczXsZmv-0jRVYQYhjxjBgPF35W09vPr0a5W_GI9VlSbK2XQf6c_Hu1gyvbjMt9VIxHHOCkTCiLY4Qzqew9EqEpreCekQL-_sWqzQkrRKDGsBjVPDfxcALKR09bdNxRMgAW3IPBcHOk0jfuA8yBiwdM3b_bjKAzkcbRUUE4qKLa39I2WL0g",
          ),
          ProductCard(
            name: "Organic Kale",
            price: "\$3.00",
            unit: "per bunch",
            tag: "Fresh Picked",
            image:
            "https://lh3.googleusercontent.com/aida-public/AB6AXuBs5ApbiEI6cyteQaR8hOaeVhXwAF8ndV5KNgkxuAAQSzyXPXvOEvhedSchd3h6buXTgYbHACO9vBJTM2hTzphiKIQs6apJ2PLpshGhV1diKRwaa2ZUxBzpF2H8CYOlzRtKVwNOimq3HynuciT30V0u2YQaF6X5RZVMn39PIKbHG6Czb6tFVz36cEveZ02LpcXyzXSuQuxxSz7wNNHImooofxU5tXfv6bF6fte24hSizOm1iiE80fgCszlqm49Rdw5bQMWpo0Z2AD0",
          ),
          ProductCard(
            name: "Dutch Carrots",
            price: "\$2.50",
            unit: "per kg",
            tag: "Fresh Picked",
            image:
            "https://lh3.googleusercontent.com/aida-public/AB6AXuC4wRK7dAoW0n6Qqe1h6aDdtlamSHTPtkmZcUuHPt9LKNcqk0qeiiRb9wr9ElKCrG3ra5NwNOg3WYRQK3MjE9AThd0SV-J15LX_dbft_2nOGOMLyXObfVqsy1iDSSB2qhb0x4pcfmQ6tVObo-n5LCZkYvk9h6L7x2gqG9KT6w7W3YmyQakxCgH770m3NpOZHVAkta7E_bCrbBvumLjOm2df6V6MGjXOnMmqmuIHWu7c6aBuy0cVQkOYc70Ak6uKnCEbohppTa7sRl8",
          ),
          ProductCard(
            name: "Spring Onions",
            price: "\$1.50",
            unit: "per bunch",
            tag: "Organic",
            image:
            "https://lh3.googleusercontent.com/aida-public/AB6AXuAjR-xZ63suBp8k_gpkVAiJb83eoHlACh20gMJjRfGE4twNojNTRkhHQGtwuTcxiy21eGPyo7otHjXE_GU36dz5yCNygPQPnNYnZapS-YWACNjHYedobNLteyd3Yj9sxqQwpdB2p78ZI3hbsYgY-ZEyInxzpmX9RmhgSeReHib4-9faSqHO55vBquAjDO86AyR5S-I2bhtaN0vXHm1bbI6dgq1nWZCFXM_yY5QvijVHS8062iZdQsw8gx1Q6aPmN_m-83dbnUqemkI",
          ),
        ],
      ),
    );
  }


}


class ProductCard extends StatefulWidget {
  final String name, price, unit, tag, image;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.unit,
    required this.tag,
    required this.image,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _navigateToProductDetails();
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
                    child: Image.network(widget.image,
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
                      child: Text(widget.tag,
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
                  Text(widget.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.price,
                          style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold)),
                      Text(widget.unit,
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
                    onPressed: () {},
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

  _navigateToProductDetails() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ProductDetailsPage()));
  }
}


class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem(
      {required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: active ? AppColors.accent : Colors.grey),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight:
                active ? FontWeight.bold : FontWeight.normal,
                color: active
                    ? AppColors.accent
                    : Colors.grey))
      ],
    );
  }
}
