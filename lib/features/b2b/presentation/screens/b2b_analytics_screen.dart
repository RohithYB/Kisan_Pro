import 'package:flutter/material.dart';
import '../../../dashboard/presentation/screens/b2b_dashboard_screen.dart';
import 'b2b_marketplace_screen.dart';
import 'b2b_orders_screen.dart';
import 'b2b_profile_screen.dart';

class B2BAnalyticsScreen extends StatelessWidget {
  const B2BAnalyticsScreen({super.key});

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
          'Business Analytics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            // Filter Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterChip('Weekly', false, rustBrown),
                const SizedBox(width: 12),
                _buildFilterChip('Monthly', true, rustBrown),
                const SizedBox(width: 12),
                _buildFilterChip('Quarterly', false, rustBrown),
              ],
            ),
            const SizedBox(height: 24),

            // Top Stats Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildStatCard('MONTHLY\nSPENDING', '₹52,400', 'Total\nwholesale\npurchases'),
                _buildStatCard('ORDERS\nPLACED', '128', 'Completed\nbusiness\norders'),
                _buildStatCard('AVG ORDER\nVALUE', '₹4,120', 'Per wholesale\norder'),
                _buildStatCard('ACTIVE\nSUPPLIERS', '24', 'Verified farm\nsuppliers'),
              ],
            ),
            const SizedBox(height: 24),

            // Purchase Trends Chart
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Purchase\nTrends', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                      Row(
                        children: [
                          const Icon(Icons.trending_up, color: Color(0xFF3E5C1D), size: 16),
                          const SizedBox(width: 4),
                          const Text('+12.4% vs last\nmonth', style: TextStyle(fontSize: 11, color: Color(0xFF3E5C1D), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Mock Bar Chart
                  SizedBox(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildChartBar(100, 'Oct', false),
                        _buildChartBar(85, 'Nov', false),
                        _buildChartBar(110, 'Dec', false),
                        _buildChartBar(60, 'Jan', false),
                        _buildChartBar(120, 'Feb', false),
                        _buildChartBar(150, 'Mar', true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Market Demand
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Market Demand', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            const SizedBox(height: 12),
            _buildDemandRow('Tomato', Icons.trending_up, '+18%', const Color(0xFFF1F8E9), const Color(0xFF2E7D32)),
            const SizedBox(height: 8),
            _buildDemandRow('Onion', Icons.trending_up, '+12%', const Color(0xFFF1F8E9), const Color(0xFF2E7D32)),
            const SizedBox(height: 8),
            _buildDemandRow('Potato', Icons.remove, 'Stable', const Color(0xFFF1EDE0), Colors.black87),
            const SizedBox(height: 8),
            _buildDemandRow('Cabbage', Icons.trending_down, '-4%', const Color(0xFFFFEBEE), const Color(0xFFC62828)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDE0),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFFE5D5C5)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: Color(0xFFAD521B), size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'High demand for organic produce expected next quarter due to seasonal festive needs.',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Most Ordered Products
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Most Ordered Products', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            const SizedBox(height: 12),
            _buildProductCard('Fresh Tomato', '₹43,200', '42 Orders', '2,400 KG', 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=200'),
            const SizedBox(height: 12),
            _buildProductCard('Red Onions', '₹28,500', '36 Orders', '1,850 KG', 'https://images.unsplash.com/photo-1620574387735-3624d75b2dbc?w=200'),
            const SizedBox(height: 32),

            // Top Suppliers
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Top Suppliers', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            const SizedBox(height: 12),
            _buildSupplierCard('Ramesh Gowda Farms', '4.9/5', '58 Orders', '98% Fulfillment', true, 'assets/images/farmer_card.png'),
            const SizedBox(height: 12),
            _buildSupplierCard('Green Valley Cooperatives', '4.7/5', '45 Orders', '94% Fulfillment', false, 'assets/images/fleet_card.png'),
            const SizedBox(height: 32),

            // Export Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Export Analytics Report', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, -2))
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: 3, // Analytics
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BDashboardScreen()));
              } else if (index == 1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BMarketplaceScreen()));
              } else if (index == 2) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BOrdersScreen()));
              } else if (index == 4) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BProfileScreen()));
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: rustBrown,
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            iconSize: 28,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.dashboard_rounded)),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.storefront_rounded)),
                label: 'Marketplace',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.receipt_long_rounded)),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.analytics_rounded)),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4.0), child: Icon(Icons.person_rounded)),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, Color rustBrown) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isSelected ? rustBrown : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: isSelected ? rustBrown : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black54,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold, height: 1.2)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFAD521B))),
          const Spacer(),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.black54, height: 1.2)),
        ],
      ),
    );
  }

  Widget _buildChartBar(double height, String label, bool isCurrent) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isCurrent)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF3E5C1D),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('184k', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
          ),
        Container(
          width: 32,
          height: height,
          decoration: BoxDecoration(
            color: isCurrent ? const Color(0xFFAD521B) : const Color(0xFFE5D5C5),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 10, fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal, color: Colors.black87)),
      ],
    );
  }

  Widget _buildDemandRow(String name, IconData icon, String value, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: textColor, size: 16),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String price, String orders, String qty, String imageAsset) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: imageAsset.startsWith('http')
              ? Image.network(imageAsset, width: 60, height: 60, fit: BoxFit.cover)
              : Image.asset(imageAsset, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                    Text(price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFAD521B), fontFamily: 'serif')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(orders, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                    const SizedBox(width: 16),
                    const Icon(Icons.monitor_weight_outlined, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(qty, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierCard(String name, String rating, String orders, String fulfillment, bool isPremium, String imageAsset) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(imageAsset),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.verified, color: Color(0xFF3E5C1D), size: 14),
                ),
              )
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ),
                    if (isPremium)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('PREMIUM', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(rating, style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(orders, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                    const SizedBox(width: 16),
                    Text(fulfillment, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
