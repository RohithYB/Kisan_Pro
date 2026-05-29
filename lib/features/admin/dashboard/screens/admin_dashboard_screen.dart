import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/metric_card.dart';
import '../../../../core/widgets/alert_block.dart';
import '../../../../core/widgets/timeline_row.dart';
import '../controller/admin_dashboard_controller.dart';
import '../widgets/module_card.dart';

import '../../presentation/screens/admin_shell_screen.dart'; 
import '../../presentation/screens/admin_profile_screen.dart'; 

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminDashboardController()..loadDashboardData(),
      child: Consumer<AdminDashboardController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top Custom App Bar
                    _buildAppBar(context),
                    const SizedBox(height: 24),

                    // 2. Violet Welcome Banner
                    _buildWelcomeBanner(),
                    const SizedBox(height: 24),

                    // 3. 2x2 Stats Dashboard Grid
                    _buildMetricsGrid(controller),
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
                    ModuleCard(
                      title: "Farmer Management",
                      subtitle: "Monitor cattle and inventory systems",
                      icon: Icons.agriculture_rounded,
                      stats: controller.farmerStats,
                      onTap: () {
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
                    ModuleCard(
                      title: "Fleet Management",
                      subtitle: "Monitor logistics and delivery systems",
                      icon: Icons.local_shipping_outlined,
                      stats: controller.fleetStats,
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
                    ModuleCard(
                      title: "Customer Management",
                      subtitle: "Manage business customers and orders",
                      icon: Icons.storefront_outlined,
                      stats: controller.customerStats,
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

                    // 5a. Alerts
                    const AlertBlock(
                      title: "Driver Drowsiness Detected",
                      subtitle: "Vehicle MH-12-AB-1234 • just now",
                      bgColor: Color(0xFFFFF5F5),
                      borderColor: Colors.redAccent,
                      iconColor: Colors.redAccent,
                    ),
                    const SizedBox(height: 12),
                    const AlertBlock(
                      title: "Pest Detected in Inventory",
                      subtitle: "Warehouse A, Sec 4 • 15m ago",
                      bgColor: Color(0xFFFFFDF5),
                      borderColor: AppColors.warningOrange,
                      iconColor: AppColors.warningOrange,
                    ),
                    const SizedBox(height: 12),
                    const AlertBlock(
                      title: "Geo-Fencing Alert",
                      subtitle: "Tractor TR-09 • Route deviation • 1h ago",
                      bgColor: Color(0xFFF5F9FF),
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
                        children: const [
                          TimelineRow(
                            title: "New Farmer Registered",
                            subtitle: "2 Min Ago • Profile setup pending",
                            isFirst: true,
                            dotColor: Colors.blueAccent,
                          ),
                          TimelineRow(
                            title: "Vehicle Assigned for Delivery",
                            subtitle: "10 Min Ago • Order #4829",
                            dotColor: Color(0xFF94A3B8),
                          ),
                          TimelineRow(
                            title: "Bulk Order Delivered",
                            subtitle: "35 Min Ago • Customer ID: C-884",
                            isLast: true,
                            dotColor: Color(0xFF94A3B8),
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
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
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
            backgroundColor: const Color(0xFF6B58F2).withAlpha((0.2 * 255).round()),
            backgroundImage: const NetworkImage(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=150',
            ),
            onBackgroundImageError: (_, __) {},
            child: const Icon(Icons.person, color: AppColors.primaryPurple, size: 22),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Admin Dashboard',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'KisanPro Platform Control',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryPurple, Color(0xFF3B2EBE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withAlpha((0.25 * 255).round()),
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
    );
  }

  Widget _buildMetricsGrid(AdminDashboardController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: "Total Farmers",
                value: controller.totalFarmers,
                icon: Icons.agriculture_rounded,
                iconBg: AppColors.infoBg,
                iconColor: const Color(0xFF0369A1),
                trend: "+ 12%",
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: MetricCard(
                label: "Fleet Owners",
                value: controller.fleetOwners,
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
              child: MetricCard(
                label: "Active Deliveries",
                value: controller.activeDeliveries,
                icon: Icons.alt_route_rounded,
                iconBg: const Color(0xFFF3E8FF),
                iconColor: const Color(0xFF7E22CE),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: MetricCard(
                label: "Business Customers",
                value: controller.businessCustomers,
                icon: Icons.storefront_outlined,
                iconBg: AppColors.warningBg,
                iconColor: const Color(0xFFB45309),
                trend: "+ 4%",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

