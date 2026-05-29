import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/timeline_row.dart';
import '../controller/stock_inventory_controller.dart';
import '../widgets/inventory_item_card.dart';

class AdminStockInventoryScreen extends StatelessWidget {
  final String farmerName;
  final String farmerId;
  final String location;
  final String avatarUrl;

  const AdminStockInventoryScreen({
    super.key,
    this.farmerName = "Suresh Gowda",
    this.farmerId = "FRM-2045",
    this.location = "Karnataka, IN",
    this.avatarUrl = "",
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StockInventoryController()..loadInventoryData(farmerId),
      child: Consumer<StockInventoryController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryPurple),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Stock Inventory",
                style: TextStyle(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
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
                    // 1. Farmer Profile Card
                    _buildFarmerProfileCard(controller),
                    const SizedBox(height: 16),

                    // 2. 2x2 Stats Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _buildStatGridItem(Icons.inventory_2_outlined, controller.totalUnits, "Total Items", AppColors.primaryPurple),
                        _buildStatGridItem(Icons.check_circle_outline, controller.healthyCount, "Healthy", AppColors.successGreen),
                        _buildStatGridItem(Icons.bug_report_outlined, controller.pestAlertsCount, "Pest Alerts", const Color(0xFFDC2626)),
                        _buildStatGridItem(Icons.calendar_today_outlined, controller.expiringSoonCount, "Expiring Soon", Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 3. Inventory Monitoring Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Inventory Monitoring",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // 4. Tomato Item Card
                    const InventoryItemCard(
                      title: "Fresh Tomatoes",
                      badgeText: "PEST DETECTED",
                      badgeBgColor: AppColors.dangerBg,
                      badgeTextColor: Color(0xFFDC2626),
                      weight: "650 KG",
                      price: "₹26/KG",
                      invCode: "INV-204 • Added 10 July 2026",
                      expiry: "Exp: 18 July",
                      location: "Cold Storage A",
                      imageUrl: "https://images.unsplash.com/photo-1595855759920-86582396756a?auto=format&fit=crop&q=80&w=150",
                      warningText: "Pest detected in tomato inventory. Quarantine recommended.",
                      warningColor: Color(0xFFDC2626),
                      warningBg: AppColors.dangerBg,
                    ),
                    const SizedBox(height: 16),

                    // 5. Potato Item Card
                    const InventoryItemCard(
                      title: "Potatoes",
                      badgeText: "LOW STOCK",
                      badgeBgColor: AppColors.warningBg,
                      badgeTextColor: AppColors.warningOrange,
                      weight: "1200 KG",
                      price: "₹18/KG",
                      invCode: "INV-205 • Added 08 July 2026",
                      expiry: "Exp: 30 Aug",
                      location: "Warehouse B",
                      imageUrl: "https://images.unsplash.com/photo-1518977676601-b53f82aba655?auto=format&fit=crop&q=80&w=150",
                      warningText: "Inventory stock critically low. Restock required immediately.",
                      warningColor: AppColors.warningOrange,
                      warningBg: AppColors.warningBg,
                    ),
                    const SizedBox(height: 24),

                    // 6. Recent Inventory Activity
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Recent Inventory Activity",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 16),
                          TimelineRow(
                            title: "Tomato inventory updated",
                            subtitle: "10 Min Ago • Section C-4",
                            dotColor: AppColors.primaryPurple,
                            isFirst: true,
                          ),
                          TimelineRow(
                            title: "Milk stock delivered",
                            subtitle: "25 Min Ago • Gateway 2",
                            dotColor: Colors.blueGrey,
                          ),
                          TimelineRow(
                            title: "Low stock alert triggered",
                            subtitle: "1 Hour Ago • Warehouse B",
                            dotColor: Color(0xFFDC2626),
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFarmerProfileCard(StockInventoryController controller) {
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;
    const Color redText = Color(0xFFDC2626);
    const Color redBg = AppColors.dangerBg;
    const Color orangeText = AppColors.warningOrange;
    const Color orangeBg = AppColors.warningBg;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.03 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE0E0FF),
                backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
                child: avatarUrl.isEmpty
                    ? const Text(
                        "SG",
                        style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Farmer Profile",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      farmerName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "ID: $farmerId • $location",
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "TOTAL\nUNITS",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textTertiary,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.totalUnits,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatusBadge("Healthy (${controller.healthyCount})", greenText, greenBg),
              const SizedBox(width: 8),
              _buildStatusBadge("Pest Alerts (${controller.pestAlertsCount})", redText, redBg),
              const SizedBox(width: 8),
              _buildStatusBadge("Low Stock (${controller.lowStockCount})", orangeText, orangeBg),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatGridItem(IconData icon, String value, String label, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(12.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accentColor, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

