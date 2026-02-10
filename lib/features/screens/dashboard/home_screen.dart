import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../order/order_history/order_details.dart';
import '../order/order_history/order_history_page.dart';
import '../product/product_details/product_detail_page.dart';

class FreshMarketHome extends StatefulWidget {
  const FreshMarketHome({super.key});

  @override
  State<FreshMarketHome> createState() => _FreshMarketHomeState();
}

class _FreshMarketHomeState extends State<FreshMarketHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Stack(
          children: [
            _content(),
            //_bottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          _searchBar(),
          _filters(),
          _promoBanner(),
          _trackBatch(),
          _categories(),
          _freshArrivals(),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.accent.withValues(alpha: .1),
                child: const Icon(Icons.location_on, color: AppColors.accent),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Deliver to",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12, color: Colors.grey)),
                  Row(
                    children: const [
                      Text("Home, 123 Green Ave",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.keyboard_arrow_down, size: 18)
                    ],
                  )
                ],
              )
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: const Icon(Icons.person),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search fresh produce...",
          prefixIcon: const Icon(Icons.search, color: AppColors.accent),
          suffixIcon: const Icon(Icons.tune),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _filters() {
    return SizedBox(
      height: 60,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          _chip("All", active: true ),
          _chip("Fruits"),
          _chip("Vegetables"),
          _chip("Dairy"),
        ],
      ),
    );
  }

  Widget _chip(String text, {bool active = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(text),
        backgroundColor: active ? AppColors.accent : Colors.white,
        labelStyle: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _promoBanner() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: NetworkImage(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuCew6LCcPtnSlUB7j0yrACt0VeubJ0rKnUnOO9fmDJPrgRqoLLQ_A7iKlK1fNjWTS0OknTs-cG6EOpOW5DwJzJz9i8iT7YGLMLLTFtp3_goYw1AxoGpnZhdN_K0zidxZBeu8iDlW0RWNyKDdnoHlBXDHMYMOV_P_zyO8oe_0QZeDsy6Hu-Fea6x4gH4HpgpqKYGfAZuZGXNhp7DxKlEuFMNZGnnL-tsHYKGB1beS5fC2HL65xkMurc3boOnDztMRoNZhYVeys2hgS8"),

            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black54, Colors.transparent],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Chip(
                label: Text("TODAY'S OFFER",
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                backgroundColor: AppColors.accent,
              ),
              SizedBox(height: 8),
              Text(
                "Earn 2x Points on Organic Greens today!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackBatch() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Track My Batch",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderHistoryPage()));
              },
              child: Text("View History",
                  style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                  )
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const OrderDetailsPage()));
            },
            child: Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.accent.withValues(alpha: .1),
                      child:
                      const Icon(Icons.local_shipping, color: AppColors.accent, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Batch #402",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Chip(
                                label: Text("On the way",
                                    style: TextStyle(fontSize: 10)),
                                backgroundColor: Color(0xFFCCF5CC),
                              )
                            ],
                          ),
                          const Text("Arriving in 12 mins • 4 items",
                              style: TextStyle(fontSize: 12)),
                          const SizedBox(height: 6),
                          LinearProgressIndicator(
                            value: .75,
                            backgroundColor: Colors.grey.shade200,
                            color: AppColors.accent,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _categories() {
    final items = ["🍎 Fruits", "🥦 Veggies", "🥛 Dairy", "🍯 Pantry"];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4),
        itemBuilder: (_, i) {
          return Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.green.shade100,
                child: Text(items[i].split(" ")[0], style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 6),
              Text(items[i].split(" ")[1],
                  style: const TextStyle(fontSize: 12))
            ],
          );
        },
      ),
    );
  }

  Widget _freshArrivals() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Fresh Arrivals",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("See all",
                  style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: .7,
            children: [
              _productCard(
                  "Haas Avocado",
                  "\$4.50",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuAysxvfERAdZIuNPaRe0OAwk4DEoY-_WcWfQ6Nc2PQGZ--_O_ZWcLclSHffkXnm5dOnhfId_O5NL_QxGIUKNvhGAF_mvjkPchC4AZlkaxmLQSXHJSTl0imRCjKgMgQED5cLr-f-oxOiPIubvm73hpaUMD8fxmn4gPYPKeyTrztE51lfW-m7EMWxvx78lhPdH3H1NJgX-5PXUzXucvLgjGeeaLXFxFavkJKBbFNrjT1O84jGs0_dWxVtfwXz8Wr1BB_FX_eXAbcCt3w"),
              _productCard(
                  "Strawberries",
                  "\$3.20",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuC0b_5JRYT6GYbjNZe6j0nA_UOuoSzRkEwXvmvoIVfl7mbO40h9sesK-0A-Exf0aJ5bhobM7m5HeSieEf5BNw0q0qbutcLlSHrs9WMnn8Sl7jckewr_fgd-bapYAYEbP-X6nszkqtF_JWIfcBw9vMlBvXo3lvcmhBIsKMQXTm-VihkFIzzCKD6QVeJNtJTwch2vWTupmK2EpSA0GTSMniZRIbuj1ZccqhElAyC8O2sJsBLZszLeUkc3PhF1OGUpZ4-Jh_fa8A9_08Q"),
            ],
          )
        ],
      ),
    );
  }

  Widget _productCard(String name, String price, String image) {
    return InkWell(
      onTap: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const ProductDetailsPage()));
       },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price,
                          style: const TextStyle(
                              color: AppColors.accent, fontWeight: FontWeight.bold)),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.accent,
                        child:
                        const Icon(Icons.add, color: Colors.white, size: 16),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomNav() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.95),
          border: const Border(top: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.home, color: AppColors.accent),
            Icon(Icons.receipt_long),
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.shopping_basket, color: Colors.white),
            ),
            Icon(Icons.loyalty),
            Icon(Icons.settings),
          ],
        ),
      ),
    );
  }
}
