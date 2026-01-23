import 'package:flutter/material.dart';

class ShopperProfileScreen extends StatelessWidget {
  const ShopperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
                Icons.edit,
                color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 56,
                      backgroundImage: const NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuDtiD3LVdEUpoDsoqdf6j-nGyAm8pukY5dVkze5eCSazt9OCRW52JH-KlRkcCEfne-0dNw3LqClRRLrX8FnR7s2JXbeI9Zo_AN7garU9U5gT87ByOOv5SrX0QpVi0M4xu1NumfGYxOYmdd9vgPM75o0dIxOfKbPLy9A9TZHTdpJVrXJ9ZCnhcuAd8FI2u27CIHy-jTPXQGpEtAyAHQ_Lk4HYeZx962vxMzBW_DyThgCQUIxlD8VxTyqkT99hSYY8f2X4tFZqfq0Exs",
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: theme.colorScheme.surface,
                        child: Icon(Icons.verified,
                            color: theme.colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text("Jane Aller",
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text("jane.aller@gmail.com",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme.colorScheme.primary),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.security,
                          size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: 6),
                      const Text(
                        "Batch Transparency Enabled",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Loyalty Stats Card
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.eco, color: Colors.green),
                            SizedBox(width: 6),
                            Text("Green Points",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Text("Use at checkout",
                            style: TextStyle(color: Colors.white54)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Text("340",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        SizedBox(width: 6),
                        Text("pts available",
                            style: TextStyle(color: Colors.white54)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.65,
                      color: Colors.green,
                      backgroundColor: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 6),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text("160 pts to next reward",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Account Section
            _buildSectionHeader("My Account"),
            _buildNavTile(Icons.shopping_bag, "My Orders"),
            _buildNavTile(Icons.location_on, "Delivery Addresses"),
            _buildNavTile(Icons.credit_card, "Payment Methods"),

            const SizedBox(height: 24),

            // Settings Section
            _buildSectionHeader("Settings"),
            _buildNavTile(Icons.notifications, "Notifications"),
            _buildNavTile(Icons.settings, "Account Settings"),
            _buildNavTile(Icons.help, "Help & Support"),

            const SizedBox(height: 24),

            // Logout & Version
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () {},
              child: const Text("Log Out"),
            ),
            const SizedBox(height: 8),
            const Text("Version 2.4.0 (Build 1042)",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.search), label: "Browse"),
          NavigationDestination(
              icon: Badge(
                backgroundColor: Colors.red,
                child: Icon(Icons.shopping_cart),
              ),
              label: "Cart"),
          NavigationDestination(
              icon: Icon(Icons.person, color: Colors.green), label: "Profile"),
        ],
        selectedIndex: 3,
        onDestinationSelected: (index) {},
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title.toUpperCase(),
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildNavTile(IconData icon, String title) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade50,
        child: Icon(icon, color: Colors.green),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}