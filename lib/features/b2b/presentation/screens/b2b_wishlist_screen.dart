import 'package:flutter/material.dart';
import 'b2b_product_details_screen.dart';

class B2BWishlistScreen extends StatelessWidget {
  const B2BWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color rustBrown = Color(0xFFAD521B);
    const Color bgBeige = Color(0xFFFFFCE4);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: rustBrown,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saved Products & Suppliers',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            // Tabs
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDE0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Saved Products',
                        style: TextStyle(color: rustBrown, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Favorite Suppliers',
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Badges
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5D5C5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '18 Saved Products',
                    style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5D5C5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '6 Favorite Suppliers',
                    style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List of saved products
            _buildSavedProductCard(
              context,
              'Fresh Tomato',
              'Ramesh Gowda Farms',
              'Kolar, Karnataka',
              '50 KG',
              18,
              'assets/images/farmer_card.png',
            ),
            _buildSavedProductCard(
              context,
              'Organic Potatoes',
              'Green Valley Co-op',
              'Hassan, Karnataka',
              '100 KG',
              24,
              'assets/images/fleet_card.png',
            ),
            _buildSavedProductCard(
              context,
              'Red Onions (Nashik)',
              'Patil Bulk Traders',
              'Nashik, MH',
              '200 KG',
              32,
              'assets/images/logo_illustration.png',
            ),
            _buildSavedProductCard(
              context,
              'Ooty Carrots',
              'Nilgiri Fresh Farms',
              'Ooty, Tamil Nadu',
              '25 KG',
              45,
              'assets/images/farmer_card.png',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Just a placeholder for visual match (Account or just inactive)
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildSavedProductCard(
    BuildContext context,
    String title,
    String farmer,
    String location,
    String moq,
    int price,
    String imageAsset,
  ) {
    const Color rustBrown = Color(0xFFAD521B);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const B2BProductDetailsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageAsset,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black87),
                        ),
                      ),
                      const Icon(Icons.bookmark, color: rustBrown, size: 24),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.storefront_outlined, size: 12, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(farmer, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 12, color: Colors.black45),
                      const SizedBox(width: 4),
                      Text(location, style: const TextStyle(fontSize: 11, color: Colors.black45)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('MIN ORDER: $moq', style: const TextStyle(fontSize: 10, color: Color(0xFF3E5C1D), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('₹$price', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: rustBrown, fontFamily: 'serif')),
                          const Text('/KG', style: TextStyle(fontSize: 12, color: rustBrown, fontWeight: FontWeight.bold, fontFamily: 'serif')),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: rustBrown,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          minimumSize: const Size(0, 32),
                        ),
                        onPressed: () {},
                        child: const Text('Reorder', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
