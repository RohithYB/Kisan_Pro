import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'admin_customer_details_screen.dart';

class AdminCustomerManagementScreen extends StatefulWidget {
  const AdminCustomerManagementScreen({super.key});

  @override
  State<AdminCustomerManagementScreen> createState() => _AdminCustomerManagementScreenState();
}

class _AdminCustomerManagementScreenState extends State<AdminCustomerManagementScreen> {
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
    const Color bgSlate = AppColors.bgSlate;
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;
    const Color greyText = Color(0xFF64748B);
    const Color greyBg = AppColors.surfaceLight;

    // Business users registry matching raw_4.png
    final List<Map<String, dynamic>> customers = [
      {
        "name": "Grand Palace Hotel",
        "id": "CUST-8821",
        "status": "ACTIVE",
        "statusColor": greenText,
        "statusBg": greenBg,
        "totalOrders": 142,
        "tier": "HIGH VOLUME",
        "tierColor": primaryPurple,
        "tierBg": const Color(0xFFE0E0FF),
        "desc": "Consistently above average",
      },
      {
        "name": "Fresh Mart Supermarket",
        "id": "CUST-8902",
        "status": "ACTIVE",
        "statusColor": greenText,
        "statusBg": greenBg,
        "totalOrders": 98,
        "tier": "STANDARD VOLUME",
        "tierColor": greyText,
        "tierBg": greyBg,
        "desc": "Regular buying pattern",
      },
      {
        "name": "Green Leaf Restaurant",
        "id": "CUST-7211",
        "status": "IDLE",
        "statusColor": const Color(0xFF475569),
        "statusBg": AppColors.borderLight,
        "totalOrders": 24,
        "tier": "STANDARD VOLUME",
        "tierColor": greyText,
        "tierBg": greyBg,
        "desc": "Inactive for 14 days",
      },
      {
        "name": "Veggie World Wholesale",
        "id": "CUST-6610",
        "status": "ACTIVE",
        "statusColor": greenText,
        "statusBg": greenBg,
        "totalOrders": 312,
        "tier": "HIGH VOLUME",
        "tierColor": primaryPurple,
        "tierBg": const Color(0xFFE0E0FF),
        "desc": "Daily high-frequency buyer",
      },
      {
        "name": "Blue Diamond Resorts",
        "id": "CUST-9104",
        "status": "ACTIVE",
        "statusColor": greenText,
        "statusBg": greenBg,
        "totalOrders": 56,
        "tier": "HIGH VOLUME",
        "tierColor": primaryPurple,
        "tierBg": const Color(0xFFE0E0FF),
        "desc": "Premium tier customer",
      },
      {
        "name": "Quick Bite Food Chain",
        "id": "CUST-5529",
        "status": "ACTIVE",
        "statusColor": greenText,
        "statusBg": greenBg,
        "totalOrders": 215,
        "tier": "STANDARD VOLUME",
        "tierColor": greyText,
        "tierBg": greyBg,
        "desc": "Predictable weekly cycles",
      },
    ];

    // Filter customers list
    final filteredCustomers = customers.where((c) {
      final name = c["name"].toString().toLowerCase();
      final id = c["id"].toString().toLowerCase();
      final q = _searchQuery.toLowerCase();
      return name.contains(q) || id.contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: bgSlate,
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
                  color: primaryPurple,
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.borderLight),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                children: [
                  // 1. Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
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
                        borderSide: const BorderSide(color: primaryPurple, width: 2.0),
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
                    ...filteredCustomers.map((cust) => _buildBusinessCard(context, cust)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessCard(BuildContext context, Map<String, dynamic> cust) {
    const Color primaryPurple = AppColors.primaryPurple;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminCustomerDetailsScreen(
                  customerId: cust["id"],
                  customerName: cust["name"],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID and Status badge row
                      Row(
                        children: [
                          Text(
                            cust["id"],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: cust["statusBg"],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              cust["status"],
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: cust["statusColor"],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Business/Shop Name
                      Text(
                        cust["name"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1549), // Dark purple/navy
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Orders count with shopping cart icon
                      Row(
                        children: [
                          const Icon(Icons.shopping_cart_outlined, color: AppColors.textTertiary, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            "Total Orders: ${cust["totalOrders"]}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Tier Volume badge & subtext
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: cust["tierBg"],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          cust["tier"],
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: cust["tierColor"],
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cust["desc"],
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Arrow icon button
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: primaryPurple,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

