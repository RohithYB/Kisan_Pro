import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'admin_dashboard_screen.dart';
import 'admin_farmer_management_screen.dart';
import 'admin_fleet_management_screen.dart';
import 'admin_customer_management_screen.dart';

class AdminShellScreen extends StatefulWidget {
  final int initialTab;
  const AdminShellScreen({super.key, this.initialTab = 0});

  @override
  State<AdminShellScreen> createState() => _AdminShellScreenState();
}

class _AdminShellScreenState extends State<AdminShellScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color lightBg = Color(0xFFF7F9FC);

    // IndexedStack maintains state of each tab while switching
    return Scaffold(
      backgroundColor: lightBg,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const AdminDashboardScreen(),
          const AdminFarmerManagementScreen(),
          const AdminFleetManagementScreen(),
          const AdminCustomerManagementScreen(),
        ],
      ),
      // Static bottom navigation bar aligned to mimic raw_2.png exactly
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.06 * 255).round()),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.dashboard_outlined, Icons.dashboard, "Dashboard"),
            _buildNavItem(1, Icons.agriculture_outlined, Icons.agriculture_rounded, "Farmers"),
            _buildNavItem(2, Icons.local_shipping_outlined, Icons.local_shipping_rounded, "Fleet"),
            _buildNavItem(3, Icons.people_outline_rounded, Icons.people_rounded, "Customers"),
          ],
        ),
      ),
    );
  }

  // Visual recreation of the capsule capsule-shaped tab selector from the mocks
  Widget _buildNavItem(int index, IconData outlineIcon, IconData filledIcon, String label) {
    final bool isSelected = _selectedIndex == index;
    const Color primaryPurple = AppColors.primaryPurple;

    if (isSelected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: primaryPurple,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              filledIcon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onItemTapped(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                outlineIcon,
                color: Colors.black45,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildMockTab({
    required String title,
    required IconData icon,
    required String subtitle,
    required List<Map<String, dynamic>> metrics,
    required List<String> criticalLogs,
  }) {
    const Color primaryPurple = AppColors.primaryPurple;

    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        children: [
          // Row with profile
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryPurple),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: primaryPurple.withAlpha((0.1 * 255).round()),
                child: const Icon(Icons.person, color: primaryPurple),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Banner card
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryPurple, Color(0xFF6B58F2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    "Overview operations details and tracking feeds",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Metrics row
          Row(
            children: metrics.map((metric) {
              return Expanded(
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.black.withAlpha((0.05 * 255).round())),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          metric["label"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          metric["value"],
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: metric["color"]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),

          // Log List
          const Text(
            "CRITICAL ALERTS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black45, letterSpacing: 0.5),
          ),
          const SizedBox(height: 12),
          ...criticalLogs.map((log) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.red.withAlpha((0.15 * 255).round())),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      log,
                      style: const TextStyle(fontSize: 13, color: Colors.redAccent, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

