import 'package:flutter/material.dart';
import 'b2b_track_order_screen.dart';
import 'b2b_marketplace_screen.dart';

class B2BOrderConfirmationScreen extends StatelessWidget {
  const B2BOrderConfirmationScreen({super.key});

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
          'Order Confirmation',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          Row(
            children: const [
              Icon(Icons.verified, color: Colors.greenAccent, size: 16),
              SizedBox(width: 4),
              Text('Verified\nTransaction', style: TextStyle(color: Colors.greenAccent, fontSize: 9, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Success Icon
            Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: rustBrown,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: rustBrown.withAlpha(80),
                      blurRadius: 20,
                      spreadRadius: 4,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 48),
              ),
            ),
            const SizedBox(height: 24),
            
            // Header Text
            const Text(
              'Bulk Order Placed\nSuccessfully',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your wholesale order has been sent to\nverified suppliers.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
            ),
            const SizedBox(height: 24),

            // Order ID Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Order ID', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14)),
                  Text('KP-BULK-20458', style: TextStyle(fontWeight: FontWeight.bold, color: rustBrown, fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bulk Order Summary
            const Text('BULK ORDER SUMMARY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildSummaryItem('Fresh Tomato', '60 KG • ₹18/KG', '₹1080', 'assets/images/farmer_card.png'),
                  const Divider(height: 1, color: Colors.black12),
                  _buildSummaryItem('Organic Potato', '80 KG • ₹25/KG', '₹2000', 'assets/images/fleet_card.png'),
                  const Divider(height: 1, color: Colors.black12),
                  _buildSummaryItem('Red Onion', '40 KG • ₹58.5/KG', '₹2340', 'assets/images/logo_illustration.png'),
                  const Divider(height: 1, color: Colors.black12),
                  
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1EDE0),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Total Items: 3', style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
                            Text('Total Weight: 180 KG', style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(height: 1, color: Colors.black26),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Grand Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text('₹5,420', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: rustBrown, fontFamily: 'serif')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Delivery card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Color(0xFFD6ECC1), shape: BoxShape.circle),
                    child: const Icon(Icons.local_shipping_outlined, color: Color(0xFF3E5C1D), size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Delivery in 1-2 Days', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                        SizedBox(height: 2),
                        Text('Wholesale Transport Delivery', style: TextStyle(fontSize: 11, color: Colors.black54)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.black45),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const B2BTrackOrderScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.track_changes_outlined),
                    SizedBox(width: 8),
                    Text('Track Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
                ),
                onPressed: () {
                  // Navigate back to marketplace or dashboard root
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const B2BMarketplaceScreen()),
                    (route) => route.isFirst,
                  );
                },
                child: const Text('Back to Marketplace', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              ),
            ),
            const SizedBox(height: 48),

            // Footer
            const Divider(height: 1, color: Colors.black12),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFooterBadge(Icons.verified_user_outlined, 'Verified Suppliers'),
                _buildFooterBadge(Icons.security_outlined, 'Secure Ordering'),
                _buildFooterBadge(Icons.receipt_long_outlined, 'GST Invoice'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String subtitle, String price, String imageAsset) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(imageAsset, width: 44, height: 44, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'serif')),
        ],
      ),
    );
  }

  Widget _buildFooterBadge(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF3E5C1D)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.black54, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
