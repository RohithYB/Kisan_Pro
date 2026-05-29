import 'package:flutter/material.dart';
import 'add_vehicle_screen.dart';
import 'truck_monitoring_screen.dart';
import 'fleet_requests_screen.dart';
import 'fleet_profile_screen.dart';

class FleetDashboardScreen extends StatefulWidget {
  const FleetDashboardScreen({super.key});

  @override
  State<FleetDashboardScreen> createState() => _FleetDashboardScreenState();
}

class _FleetDashboardScreenState extends State<FleetDashboardScreen> {
  final Color fleetBlue = const Color(0xFF2B5B9A);
  final Color bgBeige = const Color(0xFFFFFCE4);

  final List<Map<String, dynamic>> vehicles = [
    {
      "name": "Vehicle 1",
      "id": "Vehicle110",
      "location": "Devanahalli",
      "status": "Active",
      "statusColor": const Color(0xFF32D74B),
      "image": "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=200", // placeholder for driver
    },
    {
      "name": "Vehicle 2",
      "id": "Vehicle110",
      "location": "Devanahalli",
      "status": "Idle",
      "statusColor": const Color(0xFFFF9F0A),
      "image": "https://images.unsplash.com/photo-1620574387735-3624d75b2dbc?w=200", // placeholder
    },
    {
      "name": "Vehicle 3",
      "id": "Vehicle110",
      "location": "Devanahalli",
      "status": "Active",
      "statusColor": const Color(0xFF32D74B),
      "image": "https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=200", // placeholder
    },
    {
      "name": "Vehicle 4",
      "id": "Vehicle110",
      "location": "Devanahalli",
      "status": "Active",
      "statusColor": const Color(0xFF32D74B),
      "image": "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=200", // placeholder
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: fleetBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FleetProfileScreen()));
          },
        ),
        title: const Text('Vehicles', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FleetRequestsScreen()));
                },
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Select Vehicle',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final v = vehicles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TruckMonitoringScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: fleetBlue,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Circular Image
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(v['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(v['name'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(v['id'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            Text(v['location'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 8),
                            // Status badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                color: v['statusColor'],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(v['status'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                            const Spacer(),
                            // Buttons
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: fleetBlue,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Edit Vehicle', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFC72828),
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Delete Vehicle', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                                    ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: fleetBlue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddVehicleScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
