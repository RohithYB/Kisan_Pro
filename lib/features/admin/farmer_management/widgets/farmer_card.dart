import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/data/models/farmer_model.dart';

import '../../../../core/constants/colors.dart';
import '../../presentation/screens/admin_cattle_monitoring_screen.dart'; // From old path for now
import '../../presentation/screens/admin_stock_inventory_screen.dart'; // From old path for now
import '../screens/admin_farmer_profile_view_screen.dart';

class FarmerCard extends StatelessWidget {
  final FarmerModel farmer;

  const FarmerCard({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    // Determine colors based on alertStatus
    Color alertColor = AppColors.infoBlue;
    Color alertBg = AppColors.infoBg;
    String alertText = "STEADY";

    if (farmer.alertStatus.toUpperCase().contains("ALERT")) {
      alertColor = Colors.redAccent;
      alertBg = AppColors.dangerBg;
      alertText = farmer.alertStatus.toUpperCase();
    } else {
      alertText = farmer.alertStatus.toUpperCase();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.black.withAlpha((0.04 * 255).round())),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.borderLight,
                      backgroundImage: NetworkImage(farmer.avatarUrl),
                      onBackgroundImageError: (_, __) {},
                      child: farmer.avatarUrl.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 36,
                              color: AppColors.textTertiary,
                            )
                          : null,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AdminFarmerProfileViewScreen(
                                          farmer: {
                                            "name": farmer.name,
                                            "id": farmer.id,
                                            "location": farmer.location,
                                            "joined": farmer.joinedDate,
                                            "avatarUrl": farmer.avatarUrl,
                                            "totalCattle": farmer.totalCattle,
                                            "inventoryItems":
                                                farmer.inventoryItems,
                                          },
                                        ),
                                  ),
                                );
                              },
                              child: Text(
                                farmer.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: alertBg,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              alertText,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: alertColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${farmer.id} • ${farmer.location}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        farmer.joinedDate,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildStatPill(
                  Icons.pets_rounded,
                  "Total Cattle: ${farmer.totalCattle}",
                ),
                const SizedBox(height: 8),
                _buildStatPill(
                  Icons.inventory_2_outlined,
                  "Inventory Items: ${farmer.inventoryItems}",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryPurple,
                        side: const BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminCattleMonitoringScreen(
                              farmerName: farmer.name,
                              farmerId: farmer.id,
                              location: farmer.location,
                              joined: farmer.joinedDate,
                              avatarUrl: farmer.avatarUrl,
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
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminStockInventoryScreen(
                              farmerName: farmer.name,
                              farmerId: farmer.id,
                              location: farmer.location,
                              avatarUrl: farmer.avatarUrl,
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
