import 'package:flutter/material.dart';

class CartCheckoutPage extends StatefulWidget {
  const CartCheckoutPage({super.key});

  @override
  State<CartCheckoutPage> createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  int kaleQty = 1;
  int avocadoQty = 3;
  String region = "Downtown Metro Area";

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
                    _cartItem(
                      image:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBKJDcOQkOU63zWDUVmphFXW-ohvy5pVblSCepMFsAW-Iu9Gl8QHGH3YToukA0jfz0U5TSLveb6RIEZB3HNGFbK-JtzAwjZIEkmSzk3aPpsdGkuDu1s6vwsD7MfMTdF57_DnrruBfw88hISe_u0gh9tmZ7UGKc-ERPhstdxNSxnE0nEZwMfj6nLoMW_gxLg81eJ77ZMTGA7EXYDlV3bDk_aKRhk1-zSYzkLCy2YeuJ82Veyag_hTEHbJ0aqGu6OuHLjxcWrKH8CWBs",
                      title: "Organic Kale",
                      subtitle: "Batch #429 • Harvested Today",
                      price: "\$4.50 / kg",
                      qty: kaleQty,
                      onAdd: () => setState(() => kaleQty++),
                      onRemove: () =>
                          setState(() => kaleQty = kaleQty > 1 ? kaleQty - 1 : 1),
                    ),
                    _cartItem(
                      image:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuDOaPf-wab3XInOn11naVCfpmnBXQ2T5ss4XkijVc5Qf3NM8uLkBRkEPx_PuxV3w84q9LrVqs-Ldn8Fq9guOvKWdcu1rvpbtjoBUJ5Si3JPFI5QMqnvLlmvc4sDxwxHbq9Z2fto1GDvvQcucawohkHGoVr4z1Mh0mOX7QnEAYmzityfOa8i5NQKOPHx2dma4EeH7a-DDD4X_Uy_yO4mfZDJMBVDXbD4tmT5BS1Dmr0n-5dikLSnQLtZx_6U1O2GrJTi7oCFnk9ejEw",
                      title: "Hass Avocado",
                      subtitle: "Batch #102 • Farm Fresh",
                      price: "\$2.00 / pc",
                      qty: avocadoQty,
                      onAdd: () => setState(() => avocadoQty++),
                      onRemove: () => setState(() =>
                      avocadoQty = avocadoQty > 1 ? avocadoQty - 1 : 1),
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
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
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
        "Items (3)",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _cartItem({
    required String image,
    required String title,
    required String subtitle,
    required String price,
    required int qty,
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
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.green)),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              _qtyButton(Icons.remove, onRemove),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "$qty",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
          DropdownButtonFormField<String>(
            value: region,
            items: const [
              DropdownMenuItem(
                  value: "Downtown Metro Area",
                  child: Text("Downtown Metro Area")),
              DropdownMenuItem(
                  value: "Northern Suburbs",
                  child: Text("Northern Suburbs")),
              DropdownMenuItem(
                  value: "East Harbor District",
                  child: Text("East Harbor District")),
            ],
            onChanged: (val) => setState(() => region = val!),
            decoration: InputDecoration(
              labelText: "Delivery Region",
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
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
          color: Colors.green.withOpacity(0.1),
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
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFF6F8F6),
      child: Column(
        children: const [
          _summaryRow("Subtotal", "\$10.50"),
          _summaryRow("Delivery Fee", "\$2.50"),
          _summaryRow("Discount", "-\$0.00", highlight: true),
          Divider(),
          _summaryRow("Total Amount", "\$13.00", big: true),
        ],
      ),
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
          onPressed: () {},
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



class _summaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  final bool big;

  const _summaryRow(this.label, this.value,
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
