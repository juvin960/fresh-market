import 'package:flutter/material.dart';

class DeliveryAddressesPage extends StatefulWidget {
  const DeliveryAddressesPage({super.key});

  @override
  State<DeliveryAddressesPage> createState() => _DeliveryAddressesPageState();
}

class _DeliveryAddressesPageState extends State<DeliveryAddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Top AppBar
              Container(
                padding:
                const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border(
                      bottom:
                      BorderSide(color: Theme.of(context).dividerColor, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: BackButton(),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Delivery Addresses',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // for spacing symmetry
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Saved Locations',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey[600]
                                    : Colors.grey[400]),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Manage',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Address Cards
                      AddressCard(
                        icon: Icons.home,
                        title: 'Home',
                        subtitle: '123 Green St, Apt 4B\nSpringfield, IL 62704',
                        isDefault: true,
                      ),
                      const SizedBox(height: 12),
                      AddressCard(
                        icon: Icons.apartment,
                        title: 'Office',
                        subtitle: 'Tech Park, Building 7, Floor 2\nSpringfield, IL 62704',
                        isDefault: false,
                      ),
                      const SizedBox(height: 12),
                      AddressCard(
                        icon: Icons.cottage,
                        title: 'Parents House',
                        subtitle: '45 Maple Avenue\nOakwood, CA 90210',
                        isDefault: false,
                        isInactive: true,
                      ),

                      const SizedBox(height: 80), // space for Add button
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Add New Address Button
          Positioned(
            bottom: 72,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_location_alt, size: 24),
              label: const Text(
                'Add New Address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                shadowColor: Colors.green.withOpacity(0.3),
                elevation: 8,
              ),
            ),
          )
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.storefront), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Track'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDefault;
  final bool isInactive;

  const AddressCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isDefault = false,
    this.isInactive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isInactive ? 0.6 : 1,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isDefault
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              width: isDefault ? 4 : 1),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDefault
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[200]
                    : Colors.grey[800],
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: isDefault ? Theme.of(context).primaryColor : null),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 6),
                      if (isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.grey[600]
                              : Colors.grey[400])),
                ],
              ),
            ),
            // Actions
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey
                      : Colors.grey[400],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
