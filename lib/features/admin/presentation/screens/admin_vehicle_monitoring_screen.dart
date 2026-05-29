import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class AdminVehicleMonitoringScreen extends StatelessWidget {
  final String plateNumber;
  final String driverName;
  final String routeAssigned;
  final String cargo;

  const AdminVehicleMonitoringScreen({
    super.key,
    this.plateNumber = "KA-05-TR-4589",
    this.driverName = "Suresh",
    this.routeAssigned = "Kolar -> Bengaluru",
    this.cargo = "Fresh Vegetables",
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color bgSlate = AppColors.bgSlate;
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;

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
              "Vehicle Monitoring",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              plateNumber,
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
              color: greenBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: greenText,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  "LIVE",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: greenText,
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
              // 1. Vehicle & Driver Overview Card
              _buildOverviewCard(context),
              const SizedBox(height: 16),

              // 2. Real-time Tracking Map Simulator
              _buildMapSimulator(),
              const SizedBox(height: 16),

              // 3. Driver Monitoring Card
              _buildDriverMonitoringCard(),
              const SizedBox(height: 16),

              // 4. Forward Collision Card
              _buildForwardCollisionCard(),
              const SizedBox(height: 16),

              // 5. Cargo Monitoring Card
              _buildCargoMonitoringCard(),
              const SizedBox(height: 16),

              // 6. Recent Alerts Table
              _buildRecentAlertsTable(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;

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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryPurple.withAlpha((0.1 * 255).round()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_shipping_rounded, color: primaryPurple, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Vehicle Number",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plateNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.surfaceLight),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.borderLight,
                backgroundImage: const NetworkImage(
                  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=150",
                ),
                onBackgroundImageError: (_, __) {},
                child: const Icon(Icons.person, color: primaryPurple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Driver",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      driverName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.surfaceLight),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Route",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      routeAssigned,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Cargo",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        cargo,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.infoBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.directions_run_rounded, color: Colors.blueAccent, size: 10),
                            SizedBox(width: 4),
                            Text(
                              "In Transit",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSimulator() {
    return Container(
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
        children: [
          // Top bar of map
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMapMetaItem(Icons.location_on_rounded, "Electronic City"),
                _buildMapMetaItem(Icons.schedule_outlined, "45 Min ETA"),
                _buildMapMetaItem(Icons.speed_rounded, "42 KM/H"),
              ],
            ),
          ),

          // Map box container with premium visuals
          Container(
            height: 240,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=600",
                ),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
            child: Stack(
              children: [
                // Semi-transparent blue tint mapping path
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withAlpha((0.15 * 255).round()),
                          Colors.indigo.withAlpha((0.3 * 255).round()),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),

                // Simulated road line drawing
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 120,
                    child: CustomPaint(
                      painter: MapRoutePainter(),
                    ),
                  ),
                ),

                // Map Zoom Controls
                Positioned(
                  right: 12,
                  bottom: 56,
                  child: Column(
                    children: [
                      _buildMapControlBtn(Icons.add),
                      const SizedBox(height: 6),
                      _buildMapControlBtn(Icons.remove),
                    ],
                  ),
                ),

                // Map target location button
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: _buildMapControlBtn(Icons.my_location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapMetaItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
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

  Widget _buildMapControlBtn(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).round()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.textPrimary, size: 18),
    );
  }

  Widget _buildDriverMonitoringCard() {
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;

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
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.psychology_outlined, color: AppColors.primaryPurple, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Driver Monitoring",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: greenBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Safe Driving",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: greenText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Simulated camera feed (grayscale face scan)
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]),
              ),
            ),
            child: Stack(
              children: [
                // Bounding boxes overlay
                CustomPaint(
                  size: const Size(double.infinity, 180),
                  painter: CameraMeshPainter(),
                ),

                // BLINKING REC WATERMARK
                Positioned(
                  top: 12,
                  left: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "CAB CAM 01",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(color: AppColors.textPrimary, blurRadius: 4, offset: Offset(1, 1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Indicators metrics row
          Row(
            children: [
              Expanded(child: _buildSurveillanceMeta("Attention", "Focused")),
              const SizedBox(width: 8),
              Expanded(child: _buildSurveillanceMeta("Eyes", "Normal")),
              const SizedBox(width: 8),
              Expanded(child: _buildSurveillanceMeta("Fatigue", "Low")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSurveillanceMeta(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForwardCollisionCard() {
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;

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
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.warning_amber_rounded, color: AppColors.primaryPurple, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Forward Collision",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: greenBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Safe Distance",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: greenText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Dashcam highway view container
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1542362567-b07eac790acd?auto=format&fit=crop&q=80&w=400",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Highlight box representing safety range
                Center(
                  child: Container(
                    width: 140,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: greenText, width: 2),
                      color: greenText.withAlpha((0.08 * 255).round()),
                    ),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      color: greenText,
                      child: const Text(
                        "LEAD VEHICLE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Metrics summary
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Distance",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "18 meters",
                      style: TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Risk Level",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "LOW",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: greenText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCargoMonitoringCard() {
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;

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
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.inventory_2_outlined, color: AppColors.primaryPurple, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Cargo Monitoring",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: greenBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Cargo Safe",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: greenText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Container interior showing crates under cold/sensor lights
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1595855759920-86582396756a?auto=format&fit=crop&q=80&w=400",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Cold blueish color filter simulating refrigerated container
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue.withAlpha((0.15 * 255).round()),
                    ),
                  ),
                ),

                // Semi-transparent sensor glassmorphism overlay at bottom
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha((0.85 * 255).round()),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: const [
                              Text(
                                "TEMP",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "12°C",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textNavy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha((0.85 * 255).round()),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: const [
                              Text(
                                "HUMIDITY",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "64%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textNavy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAlertsTable() {
    const Color primaryPurple = AppColors.primaryPurple;

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
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.history, color: AppColors.primaryPurple, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Recent Alerts",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryPurple,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Custom table view mimicking raw_3.png exactly
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(2.8),
              2: FlexColumnWidth(1.6),
              3: FlexColumnWidth(1.0),
            },
            children: [
              // Header row
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.surfaceLight, width: 1.5)),
                ),
                children: [
                  _buildTableHeader("TIME"),
                  _buildTableHeader("ALERT TYPE"),
                  _buildTableHeader("SEVERITY"),
                  _buildTableHeader("ACTION"),
                ],
              ),

              // Row 1: Slight Fatigue
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.bgSlate, width: 1)),
                ),
                children: [
                  _buildTableCell("14:45"),
                  _buildTableCell("Slight Fatigue\nDetected", isMultiline: true),
                  _buildTableCellBadge("Minor", AppColors.dangerBg, AppColors.dangerRed),
                  _buildTableCellAction(),
                ],
              ),

              // Row 2: Hard Braking
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.bgSlate, width: 1)),
                ),
                children: [
                  _buildTableCell("14:22"),
                  _buildTableCell("Hard Braking\nDetected", isMultiline: true),
                  _buildTableCellBadge("Moderate", AppColors.warningBg, const Color(0xFFF59E0B)),
                  _buildTableCellAction(),
                ],
              ),

              // Row 3: Route Divergence
              TableRow(
                children: [
                  _buildTableCell("13:10"),
                  _buildTableCell("Route\nDivergence", isMultiline: true),
                  _buildTableCellBadge("Resolved", AppColors.surfaceLight, const Color(0xFF64748B)),
                  _buildTableCellAction(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.textTertiary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: isMultiline ? 1.3 : 1.0,
        ),
      ),
    );
  }

  Widget _buildTableCellBadge(String text, Color bgColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: UnconstrainedBox(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCellAction() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.primaryPurple,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter for real-time map road route path simulation
class MapRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryPurple
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(20, size.height - 20)
      ..cubicTo(size.width * 0.3, size.height * 0.9, size.width * 0.4, size.height * 0.2, size.width * 0.7, size.height * 0.3)
      ..lineTo(size.width - 20, 20);

    canvas.drawPath(path, paint);

    // Draw starting point circle
    final startPaint = Paint()..color = AppColors.primaryPurple;
    canvas.drawCircle(const Offset(20, 100), 6, startPaint);

    // Draw end pin/target circle
    final endPaint = Paint()..color = Colors.redAccent;
    canvas.drawCircle(Offset(size.width - 20, 20), 8, endPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter overlaying simulated facial mesh boxes
class CameraMeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = AppColors.successGreen
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw bounding box around head
    final headRect = Rect.fromLTWH(size.width * 0.35, 30, size.width * 0.3, 100);
    canvas.drawRect(headRect, boxPaint);

    // Draw bounding box around eyes
    final eyesRect = Rect.fromLTWH(size.width * 0.4, 55, size.width * 0.2, 16);
    canvas.drawRect(eyesRect, boxPaint);

    // Draw mouth overlay
    final mouthRect = Rect.fromLTWH(size.width * 0.45, 90, size.width * 0.1, 10);
    canvas.drawRect(mouthRect, boxPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

