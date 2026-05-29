import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../controller/customer_details_controller.dart';
import '../widgets/customer_metric_card.dart';
import '../widgets/completion_rate_card.dart';
import '../widgets/customer_details_widgets.dart';
import '../widgets/customer_history_widgets.dart';

class AdminCustomerDetailsScreen extends StatelessWidget {
  final String customerId;
  final String customerName;

  const AdminCustomerDetailsScreen({
    super.key,
    this.customerId = "CUST-8821",
    this.customerName = "Grand Palace Hotel",
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomerDetailsController()..loadCustomerDetails(customerId),
      child: Consumer<CustomerDetailsController>(
        builder: (context, controller, child) {
          final customer = controller.customer;

          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryPurple),
                onPressed: () => Navigator.pop(context),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Customer Details",
                    style: TextStyle(
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    customerId,
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
            ),
            body: controller.isLoading || customer == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Business Profile Overview Card
                          BusinessProfileCard(customer: customer),
                          const SizedBox(height: 16),

                          // 2. Metrics Cards
                          CustomerMetricCard(
                            title: "Total Orders",
                            value: customer.totalOrders,
                            subtitle: "↗ +12% vs last month",
                            subtitleColor: const Color(0xFF0369A1),
                          ),
                          const SizedBox(height: 16),
                          CustomerMetricCard(
                            title: "Active Deliveries",
                            value: customer.activeDeliveries.toString().padLeft(2, '0'),
                            subtitle: "In transit",
                            subtitleColor: Colors.black45,
                          ),
                          const SizedBox(height: 16),
                          CompletionRateCard(
                            primaryColor: AppColors.primaryPurple,
                            rate: customer.completionRate,
                          ),
                          const SizedBox(height: 24),

                          // 3. Active Deliveries Section
                          _buildSectionHeader(Icons.local_shipping_outlined, "Active Deliveries"),
                          const SizedBox(height: 12),
                          const ActiveDeliveriesCard(),
                          const SizedBox(height: 24),

                          // 4. Preferred Farmers Section
                          _buildSectionHeader(Icons.agriculture_rounded, "Preferred Farmers"),
                          const SizedBox(height: 12),
                          const PreferredFarmersCard(),
                          const SizedBox(height: 24),

                          // 5. Recent Complaints Section
                          _buildSectionHeader(Icons.warning_amber_rounded, "Recent Complaints"),
                          const SizedBox(height: 12),
                          const RecentComplaintsCard(),
                          const SizedBox(height: 24),

                          // 6. Activity History Section
                          _buildSectionHeader(Icons.history_rounded, "Activity History"),
                          const SizedBox(height: 12),
                          const ActivityHistoryCard(primaryColor: AppColors.primaryPurple),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textNavy, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textNavy,
          ),
        ),
      ],
    );
  }
}

