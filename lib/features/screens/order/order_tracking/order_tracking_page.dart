import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  static const Color primary = Color(0xFF13EC13);
  static const Color bgLight = Color(0xFFF6F8F6);
  static const Color textDark = Color(0xFF111811);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF102210) : bgLight,
      appBar: _buildAppBar(context, isDark),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              children: [
                _buildMapSection(),
                _buildRiderCard(isDark),
                _buildDeliveryTimeline(isDark),
                _buildBatchDetails(isDark),
                _buildOrderSummary(isDark),
              ],
            ),
          ),
          _buildBottomBar(isDark),
        ],
      ),
    );
  }


  AppBar _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      backgroundColor:
      isDark ? const Color(0xFF102210).withOpacity(0.9) : Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Order #72841", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 2),
          Text(
            "Expected delivery in 12 mins",
            style: TextStyle(fontSize: 12, color: Colors.green),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: TextButton(
            onPressed: () {},
            child: const Text("Help"),
          ),
        )
      ],
    );
  }


  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuAkwWpRjO608a7Wq852QqL530CwJEb-IJsw9A8QFCG-JnhZEFuxwierJWoE9Q-6LqnhhHMcKqMJ91ohTMtLNCEJ8x94eN5IzghOHFHFqsOSTiWwi-HMS5oUifmJlOqRgtUa2Y0IclW2SFsiib3bmUYQfnAoywekWu7grq3IURYHxifjlfappZfDELzLh-HEcEu5EpSms_mdqlnFzofE25MGlAISdeugH_bqGGSyf1DhN368cN5w00Q8djvUYIs8-H5QUlN1YMWqKqY",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "1.2 miles away",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.electric_moped, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildRiderCard(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuA7XsXXAQ50e6wqjd28yhF6EnPFlp9CU0jZ_6snLyivccDU6aiw7hGLSRepXdt4np3cjUpVc-mLMPOBCHiy6mW7cWY19Nu5hU_iTfCgD0rUnZQYkVqX_oNnXVkn_N4A2wbohMS44votM9ARfXI2RY2XDgkQNWKp9nPVuc01OWrTIhT_0W0L6ni5EvQUC7NmC6oKUkykXPiLDK3KwtWJQ4O_HpLoQkJ5vYbHYhHXGFVK-ofQqtWXSTvXXdf0QfU4u-oxrYxUNIdwbsU",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Alex Miller",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text("⭐ 4.9 • Produce Expert",
                          style: TextStyle(color: Colors.green)),
                    ],
                  )
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.call, color: primary),
                  SizedBox(width: 12),
                  Icon(Icons.chat_bubble_outline),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDeliveryTimeline(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Delivery Status",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _TimelineItem(
            title: "Order Processing",
            subtitle: "Confirmed at 10:30 AM",
            icon: Icons.check,
            completed: true,
          ),
          _TimelineItem(
            title: "Packed & Quality Checked",
            subtitle: "Heritage Farm • 10:45 AM",
            icon: Icons.inventory_2,
            completed: true,
          ),
          _TimelineItem(
            title: "Out for Delivery",
            subtitle: "In transit • 11:05 AM",
            icon: Icons.local_shipping,
            completed: true,
            isActive: true,
          ),
          _TimelineItem(
            title: "Delivered",
            subtitle: "ETA 11:20 AM",
            icon: Icons.home,
            completed: false,
          ),
        ],
      ),
    );
  }


  Widget _buildBatchDetails(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Batch Freshness Profile",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _InfoRow(label: "Source", value: "Heritage Organic Farms"),
            _InfoRow(label: "Harvest Date", value: "Today, 4:00 AM"),
            _InfoRow(label: "Transit Temp", value: "38.5°F (Optimal)"),
          ],
        ),
      ),
    );
  }


  Widget _buildOrderSummary(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: const CircleAvatar(child: Text("8")),
          title: const Text("8 Items total"),
          subtitle: const Text("Produce & Dairy Batch"),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }


  Widget _buildBottomBar(bool isDark) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF102210) : Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10)
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text("Share Tracking"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}



class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool completed;
  final bool isActive;

  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.completed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: completed ? OrderTrackingPage.primary : Colors.grey,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive
                  ? OrderTrackingPage.primary
                  : Colors.black)),
      subtitle: Text(subtitle),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
