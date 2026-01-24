import 'package:flutter/material.dart';

import '../../../widgets/category_card.dart';
import '../../core/app_colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  static const primary = Color(0xFF13EC13);

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _filters(),
            Expanded(child: _categoriesGrid()),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _iconButton(Icons.notifications, badge: true),
                  const SizedBox(width: 12),
                  _iconButton(Icons.shopping_bag, filled: true),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          _searchBar(false),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon,
      {bool badge = false, bool filled = false}) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: filled ? AppColors.accent: Colors.white,
          child: Icon(icon, color: filled ? Colors.black : Colors.grey[800]),
        ),
        if (badge)
          const Positioned(
            top: 6,
            right: 6,
            child: CircleAvatar(radius: 4, backgroundColor: AppColors.accent),
          )
      ],
    );
  }

  Widget _searchBar(bool isDark) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2E1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          SizedBox(width: 12),
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search fresh produce...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filters() {
    final filters = ["All", "On Sale", "New Batches", "Seasonal"];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == 0;
          return Chip(
            label: Text(filters[index]),
            backgroundColor: selected ? Colors.black : Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }

  Widget _categoriesGrid() {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.78,
      children: const [
        CategoryCard(
          title: "Fruits",
          items: "120 items",
          image:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuB8RaKAQsHuuHuAGtFGNbHro5zxrgSORLZHLe8ltmBpDJ5E4F989GYJjP6dMGoYivY1zea8brtG640FYXWYVLzOxEAHqDhWYRjtAeP9Z7Ewb8o7gg0q3C1iXbnTANEC3LToLyXK09bLLYCLXP2sILv9w98nuMwOK2451tl19C_yw8EJC7Epl3sXimH0vL_nVtrgdi87p_M4pMo3G7dlIKScDwyjMUB_nHx8HW9i83ckY9hgi9j4JcrwHKvxOHRBncqYZDxRHDldOuc",
          tag: "Fresh Batch",
        ),
        CategoryCard(
          title: "Vegetables",
          items: "95 items",
          image:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAkSu2WuK2_2L1f4q8gxTvIUTxpT-Rij9kuRfX8zsgcVCyiTUASLWiudsJ3lPzs3hbvkfVpAzAOKqC7Puc9Dz_-9X1iNuNmYT7OvWW3WOkDNbxIdZ1u25xbI1PfPguZZ3Gy6CcIs_EPc2kuuJhrsaxHakjuENk2fPx67neM_8rW62jut0iBOyK2hISJaJzj3HlMyiH2O-ZdIBrqfwwg3Ztyi04tIlneCC1y-iukXHwzY-Q-q3ZrPgMWAEYw2x4m94838gCpBGXsmAI",
        ),
        CategoryCard(
          title: "Grains",
          items: "40 items",
          image:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuANSok-tpimrxz3oZ4mzEo6RjrzxwXmV3kFgpST43ms3DyuaUcPOl7zSGtC4RZCnPwgL7Kji-rOCw1NROMPRVth1xHVsjQp-xylj8QbkpNkBtxVcBKxvbUYzWjyNAN_f7BJOobt2z-oN8ceIN8IWVdod5QgdQnCL97961u5YAmfPaqvyxAdjbxWkRyBDSTk8EOLiBNxS7W8_8es8Jd_BWigL_lsj1Q6lOORxoPRdrXvkoswszoes_tJB7b5cfC7BVnN9tJGnbnXISQ",
        ),
        CategoryCard(
          title: "Dairy",
          items: "30 items",
          image:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuA1lrvAelb0B8bB63P3CIcsvMTdEoEHkPWt1MQJTJcJjdFN0r39MqNlBuWQDrykHeNlLAFA04uVdK8-pSefCaDb-PYMsANJNKzjJTRfXOMAB6RFKbaJgOgtX-oWRhpHaeMpUW0aqgSyEbu1-cS2wnWpREiR-HCzRhlSI5_MHO-fp6kh4Q4o6l6TFH8C3v4BiG8Iph22R_DuNg2926iA4_e6zks6ndry2Ibbx6AzJ6p2nxspO_XS52NruscQLAWyzESGdRhnoapYhi0",
          tag: "Cool",
        ),
        CategoryCard(
          title: 'Organics',
          items: '55 items',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA3rGJrGyXUqA5pxcd4YK817UVGsWh_X8RSrxQj4UPJGIWHKfY1vAY19mYIHP0qCpfuFqxNH6kMlH3tx-Q2j0nlDDHUmQJpnCJvi1UXh2u3q22Ms_2fSBYI6pRzgW4RsR6RhjhEadPZLId2MxfnBIURWrxr-FYxrJrjIH2j-SGL7fqnhCFTd_X5cM__G6epK7W9LPDTGmCewOBd_0RKNCOV4MEZavsH8yw8yaSC74mbA5TQsO8IyL32m-H6g-eAfJU-mhszqUZPcGM',
          tag: 'BIO',

        ),
        CategoryCard(
          title: 'Batch Deals',
          items: 'Bulk savings',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBUi-ZTo-425v0fX6ay4xxT9ODMtgzPeV_QLr_reQEcfgRQ-va9YBrPQ7EmN22eZF7cVEmNWMvMLwc4Z1SWLnOlPLs3v_1JpnGFNKW7a-HxYkyoXwUDWMNg-x8qQ0jftdUzIXgGuzfuaGKVTeR1h5r8O4BWEL1KLUTMJq1oqva0x99PKy0Vh9dXhpk1sPKyBCrvOMSRp6UP89a2G9SoyQIYRJv7FdiANlcTqOBDspNJsC7_h__mGDTq4Dnap93xEDWKu4gt8Y9C1NU',
          tag: 'SAVE 20%',

        ),
        CategoryCard(
          title: 'Proteins',
          items: '28 items',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDr1PRXQsTTNRK4vwB9th79WeeHa_AwzjCSL62EU8uS3i2VSjc3GqtnD-KsfzK6FvedmX9J-XpcLeYjgYfikCj1iHyAIAyUHbfOTEOdb9nCjv_24vLG-bpb3KB6dpeEK0lb5wtYcc9VXryRFfaTu6TpiOMH6YZWpym8iJfAz3Q0i1OB65qHRHNkqWqgrMCQj_LlUIlYhFOM-3qAOWG2WsXrhISqFQgiJJ1IRIASm5vXCg-APTzrBefQ9ZVRhittKP6tXdeMSA_VZVY',
        ),
        CategoryCard(
          title: 'Bakery',
          items: '42 items',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB-TMdqljkWmaVFhqijUjOj5UpJQU8FDzcAW4RjGs0J8YuAsAqm4M7-R7Z88BlaqOqT-pIqaxtnsSNaTNSg1nJ-X7yyEesq2DwB8JCWd-4kwfcxG7ZhNvXRL_SseKqhLKvV6SrtwwCufooL7yjdi_xaXDjH-LHChDZetw9h9sd8hDyzU-S0poYDiemQCky1PCgxgoBVKEhOxerxyhGi2LrptaVddD7AGOtPY92iv4L30gSYbYHXMe-6NVCzEbHdXX0vO9Kg_L4-XTE',
        ),
      ],
    );
  }

  Widget _bottomNav() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(bottom: 16, top: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, "Home"),
            _navItem(Icons.grid_view, "Categories", active: true),
            FloatingActionButton(
              backgroundColor: primary,
              onPressed: () {},
              child: const Icon(Icons.qr_code_scanner, color: Colors.black),
            ),
            _navItem(Icons.shopping_cart, "Cart", badge: true),
            _navItem(Icons.person, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label,
      {bool active = false, bool badge = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Icon(icon, color: active ? primary : Colors.grey),
            if (badge)
              const Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
              )
          ],
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: active ? primary : Colors.grey)),
      ],
    );
  }
}


