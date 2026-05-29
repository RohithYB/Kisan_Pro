import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../controller/vehicle_controller.dart';
import '../widgets/overview_card.dart';
import '../widgets/map_widget.dart';
import '../widgets/driver_monitor_card.dart';
import '../widgets/forward_collision_card.dart';
import '../widgets/cargo_card.dart';
import '../widgets/alerts_table.dart';

class AdminVehicleMonitoringScreen extends StatelessWidget {
  final String plateNumber;

  const AdminVehicleMonitoringScreen({
    super.key,
    this.plateNumber = "KA-05-TR-4589",
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VehicleController()..loadVehicleDetails(plateNumber),
      child: Consumer<VehicleController>(
        builder: (context, controller, child) {
          final vehicle = controller.selectedVehicle;

          if (vehicle == null) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

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
                    "Vehicle Monitoring",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    vehicle.plateNumber,
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 16, top: 14, bottom: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.successGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "LIVE",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OverviewCard(vehicle: vehicle),
                    const SizedBox(height: 16),
                    const MapWidget(), 
                    const SizedBox(height: 16),
                    const DriverMonitorCard(),
                    const SizedBox(height: 16),
                    const ForwardCollisionCard(),
                    const SizedBox(height: 16),
                    const CargoCard(),
                    const SizedBox(height: 16),
                    const AlertsTable(),
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
}

