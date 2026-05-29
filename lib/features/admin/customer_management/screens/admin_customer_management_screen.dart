import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../controller/customer_management_controller.dart';
import '../widgets/business_card.dart';

class AdminCustomerManagementScreen extends StatefulWidget {
  const AdminCustomerManagementScreen({super.key});

  @override
  State<AdminCustomerManagementScreen> createState() => _AdminCustomerManagementScreenState();
}

class _AdminCustomerManagementScreenState extends State<AdminCustomerManagementScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomerManagementController()..loadCustomers(),
      child: Consumer<CustomerManagementController>(
        builder: (context, controller, child) {
          final filteredCustomers = controller.filteredCustomers;

          return Scaffold(
            backgroundColor: AppColors.bgSlate,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Title
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: const Text(
                      "Customer Management",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),

                  Expanded(
                    child: controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(20.0),
                            children: [
                              // 1. Search Bar
                              TextField(
                                controller: _searchController,
                                onChanged: (val) {
                                  controller.search(val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textTertiary),
                                  hintText: 'Search business by name or ID...',
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
                                    borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // 2. Business Users Cards List
                              if (filteredCustomers.isEmpty)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40.0),
                                    child: Text(
                                      "No business users found",
                                      style: TextStyle(color: AppColors.textTertiary, fontSize: 14),
                                    ),
                                  ),
                                )
                              else
                                ...filteredCustomers.map((cust) => BusinessCard(customer: cust)),
                              const SizedBox(height: 16),
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
}

