import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        title: const Text(
          "Order History",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const _FilterChips(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                OrderCard(
                  status: OrderStatus.delivered,
                  date: "Oct 24, 2023 • 10:30 AM",
                  orderNo: "#12345",
                  title: "Organic Gala Apples, Bananas & 10 more",
                  sub: "Batch Verified: #B-9281",
                  price: "\$45.20",
                  image:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuBesGMr1ur_GdgAjrndxwwkNiEYUz3JMrCA7V5IVvGjFJJUz_Fhz8gKa9sUgF_c33CM12v2LYxS73DBYwCn98NS_qsxc20ICdhVjh9jort88ZGhs2XVEHFs_Y7tqz98QwxOL5dyiamKRxEUeAsiahgAk85gUDL3Tnrsy0p3gNy4g0gLgUYzfUk5MVsMRcaUVs57jYpJJSkazMiFuoIYvgHhZGQuIUevkyi0jARyzLJemBAb0x6VhTL0uWNLtsdScMZepI9gBTHCspI",
                  actions: [OrderAction.invoice, OrderAction.reorder],
                ),
                OrderCard(
                  status: OrderStatus.processing,
                  date: "Today • 2:15 PM",
                  orderNo: "#12348",
                  title: "Fresh Kale Bundle, Avocados (4)",
                  sub: "Est. Delivery: 5:00 PM",
                  price: "\$24.50",
                  image:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDqSDMaebBZItJgVbLqKkldcWCxQg0oZdR-_CX0jJBXrshMuLbteiBRwnmgZz7BBLRaF_CyK79pnLVcUeYiht8SbvjvNSujhxEQpIydsxGQ7qXgXErNIvH2p4oecwO9O3vrE96TywkhW-tgHbjazmjlb-XVdCSGPtra08hVbSvxA1rwlcNm6mDebunesj7E7Z-TSoEvcU787e72qFwK-FSxRHJwN3MsGL08SWVAa-XNW9slYNteCjbwcWyqZRYXeNxYTINjLj_5Prg",
                  actions: [OrderAction.track],
                ),
                OrderCard(
                  status: OrderStatus.cancelled,
                  date: "Sep 28, 2023 • 5 Items",
                  orderNo: "#11002",
                  title: "Vine Tomatoes, Basil Plant",
                  price: "\$12.40",
                  image:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDrZVyGpaz7VHsdShBuWMJjFrkgT9vJeMtD5smftvIn0Ztg_CAD4KhgHnNMQhdtX6A31K0uSTwVFVm1MAMNv-kzRwD9RxMiZaEiJVrB8oOJr61MnZLNkZ4qwH6e2fRNVLbjMPOhOUhqGlRKvEVxrM-0qKQ0bren2dZ-ZP-FF-38eeGA-veqxoZxyVnUxtwjo5CPbMhlJMjfzpubXd4Row8pZnp5CjTnrs3h4lQ4geSpaPNCkVEJkx912mXMLEBvfyh40OJ7IzY-t2w",
                  actions: [OrderAction.help],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}


class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          _Chip("All", active: true),
          _Chip("Delivered"),
          _Chip("Processing"),
          _Chip("Cancelled"),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;

  const _Chip(this.label, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: active,
        selectedColor: Colors.greenAccent,
        onSelected: (_) {},
      ),
    );
  }
}


class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long), label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}


enum OrderStatus { delivered, processing, cancelled }
enum OrderAction { invoice, reorder, track, help }

class OrderCard extends StatelessWidget {
  final OrderStatus status;
  final String date;
  final String orderNo;
  final String title;
  final String? sub;
  final String price;
  final String image;
  final List<OrderAction> actions;

  const OrderCard({
    super.key,
    required this.status,
    required this.date,
    required this.orderNo,
    required this.title,
    this.sub,
    required this.price,
    required this.image,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status) {
      case OrderStatus.delivered:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = "Delivered";
        break;
      case OrderStatus.processing:
        statusColor = Colors.orange;
        statusIcon = Icons.inventory_2;
        statusText = "Processing";
        break;
      case OrderStatus.cancelled:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = "Cancelled";
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(date,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(orderNo,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 16, color: statusColor),
                    const SizedBox(width: 4),
                    Text(statusText,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    if (sub != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(sub!,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ),
                    const SizedBox(height: 8),
                    Text(price,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: actions
                .map((a) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _ActionButton(action: a),
              ),
            ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final OrderAction action;

  const _ActionButton({required this.action});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String label;
    Color? color;
    Color textColor = Colors.white;

    switch (action) {
      case OrderAction.invoice:
        icon = Icons.receipt;
        label = "Invoice";
        color = Colors.transparent;
        textColor = Colors.grey[800]!;
        break;
      case OrderAction.reorder:
        icon = Icons.refresh;
        label = "Reorder";
        color = Colors.green;
        textColor = Colors.white;
        break;
      case OrderAction.track:
        icon = Icons.location_on;
        label = "Track Order";
        color = Colors.grey[800];
        textColor = Colors.white;
        break;
      case OrderAction.help:
        icon = Icons.help;
        label = "Get Help";
        color = Colors.grey[800];
        textColor = Colors.white;
        break;
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        elevation: 0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}
//           boxShadow: [
//             BoxShadow(color: Colors.black12, blurRadius: 4),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(image,


//                 width: double.infinity, fit: BoxFit.cover),
//             ),
//             const SizedBox(height: 8),
//             Text(title,











