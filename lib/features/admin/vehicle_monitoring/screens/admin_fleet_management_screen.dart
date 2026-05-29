import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../controller/fleet_management_controller.dart';
import '../widgets/fleet_metric_card.dart';
import '../widgets/fleet_owner_card.dart';

class AdminFleetManagementScreen extends StatelessWidget {
  const AdminFleetManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FleetManagementController()..loadFleetOwners(),
      child: Consumer<FleetManagementController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Title
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: const Text(
                      "Fleet Management",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),

                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20.0),
                      children: [
                        // Top Metrics Cards
                        FleetMetricCard(
                          title: "Total Fleet Owners",
                          value: controller.totalFleetOwners,
                          trend: "~2%",
                          trendColor: Colors.redAccent,
                        ),
                        const SizedBox(height: 16),
                        FleetMetricCard(
                          title: "Active Vehicles",
                          value: controller.activeVehicles,
                          trend: "~5%",
                          trendColor: Colors.blueAccent,
                        ),
                        const SizedBox(height: 16),
                        FleetMetricCard(
                          title: "Total Deliveries Today",
                          value: controller.totalDeliveriesToday,
                          trend: "stable",
                          trendColor: Colors.teal,
                          isStable: true,
                        ),
                        const SizedBox(height: 28),

                        // Section Title Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.borderLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "Viewing All Owners",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            const Text(
                              "Fleet Owners",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textNavy,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Owners List
                        ...controller.fleetOwners.map((owner) => FleetOwnerCard(owner: owner)),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

