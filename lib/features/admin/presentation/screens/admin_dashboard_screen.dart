import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'admin_shell_screen.dart';
import 'admin_profile_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color lightPurple = Color(0xFF6B58F2);
    const Color bgSlate = Color(0xFFF7F9FC);

    return Scaffold(
      backgroundColor: bgSlate,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Custom App Bar Row matching raw_2.png exactly
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminProfileScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: lightPurple.withAlpha((0.2 * 255).round()),
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=150',
                      ),
                      onBackgroundImageError: (_, __) {},
                      child: const Icon(Icons.person, color: primaryPurple, size: 22),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Admin Dashboard',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryPurple,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'KisanPro Platform Control',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Violet Welcome Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryPurple, Color(0xFF3B2EBE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: primaryPurple.withAlpha((0.25 * 255).round()),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hello, Admin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Monitor and manage KisanPro\necosystem',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. 2x2 Stats Dashboard Grid
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      label: "Total Farmers",
                      value: "1,248",
                      icon: Icons.agriculture_rounded,
                      iconBg: AppColors.infoBg,
                      iconColor: const Color(0xFF0369A1),
                      trend: "+ 12%",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      label: "Fleet Owners",
                      value: "84",
                      icon: Icons.local_shipping_outlined,
                      iconBg: AppColors.surfaceLight,
                      iconColor: const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      label: "Active Deliveries",
                      value: "52",
                      icon: Icons.alt_route_rounded,
                      iconBg: const Color(0xFFF3E8FF),
                      iconColor: const Color(0xFF7E22CE),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      label: "Business Customers",
                      value: "432",
                      icon: Icons.storefront_outlined,
                      iconBg: AppColors.warningBg,
                      iconColor: const Color(0xFFB45309),
                      trend: "+ 4%",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 4. PLATFORM MODULES Header
              const Text(
                'PLATFORM MODULES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black45,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 16),

              // 4a. Farmer Management Card
              _buildModuleCard(
                context: context,
                title: "Farmer Management",
                subtitle: "Monitor cattle and inventory systems",
                icon: Icons.agriculture_rounded,
                stats: [
                  {"label": "Total Farmers", "value": "1,248", "color": AppColors.textPrimary},
                  {"label": "Cattle Alerts", "value": "18", "color": Colors.redAccent},
                  {"label": "Inventory Alerts", "value": "12", "color": Colors.orangeAccent},
                ],
                onTap: () {
                  // Navigate to shell with tab index 1 (Farmers)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminShellScreen(initialTab: 1),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 4b. Fleet Management Card
              _buildModuleCard(
                context: context,
                title: "Fleet Management",
                subtitle: "Monitor logistics and delivery systems",
                icon: Icons.local_shipping_outlined,
                stats: [
                  {"label": "Active Vehicles", "value": "52", "color": AppColors.textPrimary},
                  {"label": "In Transit", "value": "34", "color": Colors.blueAccent},
                  {"label": "Driver Alerts", "value": "03", "color": Colors.redAccent},
                ],
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminShellScreen(initialTab: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 4c. Customer Management Card
              _buildModuleCard(
                context: context,
                title: "Customer Management",
                subtitle: "Manage business customers and orders",
                icon: Icons.storefront_outlined,
                stats: [
                  {"label": "Active Customers", "value": "432", "color": AppColors.textPrimary},
                  {"label": "Orders Today", "value": "128", "color": Colors.blueAccent},
                  {"label": "Complaints", "value": "04", "color": Colors.redAccent},
                ],
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminShellScreen(initialTab: 3),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // 5. CRITICAL ALERTS Header
              Row(
                children: const [
                  Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'CRITICAL ALERTS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.redAccent,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 5a. Driver Drowsiness Detected Alert
              _buildAlertBlock(
                title: "Driver Drowsiness Detected",
                subtitle: "Vehicle MH-12-AB-1234 • just now",
                bgColor: const Color(0xFFFFF5F5),
                borderColor: Colors.redAccent,
                iconColor: Colors.redAccent,
              ),
              const SizedBox(height: 12),

              // 5b. Pest Detected in Inventory Alert
              _buildAlertBlock(
                title: "Pest Detected in Inventory",
                subtitle: "Warehouse A, Sec 4 • 15m ago",
                bgColor: const Color(0xFFFFFDF5),
                borderColor: AppColors.warningOrange,
                iconColor: AppColors.warningOrange,
              ),
              const SizedBox(height: 12),

              // 5c. Geo-Fencing Alert Alert
              _buildAlertBlock(
                title: "Geo-Fencing Alert",
                subtitle: "Tractor TR-09 • Route deviation • 1h ago",
                bgColor: const Color(0xFFF5F9FF),
                borderColor: Colors.blueAccent,
                iconColor: Colors.blueAccent,
              ),
              const SizedBox(height: 32),

              // 6. RECENT PLATFORM ACTIVITY Header
              const Text(
                'RECENT PLATFORM ACTIVITY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black45,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 16),

              // Activity Log Timeline Card Box
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(
                    color: Colors.black.withAlpha((0.04 * 255).round()),
                  ),
                ),
                child: Column(
                  children: [
                    _buildTimelineRow(
                      title: "New Farmer Registered",
                      subtitle: "2 Min Ago • Profile setup pending",
                      isFirst: true,
                      dotColor: Colors.blueAccent,
                    ),
                    _buildTimelineRow(
                      title: "Vehicle Assigned for Delivery",
                      subtitle: "10 Min Ago • Order #4829",
                      dotColor: const Color(0xFF94A3B8),
                    ),
                    _buildTimelineRow(
                      title: "Bulk Order Delivered",
                      subtitle: "35 Min Ago • Customer ID: C-884",
                      isLast: true,
                      dotColor: const Color(0xFF94A3B8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    String? trend,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.black.withAlpha((0.04 * 255).round()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: AppColors.successBg,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up, color: Color(0xFF15803D), size: 12),
                      const SizedBox(width: 4),
                      Text(
                        trend,
                        style: const TextStyle(
                          color: Color(0xFF15803D),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Map<String, dynamic>> stats,
    required VoidCallback onTap,
  }) {
    const Color primaryPurple = AppColors.primaryPurple;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: Colors.black.withAlpha((0.04 * 255).round()),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(icon, color: primaryPurple, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: stats.map((stat) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stat["label"],
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat["value"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: stat["color"],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertBlock({
    required String title,
    required String subtitle,
    required Color bgColor,
    required Color borderColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border(
          left: BorderSide(color: borderColor, width: 4.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: iconColor.withAlpha((0.7 * 255).round())),
        ],
      ),
    );
  }

  Widget _buildTimelineRow({
    required String title,
    required String subtitle,
    bool isFirst = false,
    bool isLast = false,
    required Color dotColor,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot & vertical indicator bar
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
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
          // Content
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
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
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

