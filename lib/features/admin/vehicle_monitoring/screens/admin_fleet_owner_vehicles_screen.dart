import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../controller/vehicle_controller.dart';
import '../widgets/vehicle_card.dart';
import 'admin_fleet_profile_view_screen.dart';

class AdminFleetOwnerVehiclesScreen extends StatelessWidget {
  final String ownerName;
  final String ownerId;
  final int totalVehicles;

  const AdminFleetOwnerVehiclesScreen({
    super.key,
    this.ownerName = "Ramesh Logistics",
    this.ownerId = "FLT-2045",
    this.totalVehicles = 18,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VehicleController()..loadOwnerVehicles(ownerId),
      child: Consumer<VehicleController>(
        builder: (context, controller, child) {
          final vehicles = controller.ownerVehicles;
          
          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryPurple),
                onPressed: () => Navigator.pop(context),
              ),
              title: Column(
                children: [
                  const Text(
                    "Fleet Vehicles",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Fleet Owner: $ownerName",
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Owner Summary Card
                    _buildOwnerSummaryCard(context),
                    const SizedBox(height: 16),

                    // 2. Metrics Rows
                    _buildMetricListItem(Icons.local_shipping_outlined, "Deliveries Active", "08", AppColors.primaryPurple),
                    const SizedBox(height: 12),
                    _buildMetricListItem(Icons.timer_outlined, "Vehicles Idle", "07", AppColors.warningOrange),
                    const SizedBox(height: 12),
                    _buildMetricListItem(Icons.warning_amber_rounded, "Monitoring Alerts", "03", Colors.redAccent),
                    const SizedBox(height: 12),
                    _buildMetricListItem(Icons.sports_volleyball, "Drivers Active", "08", Colors.blueAccent),
                    const SizedBox(height: 24),

                    // 3. Section Header "Fleet Vehicles"
                    _buildSectionHeader(),
                    const SizedBox(height: 16),

                    // 4. Vehicles Cards
                    if (controller.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ...vehicles.map((v) => VehicleCard(vehicle: v)),
                      
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOwnerSummaryCard(BuildContext context) {
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;
    const Color orangeText = AppColors.warningOrange;
    const Color orangeBg = AppColors.warningBg;
    const Color greyText = Color(0xFF64748B);
    const Color greyBg = AppColors.surfaceLight;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminFleetProfileViewScreen(
                    ownerName: ownerName,
                    ownerId: ownerId,
                  ),
                ),
              );
            },
            child: Text(
              ownerName,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryPurple,
                letterSpacing: -0.3,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'ID: $ownerId • $totalVehicles Vehicles Total',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatusBadge("Active (09)", greenText, greenBg),
              const SizedBox(width: 8),
              _buildStatusBadge("Idle (07)", orangeText, orangeBg),
              const SizedBox(width: 8),
              _buildStatusBadge("Maintenance (02)", greyText, greyBg),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricListItem(IconData icon, String title, String value, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Fleet Vehicles",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Monitor delivery vehicles in real-time",
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.filter_list_rounded, color: AppColors.textSecondary, size: 16),
              SizedBox(width: 4),
              Text(
                "Filter",
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

