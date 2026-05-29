import 'package:flutter/material.dart';
import '../controller/farmer_controller.dart';
import 'live_cattle_monitoring_screen.dart';
import 'weight_monitoring_screen.dart';
import 'tracking_screen.dart';
import 'milk_monitoring_screen.dart';
import 'vaccine_screen.dart';
import 'member_screen.dart';
import 'alerts_screen.dart';

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color tealAccent = Color(0xFF0C7A70); // Dark teal header
    const Color bgBeige = Color(0xFFFFFCE4); // Creamy beige background from PNG
    const Color cardBg = Color(0xFFE8F5E9); // Mint green card background from PNG
    const Color iconContainerBg = Color(0xFFC8E6C9); // Darker mint for icon circle
    const Color textTeal = Color(0xFF0C7A70); // Rich teal for bold letters

    // Fetch the active selected farm from controller
    final activeFarm = FarmerController.instance.selectedFarm;
    final farmName = activeFarm?.name ?? "Ramesh Gowda";

    // Dashboard Items mapped EXACTLY to PNG 1 subtitles
    final List<Map<String, dynamic>> dashboardItems = [
      {
        'title': 'Cattle Monitoring',
        'subtitle': 'Real-time health and location tracking',
        'icon': Icons.pets_rounded,
        'screen': const LiveCattleMonitoringScreen(),
      },
      {
        'title': 'Weight Monitoring',
        'subtitle': 'Track growth and identify anomalies',
        'icon': Icons.fitness_center_rounded,
        'screen': const WeightMonitoringScreen(),
      },
      {
        'title': 'Cattle Tracking',
        'subtitle': 'Geofencing and pasture movement history',
        'icon': Icons.location_on_rounded,
        'screen': const TrackingScreen(),
      },
      {
        'title': 'Member Monitoring',
        'subtitle': 'Staff activity and task management',
        'icon': Icons.people_alt_rounded,
        'screen': const MemberScreen(),
      },
      {
        'title': 'Milking Monitoring',
        'subtitle': 'Yield statistics and quality metrics',
        'icon': Icons.water_drop_rounded,
        'screen': const MilkMonitoringScreen(),
      },
      {
        'title': 'Vaccine Monitoring',
        'subtitle': 'Schedules, records, and compliance',
        'icon': Icons.vaccines_rounded,
        'screen': const VaccineScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: tealAccent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: ClipOval(
              child: Image.network(
                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=100', // Mock farmer profile matches PNG 1
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: Colors.white);
                },
              ),
            ),
          ),
        ),
        title: const Text(
          'Cattle Monitoring System',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 0.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlertsScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hello welcome details exactly matching font hierarchy and alignment of PNG 1
              const Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                farmName,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: textTeal, // Exact large bold teal font
                  height: 1.15,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 24),

              // 6 exact cards replica in a grid
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14.0,
                    mainAxisSpacing: 14.0,
                    childAspectRatio: 0.76, // Perfectly proportioned rectangular cards matching PNG 1
                  ),
                  itemCount: dashboardItems.length,
                  itemBuilder: (context, index) {
                    final item = dashboardItems[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => item['screen']),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: const Color(0xFFCBE9CE), // Soft light-green border
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha((0.03 * 255).round()),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Accent backdropped Icon at the top-left
                            Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: iconContainerBg,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Center(
                                child: Icon(
                                  item['icon']!,
                                  size: 24,
                                  color: textTeal,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 16),

                            // Column for titles and descriptions
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                      height: 1.25,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item['subtitle']!,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      height: 1.3,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom-Right FAB holding the smart toy assistant face representing the robot bot icon in PNG 1
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Launching Kisan AI Assistant..."),
              backgroundColor: tealAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: tealAccent,
        shape: const CircleBorder(),
        elevation: 6,
        child: const Icon(
          Icons.smart_toy_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
