import 'package:flutter/material.dart';
import '../../../dashboard/presentation/screens/b2b_dashboard_screen.dart';
import 'b2b_orders_screen.dart';
import 'b2b_marketplace_screen.dart';
import 'b2b_analytics_screen.dart';
import 'b2b_profile_screen.dart';

class B2BTrackOrderScreen extends StatefulWidget {
  const B2BTrackOrderScreen({super.key});

  @override
  State<B2BTrackOrderScreen> createState() => _B2BTrackOrderScreenState();
}

class _B2BTrackOrderScreenState extends State<B2BTrackOrderScreen> {
  int _currentIndex = 1;

  void _onTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    
    Widget target;
    switch (index) {
      case 0: target = const B2BDashboardScreen(); break;
      case 1: target = const B2BOrdersScreen(); break;
      case 2: target = const B2BMarketplaceScreen(); break;
      case 3: target = const B2BAnalyticsScreen(); break;
      case 4: target = const B2BProfileScreen(); break;
      default: return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => target));
  }

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
          'Track Order',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Map Area (Mock)
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5D5C5),
                    image: DecorationImage(
                      // We'll just use a pattern or map placeholder
                      image: AssetImage('assets/images/logo_illustration.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.white54, BlendMode.lighten),
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.map_outlined, size: 80, color: rustBrown.withAlpha(50)),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, color: rustBrown, size: 8),
                        SizedBox(width: 6),
                        Text('Live Tracking Enabled', style: TextStyle(color: rustBrown, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Content
            Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Status Card
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('ORDER ID', style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 2),
                                  Text('KP-BULK-20458', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD6ECC1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('In Transit', style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(height: 1, color: Colors.black12),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('EST. DELIVERY', style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 2),
                                    Text('Today • 5:30 PM', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('VEHICLE NO.', style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 2),
                                    Text('KA-01-TR-4589', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(height: 1, color: Colors.black12),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1EDE0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Icon(Icons.local_shipping_outlined, color: rustBrown, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Current Location: Near Tumkur Bypass', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600)),
                                    SizedBox(height: 2),
                                    Text('Last updated 2 mins ago', style: TextStyle(fontSize: 11, color: Colors.black54)),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Farmer Info Card
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              const CircleAvatar(
                                radius: 22,
                                backgroundImage: AssetImage('assets/images/farmer_card.png'),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  child: const Icon(Icons.verified, color: rustBrown, size: 14),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Ramesh Gowda Farms', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                SizedBox(height: 2),
                                Text('Order Dispatched Successfully', style: TextStyle(fontSize: 11, color: rustBrown, fontWeight: FontWeight.bold)),
                                SizedBox(height: 2),
                                Text('Mandya, Karnataka', style: TextStyle(fontSize: 10, color: Colors.black54)),
                              ],
                            ),
                          ),
                          const Text('11:20 AM', style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Delivery Timeline
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Delivery Timeline', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                          const SizedBox(height: 20),
                          _buildTimelineStep(Icons.check, 'Order Confirmed', 'Oct 24 • 09:00 AM', true, true),
                          _buildTimelineStep(Icons.inventory_2_outlined, 'Quality Check & Packed', 'Oct 24 • 10:30 AM', true, true),
                          _buildTimelineStep(Icons.local_shipping_outlined, 'Dispatched from Hub', 'Oct 24 • 11:20 AM', true, true),
                          _buildTimelineStep(Icons.near_me_outlined, 'In Transit', 'On the way to your warehouse', true, false, isCurrent: true),
                          _buildTimelineStep(Icons.home_outlined, 'Delivered', 'Expected by 5:30 PM Today', false, false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Logistics Contact Card
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5D5C5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.business_center_outlined, color: rustBrown),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('KisanPro Logistics', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                                Text('Wholesale Transport Delivery', style: TextStyle(fontSize: 11, color: Colors.black54)),
                                SizedBox(height: 4),
                                Text('+91 9876543210', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: const BoxDecoration(color: rustBrown, shape: BoxShape.circle),
                            child: const Icon(Icons.call, color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120), // Bottom sheet spacing
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: bgBeige,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
                  elevation: 0,
                ),
                onPressed: () {
                  // Call logic
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.chat_bubble_outline),
                    SizedBox(width: 8),
                    Text('Contact Delivery Partner', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: rustBrown),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const B2BOrdersScreen()),
                  );
                },
                child: const Text('View Order Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: rustBrown)),
              ),
            ),
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
            currentIndex: 2, // Orders icon
            onTap: (index) {
              if (index == 0) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const B2BDashboardScreen()),
                  (route) => false,
                );
              } else if (index == 1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BMarketplaceScreen()));
              } else if (index == 2) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BOrdersScreen()));
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

  Widget _buildTimelineStep(IconData icon, String title, String subtitle, bool isCompleted, bool showLine, {bool isCurrent = false}) {
    const Color rustBrown = Color(0xFFAD521B);
    final Color iconBgColor = isCompleted ? const Color(0xFF4B6F32) : (isCurrent ? rustBrown : const Color(0xFFE5E5E5));
    final Color titleColor = isCurrent ? rustBrown : (isCompleted ? Colors.black87 : Colors.black45);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? const Color(0xFFE5D5C5) : Colors.black12,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: titleColor)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
