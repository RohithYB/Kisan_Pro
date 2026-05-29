import 'package:flutter/material.dart';
import '../../../dashboard/presentation/screens/b2b_dashboard_screen.dart';
import 'b2b_marketplace_screen.dart';
import 'b2b_orders_screen.dart';
import 'b2b_analytics_screen.dart';

class B2BProfileScreen extends StatelessWidget {
  const B2BProfileScreen({super.key});

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
          'Business Account',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            // Profile Header
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: rustBrown, width: 2),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo_illustration.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.verified, color: Color(0xFF3E5C1D), size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Sri Lakshmi\nVegetables',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.2),
            ),
            const SizedBox(height: 8),
            const Text('Wholesale Vegetable Retailer', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.location_on_outlined, size: 14, color: Colors.black54),
                SizedBox(width: 4),
                Text('KR Market, Bengaluru', style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 16),
            
            // Badges
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGreenBadge('Member Since 2021'),
                const SizedBox(width: 8),
                _buildBeigeBadge('ID: KP-BUS-20453'),
              ],
            ),
            const SizedBox(height: 8),
            _buildOrangeBadge('132 Orders Completed'),
            const SizedBox(height: 8),
            _buildGreenBadge('24 Verified Suppliers Connected'),
            const SizedBox(height: 32),

            // Business Information
            _buildSectionHeader('Business Information'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildInfoRow('PRIMARY CONTACT', 'Ramesh Gowda'),
                  const SizedBox(height: 16),
                  _buildInfoRow('MOBILE NUMBER', '+91 9876543210'),
                  const SizedBox(height: 16),
                  _buildInfoRow('EMAIL ADDRESS', 'orders@srilakshmivegetables.com'),
                  const SizedBox(height: 16),
                  _buildInfoRow('BUSINESS CATEGORY', 'Vegetables & Farm Produce'),
                  const SizedBox(height: 16),
                  _buildInfoRow('WAREHOUSE CAPACITY', '12 Tons'),
                  const SizedBox(height: 16),
                  _buildInfoRow('REGISTRATION NUMBER', 'REG-456721'),
                  const SizedBox(height: 16),
                  _buildInfoRow('OPERATIONAL AREA', 'Bengaluru Urban & Rural Markets'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // GST & Billing
            _buildSectionHeader('GST & Billing Information'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildInfoRow('GST IDENTIFICATION NUMBER', '29ABCDE1234F1Z5')),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6ECC1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Text('Verified', style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('BILLING STATUS', 'GST Billing Enabled'),
                  const SizedBox(height: 16),
                  _buildInfoRow('STATE', 'Karnataka'),
                  const SizedBox(height: 16),
                  _buildInfoRow('INVOICE EMAIL', 'billing@srilakshmivegetables.com'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Payment Settings
            _buildSectionHeader('Payment Settings'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildPaymentSettingRow(Icons.account_balance_wallet, 'UPI Business', 'Active', false),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider(height: 1, color: Colors.black12)),
                  _buildPaymentSettingRow(Icons.account_balance, 'Bank Account', 'Linked (HDFC Bank)', false),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider(height: 1, color: Colors.black12)),
                  _buildPaymentSettingRow(Icons.credit_card, 'Business Credit Line', '₹5,00,000 Limit', true),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: rustBrown,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text('Manage Payment Methods', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Saved Business Addresses
            _buildSectionHeader('Saved Business Addresses'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildAddressRow('Primary Warehouse', '12 Market Road, KR Market, Bengaluru - 560002'),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: Divider(height: 1, color: Colors.black12)),
                  _buildAddressRow('Secondary Distribution Center', 'Plot 45, Sector B, Industrial Area, Yeshwanthpur, Bengaluru - 560022'),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: Divider(height: 1, color: Colors.black12)),
                  _buildAddressRow('Retail Delivery Point', 'Shop 12, Main Road, Tumkur Road, Malleswaram, Bengaluru - 560018'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: rustBrown),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () {},
                      child: const Text('Manage Addresses', style: TextStyle(color: rustBrown, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Business Performance
            _buildSectionHeader('Business Performance'),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildPerformanceCard(Icons.shopping_bag_outlined, 'Total Orders', '128'),
                _buildPerformanceCard(Icons.money_outlined, 'Monthly Spend', '₹52,400'),
                _buildPerformanceCard(Icons.group_outlined, 'Active Suppliers', '24'),
                _buildPerformanceCard(Icons.speed_outlined, 'Fulfillment Rate', '98%'),
              ],
            ),
            const SizedBox(height: 32),

            // Account Settings
            _buildSectionHeader('Account Settings'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildSettingMenu(Icons.notifications_none, 'Notification Preferences'),
                  const Divider(height: 1, color: Colors.black12),
                  _buildSettingMenu(Icons.language, 'Language Settings', subtitle: 'English (India)'),
                  const Divider(height: 1, color: Colors.black12),
                  _buildSettingMenu(Icons.lock_outline, 'Privacy & Security'),
                  const Divider(height: 1, color: Colors.black12),
                  _buildSettingMenu(Icons.help_outline, 'Help & Support'),
                  const Divider(height: 1, color: Colors.black12),
                  _buildSettingMenu(Icons.gavel_outlined, 'Terms & Conditions'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Logout
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: rustBrown),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
                onPressed: () {
                  // Navigate to main app dashboard
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout, color: rustBrown, size: 20),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(color: rustBrown, fontWeight: FontWeight.bold, fontSize: 16)),
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
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10,
                offset: const Offset(0, -2),
              )
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: 4, // Account
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BDashboardScreen()));
              } else if (index == 1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BMarketplaceScreen()));
              } else if (index == 2) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BOrdersScreen()));
              } else if (index == 3) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const B2BAnalyticsScreen()));
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: rustBrown,
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            // User asked to make it thicker / more upward
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

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black45, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildGreenBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFD6ECC1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFF3E5C1D), fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildBeigeBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE5D5C5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildOrangeBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE0B2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFFAD521B), fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPaymentSettingRow(IconData icon, String title, String subtitle, bool isGold) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Color(0xFFF1EDE0),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFAD521B), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
        if (isGold)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700).withAlpha(50),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFFFD700)),
            ),
            child: const Text('GOLD', style: TextStyle(color: Color(0xFFB8860B), fontSize: 10, fontWeight: FontWeight.bold)),
          )
        else
          const Icon(Icons.check_circle, color: Color(0xFF3E5C1D), size: 16),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, color: Colors.black45),
      ],
    );
  }

  Widget _buildAddressRow(String title, String address) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.storefront, color: Color(0xFFAD521B), size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 4),
              Text(address, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFAD521B), size: 24),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSettingMenu(IconData icon, String title, {String? subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black45)) : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.black45),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      onTap: () {},
    );
  }
}
