import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/order_items.dart';
import '../../cart/cart_model.dart';
import '../../cart/cart_view_model.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({
    super.key,
    required this.address,
    this.region,
  });

  final String address;
  final Region? region;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Top App Bar
              Container(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 16,
                  right: 16,
                  bottom: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withValues(alpha: 0.9),
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: () {}, child: const BackButton()),
                    const Text(
                      'Order #8829',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Help',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 120),
                  children: [
                    const SizedBox(height: 16),

                    // Timeline
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: const [
                          TimelineStep(
                            title: "Order Placed",
                            subtitle: "10:00 AM",
                            completed: true,
                          ),
                          TimelineStep(
                            title: "Picked & Packed",
                            subtitle: "11:30 AM",
                            completed: true,
                            tag: "All batches verified",
                          ),
                          TimelineStep(
                            title: "Out for Delivery",
                            subtitle: "Est. Arrival: 2:00 PM",
                            active: true,
                          ),
                          TimelineStep(title: "Delivered", subtitle: ""),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Delivery Address Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.location_on),
                                      SizedBox(width: 8),
                                      Text(
                                        "Delivery Address",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "123 Green St, Springfield\nApt 4B",
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBeP_ShvWVjFGJ5WD9Zvr3ZwZvqziOguuFFnTjUW46ro0utQoxxNVeFJxPCrKZFtKwEDEd2x74EDt-kbcL3VTh3bsX8buG7BSPp03ciu0VTASDOe0qaUju2sziywZltj07NV2NEVjumSxuDrVIDR2nWRFDsF6QEv89a21WBY1eKTHQkepQMJ0NRtA_9TTycjU5V8wCe4zdMLQaC8qn70IcLIgCiBGM7tvQnMvmCVR2oK2p-AiHfL1osX_5DI6k9XJPRd8TSHewm9NI',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Driver: Mike",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Items List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Items ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Chip(
                            label: Text("Verified Fresh"),
                            backgroundColor: Colors.greenAccent,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
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
                            child: Center(child: Text(" No order available")),
                          );
                        }

                        return Column(
                          children:
                              vm.cartItems.map((item) {
                                return _orderItems(item: item);
                              }).toList(),
                        );
                      },
                    ),

                    // const OrderItem(
                    //   imageUrl:
                    //   "https://lh3.googleusercontent.com/aida-public/AB6AXuCfbG8SDs3hzoFeFBv5hYHK92y6kcE2BxcdBunhWyqGvzoStvpn5Yv2sLmh-ZnqWzE3pM6_NyUIBnz8GWtfMqfkiWU_IDQI0IOkTKeL59P21ZEf28r_E-BL2ol1zmZvDhQ3-AN61d1RT3D3JqhaZ6nwI5DAqLOTYsI3XHusH5MobPJJoKniPQxPRZYZp7aDHrX9w8bJUuIZddADzBruyNRqdTSRRuevY4LvunXEHeOwT_lEjtMRqfgEdznBHT7qDIO7_mdLKOLeQ_g",
                    //   name: "Fuji Apples",
                    //   price: "\$6.00",
                    //   batch: "Batch #B-992",
                    //   details: "2kg @ \$3.00/kg",
                    // ),
                    // const Divider(),
                    // const OrderItem(
                    //   imageUrl:
                    //   "https://lh3.googleusercontent.com/aida-public/AB6AXuDxFxhu9ZO0bYuMiDnbc6fRJ31gizJS-3fqMBF_gDHtqrMD466MFD7kc8eoAzH24C5jL5Wu3nAzl8Y6Vaabenl6qY2z9qWWIDXzyEXoS2Qzn9juT0HvVglIIi9pAo18cJo-_NRnx8oIJRzl0HD-VdLZyC-JduTpamqoXWY7i3bHr1-VJrevZ9MArYGv008tnlNrK3XgG2Fl9mMo_spYOhf1ASBiqH6LFFzU8UdK8dE8zIRs3qU-p_2Px2o7ipWEgZid-JWC8oRnia8",
                    //   name: "Spinach Bunch",
                    //   price: "\$1.50",
                    //   batch: "Batch #S-101",
                    //   details: "1 count @ \$1.50",
                    // ),
                    const SizedBox(height: 16),

                    // Cost Breakdown
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Consumer<CartViewModel>(
                        builder: (context, vm, _) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Subtotal"),
                                    Text("KES ${vm.total.toStringAsFixed(2)}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Delivery Fee"),
                                    Text("\$2.00"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [Text("Tax"), Text("\$0.00")],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "KES ${vm.total.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),

          // Sticky Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.receipt_long),
                      label: const Text("Invoice"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[300]
                                : Colors.grey[800],
                        foregroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reorder Items"),
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
          ),
        ],
      ),
    );
  }

  Widget _orderItems({required Cart item}) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 64,
              width: 64,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuC0b_5JRYT6GYbjNZe6j0nA_UOuoSzRkEwXvmvoIVfl7mbO40h9sesK-0A-Exf0aJ5bhobM7m5HeSieEf5BNw0q0qbutcLlSHrs9WMnn8Sl7jckewr_fgd-bapYAYEbP-X6nszkqtF_JWIfcBw9vMlBvXo3lvcmhBIsKMQXTm-VihkFIzzCKD6QVeJNtJTwch2vWTupmK2EpSA0GTSMniZRIbuj1ZccqhElAyC8O2sJsBLZszLeUkc3PhF1OGUpZ4-Jh_fa8A9_08Q",
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Container(color: Colors.grey.shade200),
                ),
              ),
            ),
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
                  style: const TextStyle(fontSize: 12, color: Colors.green),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${item.price.toStringAsFixed(2)} / ${item.unitTypeName}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          Text(
            "\$${(item.price * item.quantity).toStringAsFixed(2)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
