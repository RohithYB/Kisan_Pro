import 'package:flutter/material.dart';
import 'b2b_product_details_screen.dart';

class B2BSupplierProfileScreen extends StatelessWidget {
  const B2BSupplierProfileScreen({super.key});

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
          'Supplier Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Supplier Saved!')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/farmer_card.png'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Ramesh Gowda Farms',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'serif', color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Vegetable Wholesale Supplier',
                    style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6ECC1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.verified, color: Color(0xFF3E5C1D), size: 14),
                        SizedBox(width: 4),
                        Text(
                          'Verified Supplier',
                          style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Color(0xFFAD521B), size: 16),
                      SizedBox(width: 4),
                      Text(
                        '4.9/5 Rating.',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFAD521B)),
                      ),
                      Text(
                        ' (1,240 Reviews)',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(height: 1, color: Colors.black12),
                  ),
                  _buildProfileDetailRow(Icons.location_on_outlined, 'Location', 'Kolar, Karnataka'),
                  const SizedBox(height: 12),
                  _buildProfileDetailRow(Icons.work_outline, 'Experience', '12 Years in Wholesale'),
                  const SizedBox(height: 12),
                  _buildProfileDetailRow(Icons.local_shipping_outlined, 'Active Supply Regions', 'Bengaluru, Mysuru, Tumakuru'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Available Products
            const Text(
              'Available Products',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            _buildProductListCard(context, 'Fresh Tomato', '2,400 KG Available', 'MOQ: 50 KG', '1-2 Days Delivery', '18', 'assets/images/farmer_card.png'),
            _buildProductListCard(context, 'Premium Potato', '5,000 KG Available', 'MOQ: 100 KG', '2-3 Days Delivery', '22', 'assets/images/fleet_card.png'),
            const SizedBox(height: 12),

            // Farm Details
            const Text(
              'Farm Details',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            _buildFarmDetailItem(Icons.landscape_outlined, 'Farm Size', '28 Acres'),
            _buildFarmDetailItem(Icons.eco_outlined, 'Farming Method', 'Organic & Sustainable'),
            _buildFarmDetailItem(Icons.calendar_today_outlined, 'Harvest Cycle', 'Weekly Fresh'),
            _buildFarmDetailItem(Icons.ac_unit_outlined, 'Storage Facility', 'Cold Storage Available'),
            _buildFarmDetailItem(Icons.directions_car_outlined, 'Transport Support', 'Wholesale Delivery Supported'),
            const SizedBox(height: 24),

            // Bulk Supply Capacity
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bulk Supply Capacity',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  _buildCapacityRow('Daily Supply Capacity', '5 Tons / Day'),
                  const SizedBox(height: 12),
                  _buildCapacityRow('Monthly Bulk Supply', '120 Tons'),
                  const SizedBox(height: 12),
                  _buildCapacityRow('Fleet Support', '8 Vehicles'),
                  const SizedBox(height: 12),
                  _buildCapacityRow('Active Business Buyers', '42'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Supplier Performance
            const Text(
              'Supplier Performance',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildPerformanceCard('90%', 'Order Fulfillment')),
                const SizedBox(width: 12),
                Expanded(child: _buildPerformanceCard('96%', 'On-Time Delivery')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildPerformanceCard('88%', 'Repeat Buyers')),
                const SizedBox(width: 12),
                Expanded(child: _buildPerformanceCard('15 Mins', 'Response Time')),
              ],
            ),
            const SizedBox(height: 24),

            // Certifications
            const Text(
              'Certifications',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildCertChip(Icons.verified_outlined, 'Organic Certified'),
                _buildCertChip(Icons.check_circle_outline, 'FSSAI Approved'),
                _buildCertChip(Icons.gavel_outlined, 'Government Verified'),
                _buildCertChip(Icons.public_outlined, 'Export Quality'),
              ],
            ),
            const SizedBox(height: 100), // Space for bottom sheet
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: const Text('Request Bulk Order', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Text('View Products', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.black45),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.black45)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildProductListCard(BuildContext context, String title, String available, String moq, String delivery, String price, String imageAsset) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const B2BProductDetailsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageAsset,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87, fontFamily: 'serif')),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.inventory_2_outlined, size: 12, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(available, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                      const SizedBox(width: 12),
                      const Icon(Icons.shopping_bag_outlined, size: 12, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(moq, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined, size: 12, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(delivery, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('₹$price', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFAD521B))),
                          const Text('/KG', style: TextStyle(fontSize: 9, color: Colors.black54, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Text('Wholesale Price', style: TextStyle(fontSize: 9, color: Colors.black45)),
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

  Widget _buildFarmDetailItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EDE0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF3E5C1D)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 10, color: Colors.black45)),
              Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildPerformanceCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EDE0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3E5C1D))),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildCertChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7DF),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFE5D5C5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF8B3A0E)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF8B3A0E))),
        ],
      ),
    );
  }
}
