import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'admin_fleet_owner_vehicles_screen.dart';

class AdminFleetManagementScreen extends StatelessWidget {
  const AdminFleetManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color bgSlate = AppColors.bgSlate;
    const Color textNavy = AppColors.textNavy;

    // Fleet Owners details matching raw_1.png
    final List<Map<String, dynamic>> fleetOwners = [
      {
        "name": "Gowda Logistics",
        "id": "FLT-9021",
        "alerts": 2,
        "vehicles": 18,
        "activeDeliveries": 12,
        "imageUrl": "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&q=80&w=150",
      },
      {
        "name": "Patel Agri-Moves",
        "id": "FLT-8842",
        "alerts": 0,
        "vehicles": 24,
        "activeDeliveries": 15,
        "imageUrl": "https://images.unsplash.com/photo-1516576880669-dfcbfd8f6cc7?auto=format&fit=crop&q=80&w=150",
      },
      {
        "name": "Southern Haulers",
        "id": "FLT-4530",
        "alerts": 0,
        "vehicles": 32,
        "activeDeliveries": 28,
        "imageUrl": "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&q=80&w=150",
      },
      {
        "name": "Bharat Fleet Co",
        "id": "FLT-1212",
        "alerts": 0,
        "vehicles": 11,
        "activeDeliveries": 9,
        "imageUrl": "https://images.unsplash.com/photo-1578575437130-527eed3abbec?auto=format&fit=crop&q=80&w=150",
      },
    ];

    return Scaffold(
      backgroundColor: bgSlate,
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
                  color: primaryPurple,
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.borderLight),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                children: [
                  // Top Metrics Cards (Total Fleet Owners, Active Vehicles, Total Deliveries Today)
                  _buildMetricCard(
                    title: "Total Fleet Owners",
                    value: "12",
                    trend: "~2%",
                    trendColor: Colors.redAccent,
                  ),
                  const SizedBox(height: 16),
                  _buildMetricCard(
                    title: "Active Vehicles",
                    value: "85",
                    trend: "~5%",
                    trendColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 16),
                  _buildMetricCard(
                    title: "Total Deliveries Today",
                    value: "142",
                    trend: "stable",
                    trendColor: Colors.teal,
                    isStable: true,
                  ),
                  const SizedBox(height: 28),

                  // Section Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Fleet Owners",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textNavy,
                        ),
                      ),
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
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Owners List
                  ...fleetOwners.map((owner) => _buildOwnerCard(context, owner)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String trend,
    required Color trendColor,
    bool isStable = false,
  }) {
    const Color primaryPurple = AppColors.primaryPurple;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: primaryPurple,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isStable ? Icons.check_circle_outline : Icons.trending_up,
                color: trendColor,
                size: 14,
              ),
              const SizedBox(width: 2),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: trendColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerCard(BuildContext context, Map<String, dynamic> owner) {
    const Color primaryPurple = AppColors.primaryPurple;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            // Navigate to detailed vehicle owner list page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminFleetOwnerVehiclesScreen(
                  ownerName: owner["name"],
                  ownerId: owner["id"],
                  totalVehicles: owner["vehicles"],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Owner avatar / image container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.surfaceLight,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      owner["imageUrl"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.local_shipping_rounded,
                          color: primaryPurple,
                          size: 28,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Content details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              owner["name"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          _buildAlertBadge(owner["alerts"]),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        owner["id"],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: AppColors.surfaceLight),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vehicles",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textTertiary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${owner["vehicles"]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Active Deliveries",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textTertiary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  owner["activeDeliveries"] < 10
                                      ? "0${owner["activeDeliveries"]}"
                                      : "${owner["activeDeliveries"]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlertBadge(int alerts) {
    if (alerts > 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.dangerBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: AppColors.dangerRed, size: 10),
            const SizedBox(width: 4),
            Text(
              "0$alerts Alerts",
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: AppColors.dangerRed,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.infoBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle, color: AppColors.infoBlue, size: 10),
            SizedBox(width: 4),
            Text(
              "0 Alerts",
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: AppColors.infoBlue,
              ),
            ),
          ],
        ),
      );
    }
  }
}

