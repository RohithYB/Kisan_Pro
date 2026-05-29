import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

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
    const Color primaryPurple = AppColors.primaryPurple;
    const Color lightPurple = Color(0xFF6B58F2);
    const Color bgSlate = Color(0xFFF7F9FC);

    return Scaffold(
      backgroundColor: bgSlate,
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
                    icon: const Icon(Icons.arrow_back_rounded, color: primaryPurple),
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
                            color: primaryPurple,
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
                        child: _buildCattleCountCard(
                          label: "Healthy",
                          value: "22",
                          badgeColor: AppColors.successBg,
                          textColor: const Color(0xFF15803D),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCattleCountCard(
                          label: "Critical",
                          value: widget.farmerName == "Suresh Gowda" ? "1" : "0",
                          badgeColor: AppColors.dangerBg,
                          textColor: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCattleCountCard(
                          label: "Observation",
                          value: "1",
                          badgeColor: AppColors.warningBg,
                          textColor: AppColors.warningOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // High-fidelity active surveillance camera card matching raw_4.png
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.2 * 255).round()),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        children: [
                          // Pasture Background image
                          AspectRatio(
                            aspectRatio: 1.6,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.green.withAlpha((0.15 * 255).round()),
                                BlendMode.colorBurn,
                              ),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?auto=format&fit=crop&q=80&w=650',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.textPrimary,
                                    child: const Center(
                                      child: Icon(Icons.videocam, color: Colors.white30, size: 48),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          // HUD Top Left Overlay: REC indicator
                          Positioned(
                            top: 14,
                            left: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha((0.6 * 255).round()),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Row(
                                children: [
                                  FadeTransition(
                                    opacity: Tween<double>(begin: 0.2, end: 1.0).animate(_pulseController),
                                    child: const Icon(Icons.circle, color: Colors.redAccent, size: 8),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'REC  CAM_01',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // HUD Top Right Overlay: Time
                          Positioned(
                            top: 14,
                            right: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha((0.6 * 255).round()),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: const Text(
                                '14:02:11',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),

                          // Geofence bounding box tracker drawing overlay matching raw_4.png
                          Positioned(
                            top: 40,
                            left: 80,
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF00E676), // Bright tracking boundary
                                  width: 1.8,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  color: const Color(0xFF00E676),
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  child: const Text(
                                    "CATTLE ID: 8821\nHEALTH: GOOD",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Active tracking crosshair
                          const Positioned(
                            bottom: 20,
                            right: 50,
                            child: Icon(
                              Icons.filter_center_focus_rounded,
                              color: Colors.amberAccent,
                              size: 28,
                            ),
                          ),

                          // Location tag overlay
                          Positioned(
                            bottom: 12,
                            left: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.textSecondary,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                "PASTURE B • ${widget.location}",
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        child: _buildTelemetrySensorCard(
                          icon: Icons.thermostat_rounded,
                          label: "Pasture Temp",
                          value: "27.5 °C",
                          status: "Optimal",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTelemetrySensorCard(
                          icon: Icons.water_drop_rounded,
                          label: "Soil Moisture",
                          value: "64%",
                          status: "Normal",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTelemetrySensorCard(
                          icon: Icons.wb_cloudy_rounded,
                          label: "Humidity",
                          value: "58%",
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
                      children: [
                        _buildSecurityLogRow(
                          icon: Icons.warning_amber_rounded,
                          iconColor: Colors.amber,
                          title: "Tractor Crossing Boundary",
                          details: "Pasture A North Gate • just now",
                        ),
                        const Divider(height: 24, color: AppColors.surfaceLight),
                        _buildSecurityLogRow(
                          icon: Icons.error_outline_rounded,
                          iconColor: Colors.redAccent,
                          title: "Water Level Critical",
                          details: "Pasture B Supply Trough 2 • 15m ago",
                        ),
                        const Divider(height: 24, color: AppColors.surfaceLight),
                        _buildSecurityLogRow(
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
  }

  Widget _buildCattleCountCard({
    required String label,
    required String value,
    required Color badgeColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.black.withAlpha((0.04 * 255).round()),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetrySensorCard({
    required IconData icon,
    required String label,
    required String value,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.black.withAlpha((0.04 * 255).round()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryPurple, size: 18),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF10B981),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityLogRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String details,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: iconColor.withAlpha((0.1 * 255).round()),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                details,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

