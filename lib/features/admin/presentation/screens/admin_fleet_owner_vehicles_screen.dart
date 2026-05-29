import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'admin_vehicle_monitoring_screen.dart';
import '../widgets/admin_fleet_profile_dialog.dart';

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
    const Color primaryPurple = AppColors.primaryPurple;
    const Color bgSlate = AppColors.bgSlate;
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;
    const Color orangeText = AppColors.warningOrange;
    const Color orangeBg = AppColors.warningBg;
    const Color greyText = Color(0xFF64748B);
    const Color greyBg = AppColors.surfaceLight;

    // List of vehicles matching raw_2.png
    final List<Map<String, dynamic>> vehicles = [
      {
        "plate": "KA-05-TR-4589",
        "driver": "Suresh",
        "type": "Medium Cargo Truck",
        "route": "Kolar -> Bengaluru",
        "eta": "45 Min ETA",
        "cargo": "Vegetables",
        "lastActivity": "10 Min Ago",
        "alert": "Driver drowsiness detected",
        "status": "Active Delivery",
        "imageUrl": "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&q=80&w=250",
      },
      {
        "plate": "KA-51-MD-9021",
        "driver": "Mahesh",
        "type": "Large Reefer Truck",
        "route": "Mysore -> Bengaluru",
        "eta": "1h 22m ETA",
        "cargo": "Fruits (Cold)",
        "lastActivity": "3 Min Ago",
        "alert": null,
        "status": "Active Delivery",
        "imageUrl": "https://images.unsplash.com/photo-1516576880669-dfcbfd8f6cc7?auto=format&fit=crop&q=80&w=250",
      },
      {
        "plate": "KA-01-EV-2241",
        "driver": "Rajesh",
        "type": "Electric Cargo Van",
        "route": "Jayanagar -> Whitefield",
        "eta": "15 Min ETA",
        "cargo": "Grains",
        "lastActivity": "Just New",
        "alert": null,
        "status": "Active Delivery",
        "imageUrl": "https://images.unsplash.com/photo-1578575437130-527eed3abbec?auto=format&fit=crop&q=80&w=250",
      },
      {
        "plate": "KA-03-TR-7762",
        "driver": "Anand",
        "type": "Heavy Cargo Truck",
        "route": "Tumkur -> Bengaluru",
        "eta": "55 Min ETA",
        "cargo": "Fertilizers",
        "lastActivity": "8 Min Ago",
        "alert": null,
        "status": "Active Delivery",
        "imageUrl": "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&q=80&w=250",
      },
    ];

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
              Container(
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
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: 'Dismiss',
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return AdminFleetProfileDialog(
                              ownerName: ownerName,
                              ownerId: ownerId,
                            );
                          },
                        );
                      },
                      child: Text(
                        "$ownerName ($ownerId)",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Total Vehicles: $totalVehicles",
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
              ),
              const SizedBox(height: 16),

              // 2. Metrics Rows (Deliveries Active, Vehicles Idle, Monitoring Alerts, Drivers Active)
              _buildMetricListItem(Icons.local_shipping_outlined, "Deliveries Active", "08", primaryPurple),
              const SizedBox(height: 12),
              _buildMetricListItem(Icons.timer_outlined, "Vehicles Idle", "07", orangeText),
              const SizedBox(height: 12),
              _buildMetricListItem(Icons.warning_amber_rounded, "Monitoring Alerts", "03", Colors.redAccent),
              const SizedBox(height: 12),
              _buildMetricListItem(Icons.sports_volleyball, "Drivers Active", "08", Colors.blueAccent), // Mimics steering wheel
              const SizedBox(height: 24),

              // 3. Section Header "Fleet Vehicles"
              Row(
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
                      color: greyBg,
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
              ),
              const SizedBox(height: 16),

              // 4. Vehicles Cards
              ...vehicles.map((v) => _buildVehicleCard(context, v)),
              const SizedBox(height: 16),
            ],
          ),
        ),
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

  Widget _buildVehicleCard(BuildContext context, Map<String, dynamic> v) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Vehicle image with ALERT tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                child: Image.network(
                  v["imageUrl"],
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 140,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
              if (v["alert"] != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "ALERT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // 2. Info details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      v["plate"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    _buildStatusBadge(v["status"], greenText, greenBg),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "Driver: ${v["driver"]} • ${v["type"]}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Specs list
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildSpecChip(Icons.location_on_outlined, v["route"]),
                    _buildSpecChip(Icons.schedule_outlined, v["eta"]),
                    _buildSpecChip(Icons.inventory_2_outlined, "Cargo: ${v["cargo"]}"),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(Icons.history, color: AppColors.textTertiary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      "Last activity: ${v["lastActivity"]}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. Danger warning alert box
          if (v["alert"] != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              color: AppColors.dangerBg,
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      v["alert"],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // 4. Action button at the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Navigate to Live Vehicle Telemetry / Surveillance details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminVehicleMonitoringScreen(
                        plateNumber: v["plate"],
                        driverName: v["driver"],
                        routeAssigned: v["route"],
                        cargo: v["cargo"],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Open Vehicle Monitoring',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward_rounded, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 12),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

