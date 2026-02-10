import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/screens/cart/cart_model.dart';
import 'package:fresh_market_app/features/screens/order/order_history/order_details.dart';
import 'package:provider/provider.dart';

import 'cart_view_model.dart';

class CartCheckoutPage extends StatefulWidget {
  const CartCheckoutPage({super.key});

  @override
  State<CartCheckoutPage> createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  String? region;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<CartViewModel>(context, listen: false);
        vm.getAllRegions();
        vm.fetchCartItems();
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItemsHeader(),
                    Consumer<CartViewModel>(
                      builder: (context, vm, _) {
                        if (vm.isLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (vm.cartItems.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(child: Text("Your cart is empty")),
                          );
                        }

                        return Column(
                          children: vm.cartItems.map((item) {
                            return _cartItem(
                              item: item,
                              onAdd: () => vm.incrementQuantity(item.id),
                              onRemove: () => vm.decrementQuantity(item.id),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    _sectionTitle("Delivery Details"),
                    _deliveryDetails(),
                    _loyaltySection(),
                    _summarySection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _bottomBar(),
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
        border: Border(bottom: BorderSide(color: Color(0xFFEFEFEF))),
      ),
      child: Row(
        children: [
          BackButton(),
          const Expanded(
            child: Text(
              "My Cart",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Clear",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildItemsHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        "Items",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _cartItem({
    required Cart item,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200, // placeholder image
            ),
            child: const Icon(Icons.shopping_bag),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  item.unitTypeName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${item.price.toStringAsFixed(2)} / ${item.unitTypeName}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _qtyButton(Icons.remove, onRemove),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "${item.quantity}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _qtyButton(Icons.add, onAdd, filled: true),
            ],
          ),
        ],
      ),
    );
  }


  Widget _qtyButton(IconData icon, VoidCallback onTap,
      {bool filled = false}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      style: IconButton.styleFrom(
        backgroundColor: filled ? Colors.green : Colors.grey.shade200,
        foregroundColor: filled ? Colors.white : Colors.black,
        shape: const CircleBorder(),
      ),
    );
  }



  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _deliveryDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Consumer<CartViewModel>(
            builder: (context, vm, _) {
              if (vm.isLoading) return const LinearProgressIndicator();

              return DropdownButtonFormField<Region>(
                value: vm.selectedRegion,
                items: vm.regions.map((r) {
                  return DropdownMenuItem<Region>(
                    value: r,
                    child: Text(r.name),
                  );
                }).toList(),
                onChanged: vm.setSelectedRegion,
                decoration: InputDecoration(
                  labelText: "Delivery Region",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),


          const SizedBox(height: 12),
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              labelText: "Full Address",
              hintText: "Street, Building, Apartment No.",
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }



  Widget _loyaltySection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.loyalty, color: Colors.green),
                SizedBox(width: 8),
                Text("Loyalty Rewards",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Text("540 Points Available",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Redeem 500 points for \$5.00 off",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Redeem"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget _summarySection() {
    return Consumer<CartViewModel>(
        builder: (context, vm, _) {
         return Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF6F8F6),
            child: Column(
              children: [
                _SummaryRow(
                  "Subtotal",
                  "KES ${vm.total.toStringAsFixed(2)}",
                ),
                _SummaryRow("Delivery Fee", "\$2.50"),
                _SummaryRow("Discount", "-\$0.00", highlight: true),
                Divider(),
                _SummaryRow(
                  "Total Amount",
                  "KES ${vm.total.toStringAsFixed(2)}",
                  big: true,
                ),
              ],
            ),
          );
        }
    );
  }



  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEFEFEF))),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderDetailsPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Place Order",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}



class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  final bool big;

  const _SummaryRow(this.label, this.value,
      {this.highlight = false, this.big = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: big ? 16 : 14,
                  fontWeight: big ? FontWeight.bold : FontWeight.normal,
                  color: highlight ? Colors.green : Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontSize: big ? 20 : 14,
                  fontWeight: FontWeight.bold,
                  color: highlight ? Colors.green : Colors.black)),
        ],
      ),
    );
  }
}
