import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'nav_items.dart';

class RiderDashboardPage extends StatelessWidget {
  const RiderDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(bottom: 90),
              children: [
                _topBar(primary),
                _stats(),
                _taskSelector(),
                _sectionTitle("Assigned Deliveries"),
                _primaryDeliveryCard(primary),
                _queuedDelivery(),
                _historyHeader(primary),
                _historyList(),
              ],
            ),
            _bottomNav(primary),
          ],
        ),
      ),
    );
  }


  Widget _topBar(Color primary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuAu-_56tSp4MvVGg8h7PaxGDG5dhzGpkwFdZFNE7S3IZQvp83WUmM4z9_6roU1ycNj3kFbqGCKLiIJnJIux1Vks6GflL-UighdHUr37GiT1TarT7MnLlN9976bonusQQIEn53U_p53O_u6hzweGKBRxELcjZyxo9O8xFFJ1IkeYyZiRi0xT7m-pyszmDLdElEQWmN0fNF-1ijj6ZGL21186VFRXcMHBhSlCPBqeTR3AM62YQaZ-GV2YzWXvwvQhedqm1g0hY4bXsXM",
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Rider Dashboard",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Status: Active & Online",
                    style: TextStyle(fontSize: 12, color: AppColors.accent)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }


  Widget _stats() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _statCard("Today's Deliveries", "12", "+2"),
          const SizedBox(width: 12),
          _statCard("Total Earnings", "\$84.50", null),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, String? delta) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDBE6DB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.toUpperCase(),
                style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF618961),
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                if (delta != null) ...[
                  const SizedBox(width: 6),
                  Text(delta,
                      style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget _taskSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _tab("Active Tasks", true),
            _tab("History", false),
          ],
        ),
      ),
    );
  }

  Widget _tab(String text, bool active) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.black : const Color(0xFF618961),
          ),
        ),
      ),
    );
  }


  Widget _primaryDeliveryCard(Color primary) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuCwGAKoLOC-dTi5B01GtirF9OnkJmK9ETYS0YqVlHoSU5aGLiADDkFVb6TW_FU3lJkqgN89A5c_jraPhPqoAB9wqPUj9PndwTJbNgagfzU2mNYeV8jA3hcXFbLCACgA_oZ4VN1X6poSFAsg8LLcS9VYUahh639V88m46GAPK8cDsBVsmfFo6hjWnCqlvHuxRJ69VvVgl8uYB1JpiEFtTIR3Cjlnw3Tti4-DANrdg8FVELeybu8e0cVVd_gjAjJq1XvpBse5nshGnno",
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("COLD CHAIN REQ.",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("IN TRANSIT",
                      style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Batch #BP-2024-08",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _infoRow(Icons.store, "Pick-up: Fresh Organics Market",
                      muted: true),
                  _infoRow(Icons.location_on,
                      "Drop-off: 452 Downtown Hub, Suite 4B"),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _statusBtn("Picked", false),
                      _statusBtn("Enroute", true),
                      _statusBtn("Delivered", true, filled: true),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF6F8F6),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.navigation),
                    label: const Text("Get Directions"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _statusBtn(String text, bool active, {bool filled = false}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled
              ? AppColors.accent
              : active
              ? AppColors.accent.withValues(alpha: 0.15)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: active && !filled
              ? Border.all(color:AppColors.accent, width: 2)
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: filled
                  ? Colors.white
                  : active
                  ? AppColors.accent
                  : Colors.grey),
        ),
      ),
    );
  }


  Widget _queuedDelivery() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDBE6DB), style: BorderStyle.solid),
        ),
        child: Row(
          children: const [
            Icon(Icons.schedule, color: Colors.grey),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Batch #BP-2024-09",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text("Ready for pickup at 2:45 PM",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }


  Widget _historyHeader(Color primary) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Recent History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("View All",
              style:
              TextStyle(color: primary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _historyList() {
    return Column(
      children: [
        _historyItem("#BP-2024-05", "Today, 11:30 AM • 4.2 miles", "\$12.40"),
        _historyItem("#BP-2024-04", "Today, 10:15 AM • 2.8 miles", "\$9.50"),
      ],
    );
  }

  Widget _historyItem(String id, String meta, String amount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
        Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF13EC131A),
            child: Icon(Icons.check_circle, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(id,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold)),
                Text(meta,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(amount,
              style:
              const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }


  Widget _bottomNav(Color primary) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border:
          const Border(top: BorderSide(color: Color(0xFFEAEAEA))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            NavItem(Icons.dashboard, "Home", true),
            NavItem(Icons.map, "Map", false),
            NavItem(Icons.payments, "Earnings", false),
            NavItem(Icons.person, "Profile", false),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {bool muted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon,
              size: 18,
              color: muted ? Colors.grey : AppColors.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                    muted ? FontWeight.w500 : FontWeight.bold,
                    color: muted ? Colors.grey : Colors.black)),
          )
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(text,
          style:
          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}

