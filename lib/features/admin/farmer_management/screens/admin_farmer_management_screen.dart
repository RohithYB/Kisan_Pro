import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../admin_shell/screens/admin_shell_screen.dart';
import '../controller/farmer_management_controller.dart';
import '../widgets/farmer_card.dart';

class AdminFarmerManagementScreen extends StatefulWidget {
  const AdminFarmerManagementScreen({super.key});

  @override
  State<AdminFarmerManagementScreen> createState() =>
      _AdminFarmerManagementScreenState();
}

class _AdminFarmerManagementScreenState
    extends State<AdminFarmerManagementScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FarmerManagementController()..loadFarmers(),
      child: Consumer<FarmerManagementController>(
        builder: (context, controller, child) {
          final filteredFarmers = controller.filteredFarmers;

          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            body: SafeArea(
              child: Column(
                children: [
                  // 1. Custom Top App Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.primaryPurple,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AdminShellScreen(initialTab: 0),
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
                                  color: AppColors.primaryPurple,
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
                          icon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),

                  // 2. Scrollable Body
                  Expanded(
                    child: controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(20.0),
                            children: [
                              // 2a. Search bar text field
                              TextField(
                                controller: _searchController,
                                onChanged: (val) {
                                  controller.search(val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search_rounded,
                                    color: AppColors.textTertiary,
                                  ),
                                  hintText: 'Search farmer name or ID',
                                  hintStyle: const TextStyle(
                                    color: AppColors.textTertiary,
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: BorderSide(
                                      color: Colors.black.withAlpha(
                                        (0.05 * 255).round(),
                                      ),
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: const BorderSide(
                                      color: AppColors.primaryPurple,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // 2b. Total Farmers indicator card
                              _buildTotalFarmersCard(),
                              const SizedBox(height: 28),

                              // 2c. Farmer cards
                              if (filteredFarmers.isEmpty)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 40.0,
                                    ),
                                    child: Text(
                                      "No farmers found matching your search",
                                      style: TextStyle(
                                        color: AppColors.textTertiary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                ...filteredFarmers.map((farmer) {
                                  return FarmerCard(farmer: farmer);
                                }),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalFarmersCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black.withAlpha((0.04 * 255).round())),
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
              color: AppColors.primaryPurple,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(
                Icons.trending_up_rounded,
                color: Color(0xFF0C845E),
                size: 16,
              ),
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
    );
  }
}
