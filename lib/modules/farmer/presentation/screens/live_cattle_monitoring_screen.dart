import 'package:flutter/material.dart';
import '../controller/farmer_controller.dart';
import 'farm_setup_screen.dart';
import 'cam_live_view_screen.dart';

class LiveCattleMonitoringScreen extends StatefulWidget {
  const LiveCattleMonitoringScreen({super.key});

  @override
  State<LiveCattleMonitoringScreen> createState() => _LiveCattleMonitoringScreenState();
}

class _LiveCattleMonitoringScreenState extends State<LiveCattleMonitoringScreen> {
  bool _cameraPermissionGranted = false;

  void _requestCameraPermission(String camName, String camLoc, int index) {
    const Color tealAccent = Color(0xFF0C7A70);

    if (_cameraPermissionGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CamLiveViewScreen(
            cameraName: camName,
            cameraLocation: camLoc,
            cowCount: 15 + (index * 3) % 7,
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: const Color(0xFFFFFCE4),
        title: Row(
          children: const [
            Icon(Icons.videocam_rounded, color: tealAccent),
            SizedBox(width: 10),
            Text("Surveillance Camera", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          "Kisan Pro needs permission to access your device's Camera to align surveillance markers and open real-world security streams.",
          style: TextStyle(color: Colors.black87, height: 1.35),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Surveillance stream requires camera permission."),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Deny", style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: tealAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _cameraPermissionGranted = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Surveillance camera connection approved!"),
                  backgroundColor: tealAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CamLiveViewScreen(
                    cameraName: camName,
                    cameraLocation: camLoc,
                    cowCount: 15 + (index * 3) % 7,
                  ),
                ),
              );
            },
            child: const Text("Allow Access"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color tealAccent = Color(0xFF0C7A70);
    const Color bgBeige = Color(0xFFFFFCE4);

    final activeFarm = FarmerController.instance.selectedFarm;
    final List<Map<String, String>> cameras = activeFarm?.cameras ?? [];

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Live Cattle Monitoring',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Monitoring Indicator with pulsing green dot matching PNG 2
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              color: bgBeige,
              child: const Row(
                children: [
                  PulsingGreenDot(),
                  SizedBox(width: 10),
                  Text(
                    'MONITORING ACTIVE',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            // Live Cameras scroll view
            Expanded(
              child: cameras.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.videocam_off_rounded,
                              size: 72,
                              color: Colors.black26,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No Cameras Configured",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "You haven't added any cameras to this farm yet. Edit your farm profile in the list to register surveillance devices!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: tealAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              onPressed: () {
                                if (activeFarm != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FarmSetupScreen(farmToEdit: activeFarm),
                                    ),
                                  ).then((_) => setState(() {}));
                                }
                              },
                              icon: const Icon(Icons.edit_rounded),
                              label: const Text(
                                "Edit Farm Details",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: cameras.length,
                      itemBuilder: (context, index) {
                        final cam = cameras[index];
                        final String camName = cam['name'] ?? "CAM ${index + 1}";
                        final String camLoc = cam['location'] ?? "Pasture";

                        // Define mock visual characteristics
                        final String cowTrackerId = index % 2 == 0 ? "8821" : "8845";

                        return GestureDetector(
                          onTap: () => _requestCameraPermission(camName, camLoc, index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.black, // Dark container margin
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha((0.15 * 255).round()),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Stack(
                                children: [
                                  // Grayscale background representing pasture
                                  AspectRatio(
                                    aspectRatio: 1.5,
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.matrix(<double>[
                                        0.2126, 0.7152, 0.0722, 0, 0,
                                        0.2126, 0.7152, 0.0722, 0, 0,
                                        0.2126, 0.7152, 0.0722, 0, 0,
                                        0,      0,      0,      1, 0,
                                      ]),
                                      child: Image.network(
                                        index % 2 == 0
                                            ? 'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?auto=format&fit=crop&q=80&w=350'
                                            : 'https://images.unsplash.com/photo-1543882048-2598350202DF?auto=format&fit=crop&q=80&w=350',
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Container(
                                            color: Colors.black87,
                                            child: const Center(
                                              child: CircularProgressIndicator(color: Colors.white24),
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.black87,
                                            child: const Center(
                                              child: Icon(Icons.videocam, color: Colors.white38, size: 50),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  // Overlay HUD values matching PNG 2
                                  Positioned(
                                    top: 14,
                                    left: 14,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha((0.6 * 255).round()),
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.videocam_rounded, color: Colors.white, size: 14),
                                          const SizedBox(width: 6),
                                          Text(
                                            camName.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 14,
                                    right: 14,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha((0.6 * 255).round()),
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.circle, color: Colors.redAccent, size: 10),
                                          SizedBox(width: 6),
                                          Text(
                                            'REC  14:02:11',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Geofence bounding box tracker drawing overlay matching PNG 2
                                  Positioned(
                                    top: 32,
                                    left: 45,
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF00E676), // Bright green boundary
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          color: const Color(0xFF00E676).withAlpha((0.2 * 255).round()),
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          child: Text(
                                            "ID: $cowTrackerId",
                                            style: const TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Location Tag Overlay at the bottom
                                  Positioned(
                                    bottom: 12,
                                    left: 14,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        "LOC: $camLoc",
                                        style: const TextStyle(
                                          fontSize: 10,
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
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PulsingGreenDot extends StatefulWidget {
  const PulsingGreenDot({super.key});

  @override
  State<PulsingGreenDot> createState() => _PulsingGreenDotState();
}

class _PulsingGreenDotState extends State<PulsingGreenDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1.0).animate(_controller),
      child: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          color: Color(0xFF27AE60),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
