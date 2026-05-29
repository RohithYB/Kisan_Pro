import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import '../widgets/admin_customer_profile_dialog.dart';

class AdminCustomerDetailsScreen extends StatelessWidget {
  final String customerId;
  final String customerName;

  const AdminCustomerDetailsScreen({
    super.key,
    this.customerId = "CUST-8821",
    this.customerName = "Grand Palace Hotel",
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color bgSlate = AppColors.bgSlate;
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;

    return Scaffold(
      backgroundColor: bgSlate,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: primaryPurple),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Details",
              style: TextStyle(
                color: primaryPurple,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              customerId,
              style: const TextStyle(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Business Profile Overview Card
              _buildBusinessProfileCard(context),
              const SizedBox(height: 16),

              // 2. Metrics Cards
              _buildMetricCard(
                title: "Total Orders",
                value: "142",
                subtitle: "↗ +12% vs last month",
                subtitleColor: const Color(0xFF0369A1),
              ),
              const SizedBox(height: 16),
              _buildMetricCard(
                title: "Active Deliveries",
                value: "03",
                subtitle: "In transit",
                subtitleColor: Colors.black45,
              ),
              const SizedBox(height: 16),
              _buildCompletionRateCard(primaryPurple),
              const SizedBox(height: 24),

              // 3. Active Deliveries Section
              _buildSectionHeader(Icons.local_shipping_outlined, "Active Deliveries"),
              const SizedBox(height: 12),
              _buildActiveDeliveriesCard(),
              const SizedBox(height: 24),

              // 4. Preferred Farmers Section
              _buildSectionHeader(Icons.agriculture_rounded, "Preferred Farmers"),
              const SizedBox(height: 12),
              _buildPreferredFarmersCard(primaryPurple),
              const SizedBox(height: 24),

              // 5. Recent Complaints Section
              _buildSectionHeader(Icons.warning_amber_rounded, "Recent Complaints"),
              const SizedBox(height: 12),
              _buildRecentComplaintsCard(),
              const SizedBox(height: 24),

              // 6. Activity History Section
              _buildSectionHeader(Icons.history_rounded, "Activity History"),
              const SizedBox(height: 12),
              _buildActivityHistoryCard(primaryPurple),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textNavy, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textNavy,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessProfileCard(BuildContext context) {
    const Color blueBadgeBg = AppColors.infoBg;
    const Color blueBadgeText = Color(0xFF0369A1);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            // Square rounded logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=200",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Business Name
            GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Dismiss',
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AdminCustomerProfileDialog(
                      customerName: customerName,
                      customerId: customerId,
                    );
                  },
                );
              },
              child: Text(
                customerName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textNavy,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Pill badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Premium Hotel & Resort",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Divider(height: 1, color: AppColors.surfaceLight),
            const SizedBox(height: 20),

            // Contact Info
            _buildContactRow(Icons.location_on_outlined, "MG Road, Bengaluru"),
            const SizedBox(height: 12),
            _buildContactRow(Icons.phone_outlined, "+91 98765 43210"),
            const SizedBox(height: 12),
            _buildContactRow(Icons.mail_outline_rounded, "ops@grandpalace.com"),
            const SizedBox(height: 12),
            _buildContactRow(Icons.calendar_today_outlined, "Partner since 2021"),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6366F1), size: 18),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color subtitleColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionRateCard(Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Completion Rate",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "98.5%",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.985,
              minHeight: 6,
              backgroundColor: AppColors.surfaceLight,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDeliveriesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDeliveryItem(
            orderNo: "Order #PRO-9022",
            fleet: "Fleet: BLR-KISA-12",
            status: "Out for Delivery",
            statusBg: AppColors.dangerBg,
            statusTextColor: AppColors.dangerRed,
            eta: "ETA: 11:45 AM",
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(height: 1, color: AppColors.surfaceLight),
          ),
          _buildDeliveryItem(
            orderNo: "Order #PRO-9104",
            fleet: "Fleet: BLR-KISA-08",
            status: "Processing",
            statusBg: AppColors.surfaceLight,
            statusTextColor: const Color(0xFF64748B),
            eta: "ETA: 02:30 PM",
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem({
    required String orderNo,
    required String fleet,
    required String status,
    required Color statusBg,
    required Color statusTextColor,
    required String eta,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.store_rounded, color: Color(0xFF3B82F6), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderNo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  fleet,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: statusTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                eta,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferredFarmersCard(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFarmerItem(
            name: "Suresh Gowda",
            supply: "Supplied: 1,240kg (This Month)",
            imageUrl: "https://images.unsplash.com/photo-1595273670150-bd0c3c392e46?auto=format&fit=crop&q=80&w=150",
            primaryColor: primaryColor,
          ),
          const SizedBox(height: 12),
          _buildFarmerItem(
            name: "Ramesh Kumar",
            supply: "Supplied: 890kg (This Month)",
            imageUrl: "https://images.unsplash.com/photo-1592949837753-4e66c90c74cf?auto=format&fit=crop&q=80&w=150",
            primaryColor: primaryColor,
          ),
          const SizedBox(height: 12),
          _buildFarmerItem(
            name: "Meena Devi",
            supply: "Supplied: 450kg (This Month)",
            imageUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=150",
            primaryColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildFarmerItem({
    required String name,
    required String supply,
    required String imageUrl,
    required Color primaryColor,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.borderLight,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textNavy,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                supply,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.star_border_rounded, color: Color(0xFF6366F1), size: 22),
      ],
    );
  }

  Widget _buildRecentComplaintsCard() {
    return Column(
      children: [
        _buildComplaintCard(
          title: "Damaged Packaging",
          status: "RESOLVED",
          statusBg: AppColors.infoBg,
          statusTextColor: const Color(0xFF0369A1),
          body: "Case #ISS-203: 2 crates of tomatoes arrived with broken lids. Replacement issued within 2 hours.",
          footer: "Oct 24, 2023 • 14:20",
          accentColor: const Color(0xFF0ea5e9),
        ),
        const SizedBox(height: 12),
        _buildComplaintCard(
          title: "Delay in Transit",
          status: "INVESTIGATING",
          statusBg: AppColors.warningBg,
          statusTextColor: AppColors.warningOrange,
          body: "Case #ISS-215: Driver BLR-12 reported engine issues. Rerouting spare vehicle from nearby hub.",
          footer: "Oct 25, 2023 • 09:15",
          accentColor: const Color(0xFFf59e0b),
        ),
      ],
    );
  }

  Widget _buildComplaintCard({
    required String title,
    required String status,
    required Color statusBg,
    required Color statusTextColor,
    required String body,
    required String footer,
    required Color accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: accentColor, width: 4),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textNavy,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: statusTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                footer,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityHistoryCard(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildActivityTimelineRow(
            title: "Order #PRO-9104 Placed",
            body: "Bulk order for 500kg of Organic Basmati Rice and 200kg assorted vegetables.",
            time: "Today • 08:30 AM",
            dotColor: primaryColor,
            isFirst: true,
          ),
          _buildActivityTimelineRow(
            title: "Payment Confirmed",
            body: "Transaction ID: TXN_8821901 confirmed for ₹84,200 via Corporate Net Banking.",
            time: "Yesterday • 05:45 PM",
            dotColor: const Color(0xFF3B82F6),
          ),
          _buildActivityTimelineRow(
            title: "Inventory Inquiry",
            body: "Client checked availability of Seasonal Produce.",
            time: "2 days ago • 10:15 AM",
            dotColor: const Color(0xFF94A3B8),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTimelineRow({
    required String title,
    required String body,
    required String time,
    required Color dotColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.borderLight,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0.0 : 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

