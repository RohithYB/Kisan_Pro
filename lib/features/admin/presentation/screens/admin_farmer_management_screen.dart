import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'admin_cattle_monitoring_screen.dart';
import 'admin_stock_inventory_screen.dart';
import 'admin_shell_screen.dart';
import '../widgets/admin_farmer_profile_dialog.dart';

class AdminFarmerManagementScreen extends StatefulWidget {
  const AdminFarmerManagementScreen({super.key});

  @override
  State<AdminFarmerManagementScreen> createState() => _AdminFarmerManagementScreenState();
}

class _AdminFarmerManagementScreenState extends State<AdminFarmerManagementScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color bgSlate = Color(0xFFF7F9FC);

    // List of farmers matching the raw_3.png mockup details
    final List<Map<String, dynamic>> farmers = [
      {
        "name": "Suresh Gowda",
        "id": "FRM-2045",
        "location": "Kolar, Karnataka",
        "joined": "Joined: 12 July 2026",
        "avatarUrl": "https://images.unsplash.com/photo-1566492031773-4f4e44671857?auto=format&fit=crop&q=80&w=150",
        "alertText": "CATTLE ALERT",
        "alertColor": Colors.redAccent,
        "alertBg": AppColors.dangerBg,
        "totalCattle": 24,
        "inventoryItems": 42,
      },
      {
        "name": "Lakshmi Hegde",
        "id": "FRM-1982",
        "location": "Mandya, Karnataka",
        "joined": "Joined: 04 Jan 2026",
        "avatarUrl": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=150",
        "alertText": "STEADY",
        "alertColor": AppColors.infoBlue,
        "alertBg": AppColors.infoBg,
        "totalCattle": 15,
        "inventoryItems": 120,
      }
    ];

    // Filter farmers based on query
    final filteredFarmers = farmers.where((f) {
      final name = f["name"].toString().toLowerCase();
      final id = f["id"].toString().toLowerCase();
      final q = _searchQuery.toLowerCase();
      return name.contains(q) || id.contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: bgSlate,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Custom Top App Bar matching raw_3.png Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: primaryPurple),
                    onPressed: () {
                      // Navigate back to the Dashboard
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminShellScreen(initialTab: 0),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Farmer Management',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryPurple,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Monitor registered farmers',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.borderLight),

            // 2. Scrollable Body
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                children: [
                  // 2a. Search bar text field
                  TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textTertiary),
                      hintText: 'Search farmer name or ID',
                      hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 14),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: Colors.black.withAlpha((0.05 * 255).round()),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: const BorderSide(color: primaryPurple, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2b. Total Farmers indicator card
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.black.withAlpha((0.04 * 255).round()),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Farmers',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '1,248',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: primaryPurple,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.trending_up_rounded, color: Color(0xFF0C845E), size: 16),
                            SizedBox(width: 6),
                            Text(
                              '12% from last month',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF0C845E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 2c. Farmer cards
                  if (filteredFarmers.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Text(
                          "No farmers found matching your search",
                          style: TextStyle(color: AppColors.textTertiary, fontSize: 14),
                        ),
                      ),
                    )
                  else
                    ...filteredFarmers.map((farmer) {
                      return _buildFarmerCard(context, farmer);
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerCard(BuildContext context, Map<String, dynamic> farmer) {
    const Color primaryPurple = AppColors.primaryPurple;

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.black.withAlpha((0.04 * 255).round()),
        ),
      ),
      child: Column(
        children: [
          // Top section holding avatar details and verified/alert badge
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar with purple check badge overlap
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.borderLight,
                      backgroundImage: NetworkImage(farmer["avatarUrl"]),
                      onBackgroundImageError: (_, __) {},
                      child: const Icon(Icons.person, size: 36, color: AppColors.textTertiary),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryPurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dismiss',
                                transitionDuration: const Duration(milliseconds: 300),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return AdminFarmerProfileDialog(farmer: farmer);
                                },
                              );
                            },
                            child: Text(
                              farmer["name"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: farmer["alertBg"],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              farmer["alertText"],
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: farmer["alertColor"],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${farmer["id"]} • ${farmer["location"]}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        farmer["joined"],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Total Cattle and Stock Items pills
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildStatPill(Icons.pets_rounded, "Total Cattle: ${farmer["totalCattle"]}"),
                const SizedBox(height: 8),
                _buildStatPill(Icons.inventory_2_outlined, "Inventory Items: ${farmer["inventoryItems"]}"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bottom actions buttons container
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              children: [
                // Cattle Monitoring outline button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryPurple,
                        side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to specific cattle monitoring details screen!
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminCattleMonitoringScreen(
                              farmerName: farmer["name"],
                              farmerId: farmer["id"],
                              location: farmer["location"],
                              joined: farmer["joined"],
                              avatarUrl: farmer["avatarUrl"],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Cattle Monitoring',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Stock Inventory solid button
                Expanded(
                  child: SizedBox(
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
                        // Open farmer's Stock Inventory Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminStockInventoryScreen(
                              farmerName: farmer["name"],
                              farmerId: farmer["id"],
                              location: farmer["location"],
                              avatarUrl: farmer["avatarUrl"],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Stock Inventory',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(IconData icon, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryPurple, size: 16),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

