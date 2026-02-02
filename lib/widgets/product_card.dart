
import 'package:flutter/material.dart';

import '../features/core/app_colors.dart';
import '../features/screens/product/product_details/product_detail_page.dart';

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