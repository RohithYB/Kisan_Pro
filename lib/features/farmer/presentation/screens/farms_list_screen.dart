import 'package:flutter/material.dart';

import '../../../../data/models/farm_model.dart';
import '../controller/farmer_controller.dart';
import 'farm_setup_screen.dart';
import 'farmer_dashboard.dart';

class FarmsListScreen extends StatefulWidget {
  const FarmsListScreen({super.key});

  @override
  State<FarmsListScreen> createState() => _FarmsListScreenState();
}

class _FarmsListScreenState extends State<FarmsListScreen> {
  @override
  Widget build(BuildContext context) {
    const Color tealHeader = Color(0xFF0C7A70); // Dark teal from PNG header
    const Color bgBeige = Color(0xFFFFFCE4); // Pale beige backdrop from PNG

    final List<FarmModel> activeFarms = FarmerController.instance.farms;

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Farms',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealHeader,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Core landing dashboard
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mockup title: Select Farm
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0, left: 4.0),
                child: Text(
                  'Select Farm',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // Responsive grid of farm profile cards
              Expanded(
                child: activeFarms.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24.0),
                              decoration: BoxDecoration(
                                color: tealHeader.withAlpha(
                                  (0.1 * 255).round(),
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.agriculture_rounded,
                                size: 80,
                                color: tealHeader,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              "No Farms Registered Yet",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(
                                "Your farm directory is currently empty. Tap the '+' button below to set up your first farm!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14.0,
                              mainAxisSpacing: 14.0,
                              childAspectRatio:
                                  0.70, // Room for details and edit pill button
                            ),
                        itemCount: activeFarms.length,
                        itemBuilder: (context, index) {
                          final farm = activeFarms[index];

                          return GestureDetector(
                            onTap: () {
                              // Save state profile selection
                              FarmerController.instance.selectFarm(farm.id);

                              // Navigate to the core farmer dashboard submodules
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FarmerDashboard(),
                                ),
                              ).then(
                                (_) => setState(() {}),
                              ); // Re-render when popping back to list
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: tealHeader, // Teal background requested
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(
                                      (0.15 * 255).round(),
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 16.0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Top Circular visual avatar
                                  Container(
                                    width: 76,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white70,
                                        width: 2,
                                      ),
                                    ),
                                    child: const ClipOval(
                                      child: Icon(
                                        Icons.agriculture_rounded,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // Core Farm Labels
                                  Column(
                                    children: [
                                      Text(
                                        farm.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        farm.id.startsWith('Farm110-')
                                            ? 'Farm110'
                                            : 'Farm_${farm.name.hashCode.abs() % 1000}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${farm.cattleCount} cattles",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        farm.location,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Bottom Pill White Button: Edit Farm (Redirects to Setup Screen in edit mode)
                                  SizedBox(
                                    width: double.infinity,
                                    height: 36,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: tealHeader,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FarmSetupScreen(
                                                  farmToEdit: farm,
                                                ),
                                          ),
                                        ).then(
                                          (_) => setState(() {}),
                                        ); // Re-render when popping back to list
                                      },
                                      child: const Text(
                                        'Edit Farm',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
      // Floating dynamic + Add button on the bottom of the farms page routing back to setup
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FarmSetupScreen()),
          ).then((_) => setState(() {})); // Re-render when returning
        },
        backgroundColor: tealHeader,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }
}
