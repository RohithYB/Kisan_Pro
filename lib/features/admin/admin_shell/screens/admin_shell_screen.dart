import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../dashboard/screens/admin_dashboard_screen.dart';
import '../../farmer_management/screens/admin_farmer_management_screen.dart';
import '../../vehicle_monitoring/screens/admin_fleet_management_screen.dart';
import '../../customer_management/screens/admin_customer_management_screen.dart';
import '../controller/admin_shell_controller.dart';

class AdminShellScreen extends StatelessWidget {
  final int initialTab;
  const AdminShellScreen({super.key, this.initialTab = 0});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminShellController()..setTab(initialTab),
      child: const _AdminShellScreenContent(),
    );
  }
}

class _AdminShellScreenContent extends StatelessWidget {
  const _AdminShellScreenContent();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AdminShellController>();
    const Color lightBg = Color(0xFFF7F9FC);

    return Scaffold(
      backgroundColor: lightBg,
      body: IndexedStack(
        index: controller.currentIndex,
        children: const [
          AdminDashboardScreen(),
          AdminFarmerManagementScreen(),
          AdminFleetManagementScreen(),
          AdminCustomerManagementScreen(),
        ],
      ),
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
            _buildNavItem(context, 0, Icons.dashboard_outlined, Icons.dashboard, "Dashboard", controller.currentIndex),
            _buildNavItem(context, 1, Icons.agriculture_outlined, Icons.agriculture_rounded, "Farmers", controller.currentIndex),
            _buildNavItem(context, 2, Icons.local_shipping_outlined, Icons.local_shipping_rounded, "Fleet", controller.currentIndex),
            _buildNavItem(context, 3, Icons.people_outline_rounded, Icons.people_rounded, "Customers", controller.currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData outlineIcon, IconData filledIcon, String label, int selectedIndex) {
    final bool isSelected = selectedIndex == index;
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
        onTap: () {
          context.read<AdminShellController>().setTab(index);
        },
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
}

