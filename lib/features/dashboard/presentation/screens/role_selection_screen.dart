import 'package:flutter/material.dart';
import '../../../../features/farmer/presentation/screens/farms_list_screen.dart';
import '../../../../features/farmer/presentation/screens/add_stock_item_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color orangeAccent = Color(0xFFEF9741);
    const Color bgBeige = Color(0xFFFFFCE4); // Premium light beige from mockup
    const Color tealAccent = Color(0xFF0C7A70); // Deep teal from mockup
    const Color navyAccent = Color(0xFF1F3E5A); // Dark navy from mockup

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Roles',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: orangeAccent, // Orange header requested
        elevation: 0,
        automaticallyImplyLeading: false, // Onboarding start
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mockup title: Choose your Role in Farmer
              const Text(
                'Choose your Role in\nFarmer',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.25,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 36),

              // Side-by-Side Role Cards
              Row(
                children: [
                  // 1. Cattle Monitoring Card (Teal Accent)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FarmsListScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 190,
                        decoration: BoxDecoration(
                          color: tealAccent,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha((0.1 * 255).round()),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // White Cow Drawing (Dynamic paint or custom vector icon wrapper)
                              Icon(
                                Icons.pets_rounded, // Cattle shape representation
                                size: 54,
                                color: Colors.white,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Cattle\nMonitoring",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 2. Stock Inventory Management Card (Navy Blue)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddStockItemScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 190,
                        decoration: BoxDecoration(
                          color: navyAccent,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha((0.1 * 255).round()),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Stacked boxes illustration representation
                              Icon(
                                Icons.inventory_2_rounded,
                                size: 54,
                                color: Colors.white,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Stock Inventory\nManagement",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
