import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/screens/cart/shopping_cart_page.dart';
import 'package:fresh_market_app/features/screens/product/product_list/product.model.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../cart/cart_model.dart';
import '../../cart/cart_view_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

   final Product product;


  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  double quantityKg = 2.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<CartViewModel>(context, listen: false);
      vm.getAllRegions();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(),
                  _buildHeaderImage(),
                  _buildProductHeader(),
                  _buildFreshnessCard(),
                  _buildQuantitySelector(),
                  _buildDescription(),
                  _buildExpandableSection(
                    icon: Icons.restaurant,
                    title: "Nutritional Information",
                  ),
                  _buildExpandableSection(
                    icon: Icons.kitchen,
                    title: "Storage & Handling",
                  ),
                ],
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }


  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEFEFEF)),
        ),
      ),
      child: Row(
        children: [
          BackButton(),
          const Expanded(
            child: Text(
              "Product Details",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 320,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage(
            "https://lh3.googleusercontent.com/aida-public/AB6AXuCtYPKXjqgotwbi9P8nFZjQWZNB-pJYRvsPEfn1qMCAocqbM9HpagVzd6ZjnS1CLB3jSkra1Mg8Mx0hiHo11ZDi4ugHc4UfKU5iy3MRR3eMdUjs2kZWyiuca3pWG-LyB0HNzkoqZQJK9aD7xdasj1-9-0wmGIYzNJuc5ufy1p0x7GtOwtA2l5RDpf614mZMXyLYi72xxjwE_ZESWhFg3x9Lys_XEwz9RyvgV4C8_BD2P1EkdTXvq7c6I_XnJ8TMAvkAcZC2vyudc_k",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.topRight,
        child: Chip(
          avatar: const Icon(Icons.verified, color: Colors.green, size: 18),
          label:  Text(
            widget.product.category ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Source: Michoacán, Mexico",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Text(
                "KES ${widget.product.price.toString()}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "per ${widget.product.unit ?? ""}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFreshnessCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.eco, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  "Batch Freshness",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "PEAK QUALITY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Harvested: Oct 24, 2023 • Batch: #AVO-0922"),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.85,
              backgroundColor: Colors.grey.shade300,
              valueColor:
              const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 8),
            const Text(
              "Expected to remain fresh for ~5 more days if refrigerated.",
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Quantity",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _qtyButton(Icons.remove, () {
                setState(() {
                  if (quantityKg > 1) quantityKg--;
                });
              }),
              Column(
                children: [
                  Text(
                    "${quantityKg.toStringAsFixed(1)} ${widget.product.unit ?? ""}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Approx. 6–8 pieces",
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              _qtyButton(Icons.add, () {
                setState(() {
                  quantityKg++;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, size: 28),
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description ?? "",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(
      {required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.expand_more),
      onTap: () {},
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEFEFEF))),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "\$${(quantityKg * 4.5).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final vm = context.read<CartViewModel>();

                  debugPrint('add to cart call');

                  bool isSuccess = await vm.addSelectedToCart(
                    productId: widget.product.id,
                    selectedUnitTypeId: widget.product.unitId ,
                    quantity: quantityKg,
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
                icon: const Icon(Icons.shopping_basket),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
