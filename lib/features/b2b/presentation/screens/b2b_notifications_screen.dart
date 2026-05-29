import 'package:flutter/material.dart';
import 'b2b_track_order_screen.dart';
import 'b2b_product_details_screen.dart';

class B2BNotificationsScreen extends StatelessWidget {
  const B2BNotificationsScreen({super.key});

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
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist_rtl, color: Colors.white),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', true, rustBrown),
                  const SizedBox(width: 12),
                  _buildFilterChip('Orders', false, rustBrown),
                  const SizedBox(width: 12),
                  _buildFilterChip('Stock Alerts', false, rustBrown),
                  const SizedBox(width: 12),
                  _buildFilterChip('Price Alerts', false, rustBrown),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Header Stats
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDE0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.circle, size: 8, color: rustBrown),
                      SizedBox(width: 8),
                      Text('12 New Notifications', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6ECC1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('4 Delivery Updates', style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Notification Cards
            _buildNotificationCard(
              context,
              icon: Icons.inventory_2_outlined,
              iconBgColor: const Color(0xFFFFDAB9),
              iconColor: rustBrown,
              title: 'Order Update',
              time: '10m ago',
              description: 'Your Fresh Tomato order has been dispatched.',
              extraWidget: const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
                child: Text('ID: KP-BULK-20458', style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
              ),
              buttonWidget: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const B2BTrackOrderScreen()));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Track Order', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ),

            _buildNotificationCard(
              context,
              icon: Icons.storefront_outlined,
              iconBgColor: const Color(0xFFFFE0B2),
              iconColor: const Color(0xFFE65100),
              title: 'Stock Alert',
              time: '30m ago',
              description: 'Fresh Onion stock is now available from verified suppliers.',
              extraWidget: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6ECC1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text('1,200 KG Available', style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
              buttonWidget: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: rustBrown),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const B2BProductDetailsScreen()));
                },
                child: const Text('View Product', style: TextStyle(color: rustBrown, fontWeight: FontWeight.bold)),
              ),
            ),

            _buildNotificationCard(
              context,
              icon: Icons.trending_down,
              iconBgColor: const Color(0xFFC8E6C9),
              iconColor: const Color(0xFF2E7D32),
              title: 'Price Alert',
              time: '1h ago',
              description: 'Tomato wholesale price dropped to ₹16/KG.',
              extraWidget: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                child: Row(
                  children: const [
                    Text('Prev: ₹18/KG', style: TextStyle(fontSize: 12, color: Colors.redAccent, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.bold)),
                    SizedBox(width: 12),
                    Text('Save 11%', style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              buttonWidget: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                onPressed: () {},
                child: const Text('Reorder', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            _buildNotificationCard(
              context,
              icon: Icons.local_shipping_outlined,
              iconBgColor: const Color(0xFFE0E0E0),
              iconColor: Colors.black87,
              title: 'Delivery Update',
              time: '2h ago',
              description: 'Your order will arrive today by 5:30 PM.',
              extraWidget: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                child: Row(
                  children: const [
                    Icon(Icons.directions_car_outlined, size: 14, color: Colors.black54),
                    SizedBox(width: 6),
                    Text('Vehicle: KA-01-TR-4589', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
              buttonWidget: null,
            ),
          ],
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

  Widget _buildNotificationCard(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String time,
    required String description,
    required Widget? extraWidget,
    required Widget? buttonWidget,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: Color(0xFFAD521B),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(12.0)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                              Text(time, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(description, style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4)),
                          if (extraWidget != null) extraWidget,
                          if (buttonWidget != null) buttonWidget,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
