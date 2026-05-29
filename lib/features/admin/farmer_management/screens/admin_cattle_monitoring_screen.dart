import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../controller/cattle_monitoring_controller.dart';
import '../widgets/cattle_count_card.dart';
import '../widgets/telemetry_sensor_card.dart';
import '../widgets/security_log_row.dart';
import '../widgets/live_surveillance_feed.dart';

class AdminCattleMonitoringScreen extends StatefulWidget {
  final String farmerName;
  final String farmerId;
  final String location;
  final String joined;
  final String avatarUrl;

  const AdminCattleMonitoringScreen({
    super.key,
    required this.farmerName,
    required this.farmerId,
    required this.location,
    required this.joined,
    required this.avatarUrl,
  });

  @override
  State<AdminCattleMonitoringScreen> createState() => _AdminCattleMonitoringScreenState();
}

class _AdminCattleMonitoringScreenState extends State<AdminCattleMonitoringScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CattleMonitoringController()..loadMonitoringData(widget.farmerId),
      child: Consumer<CattleMonitoringController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            body: SafeArea(
              child: Column(
                children: [
                  // 1. Custom Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    color: Colors.white,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryPurple),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.farmerName} - Telemetry',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryPurple,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'ID: ${widget.farmerId} • Cattle Monitoring Feed',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(widget.avatarUrl),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),

                  // 2. Scrollable details body
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20.0),
                      children: [
                        // Active Status Indicator Bar
                        Row(
                          children: [
                            FadeTransition(
                              opacity: Tween<double>(begin: 0.3, end: 1.0).animate(_pulseController),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'LIVE FEED ACTIVE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Stats counter row cards
                        Row(
                          children: [
                            Expanded(
                              child: CattleCountCard(
                                label: "Healthy",
                                value: controller.healthyCount,
                                badgeColor: AppColors.successBg,
                                textColor: const Color(0xFF15803D),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CattleCountCard(
                                label: "Critical",
                                value: controller.criticalCount,
                                badgeColor: AppColors.dangerBg,
                                textColor: Colors.redAccent,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CattleCountCard(
                                label: "Observation",
                                value: controller.observationCount,
                                badgeColor: AppColors.warningBg,
                                textColor: AppColors.warningOrange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          "LIVE SURVEILLANCE FEED",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black45,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        LiveSurveillanceFeed(
                          location: widget.location,
                          pulseController: _pulseController,
                        ),
                        
                        const SizedBox(height: 24),

                        // Pasture Environmental Telemetry
                        const Text(
                          "PASTURE METRICS & CORE ENVIRONMENT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black45,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TelemetrySensorCard(
                                icon: Icons.thermostat_rounded,
                                label: "Pasture Temp",
                                value: controller.pastureTemp,
                                status: "Optimal",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TelemetrySensorCard(
                                icon: Icons.water_drop_rounded,
                                label: "Soil Moisture",
                                value: controller.soilMoisture,
                                status: "Normal",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TelemetrySensorCard(
                                icon: Icons.wb_cloudy_rounded,
                                label: "Humidity",
                                value: controller.humidity,
                                status: "Stable",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Farm/Pasture Security Alert Logs Feed
                        const Text(
                          "PASTURE SECURITY & GEOLOCATION LOGS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black45,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.black.withAlpha((0.04 * 255).round()),
                            ),
                          ),
                          child: Column(
                            children: const [
                              SecurityLogRow(
                                icon: Icons.warning_amber_rounded,
                                iconColor: Colors.amber,
                                title: "Tractor Crossing Boundary",
                                details: "Pasture A North Gate • just now",
                              ),
                              Divider(height: 24, color: AppColors.surfaceLight),
                              SecurityLogRow(
                                icon: Icons.error_outline_rounded,
                                iconColor: Colors.redAccent,
                                title: "Water Level Critical",
                                details: "Pasture B Supply Trough 2 • 15m ago",
                              ),
                              Divider(height: 24, color: AppColors.surfaceLight),
                              SecurityLogRow(
                                icon: Icons.check_circle_outline_rounded,
                                iconColor: Colors.green,
                                title: "Cattle ID 8845 Out of Bounds",
                                details: "Resolved: Shepherd pastured back in • 1h ago",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
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

