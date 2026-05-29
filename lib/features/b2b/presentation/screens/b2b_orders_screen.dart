import 'package:flutter/material.dart';
import '../../../dashboard/presentation/screens/b2b_dashboard_screen.dart';
import 'b2b_track_order_screen.dart';
import 'b2b_marketplace_screen.dart';
import 'b2b_analytics_screen.dart';
import 'b2b_profile_screen.dart';

class B2BOrdersScreen extends StatefulWidget {
  const B2BOrdersScreen({super.key});

  @override
  State<B2BOrdersScreen> createState() => _B2BOrdersScreenState();
}

class _B2BOrdersScreenState extends State<B2BOrdersScreen> {
  String _selectedFilter = "All Orders";

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
          'Orders',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black45),
                  hintText: 'Search orders by product or order ID',
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All Orders', true, rustBrown),
                  const SizedBox(width: 12),
                  _buildFilterChip('Ongoing', false, rustBrown),
                  const SizedBox(width: 12),
                  _buildFilterChip('Delivered', false, rustBrown),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Stats
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDE0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.circle, size: 8, color: rustBrown),
                  const SizedBox(width: 6),
                  const Text('12 Total Orders', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(width: 16),
                  Container(width: 1, height: 16, color: Colors.black26),
                  const SizedBox(width: 16),
                  const Icon(Icons.circle, size: 8, color: Color(0xFF3E5C1D)),
                  const SizedBox(width: 6),
                  const Text('4 Orders in Transit', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Order Cards
            _buildOrderCard(
              orderId: 'KP-BULK-20458',
              status: 'ONGOING',
              statusColor: const Color(0xFFFFE0B2),
              statusTextColor: const Color(0xFFE65100),
              title: 'Fresh Tomato, Onion, Dairy Milk',
              supplier: 'Ramesh Gowda Farms',
              quantity: '180 KG',
              price: '5,420',
              deliveryInfo: 'Delivery in 1-2 Days',
              deliveryIcon: Icons.local_shipping_outlined,
              buttonText: 'Track Order',
              buttonPrimary: true,
              imageAsset: 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=200',
              onTapButton: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const B2BTrackOrderScreen()),
                );
              },
            ),

            _buildOrderCard(
              orderId: 'KP-BULK-20112',
              status: 'DELIVERED',
              statusColor: const Color(0xFFD6ECC1),
              statusTextColor: const Color(0xFF2E7D32),
              title: 'Potatoes, Green Chilli, Ginger',
              supplier: 'Krishi Sahyog Co-op',
              quantity: '450 KG',
              price: '12,850',
              deliveryInfo: 'Delivered on 24 Oct',
              deliveryIcon: Icons.calendar_today_outlined,
              buttonText: 'View Details',
              buttonPrimary: true,
              imageAsset: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=200',
              onTapButton: () {},
            ),

            _buildOrderCard(
              orderId: 'KP-BULK-20599',
              status: 'PENDING',
              statusColor: const Color(0xFFE5D5C5),
              statusTextColor: const Color(0xFF5D4037),
              title: 'Premium Basmati Rice',
              supplier: 'Punjab Grains Ltd.',
              quantity: '12 Quintals',
              price: '68,200',
              deliveryInfo: 'Awaiting Confirmation',
              deliveryIcon: Icons.access_time,
              buttonText: 'View Details',
              buttonPrimary: true,
              imageAsset: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=200', // Rice
              onTapButton: () {},
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, -2))
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: 2,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BDashboardScreen()));
              } else if (index == 1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BMarketplaceScreen()));
              } else if (index == 3) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BAnalyticsScreen()));
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
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required String title,
    required String supplier,
    required String quantity,
    required String price,
    required String deliveryInfo,
    required IconData deliveryIcon,
    required String buttonText,
    required bool buttonPrimary,
    required String imageAsset,
    required VoidCallback onTapButton,
  }) {
    const Color rustBrown = Color(0xFFAD521B);

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order ID: $orderId', style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(status, style: TextStyle(color: statusTextColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: imageAsset.startsWith('http') 
                  ? Image.network(imageAsset, width: 70, height: 70, fit: BoxFit.cover)
                  : Image.asset(imageAsset, width: 70, height: 70, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.2)),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.storefront_outlined, size: 12, color: Colors.black54),
                        const SizedBox(width: 4),
                        Expanded(child: Text('Supplier: $supplier', style: const TextStyle(fontSize: 11, color: Colors.black54))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Total Quantity: $quantity', style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(height: 1, color: Colors.black12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('₹ $price', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: rustBrown, fontFamily: 'serif')),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(deliveryIcon, size: 12, color: Colors.black54),
                        const SizedBox(width: 4),
                        Expanded(child: Text(deliveryInfo, style: const TextStyle(fontSize: 12, color: Color(0xFF3E5C1D), fontWeight: FontWeight.w600))),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                ),
                onPressed: onTapButton,
                child: Text(buttonText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
