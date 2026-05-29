import 'package:flutter/material.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../core/constants/colors.dart';
import '../../presentation/screens/admin_customer_details_screen.dart'; // Old path for now

class BusinessCard extends StatelessWidget {
  final CustomerModel customer;

  const BusinessCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    Color statusColor = AppColors.successGreen;
    Color statusBg = AppColors.successBg;
    if (customer.status.toUpperCase() == "IDLE") {
      statusColor = const Color(0xFF475569);
      statusBg = AppColors.borderLight;
    }

    Color tierColor = const Color(0xFF64748B);
    Color tierBg = AppColors.surfaceLight;
    if (customer.tier.toUpperCase() == "HIGH VOLUME") {
      tierColor = AppColors.primaryPurple;
      tierBg = const Color(0xFFE0E0FF);
    }

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
                  customerId: customer.id,
                  customerName: customer.businessName,
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
                      Row(
                        children: [
                          Text(
                            customer.id,
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
                              color: statusBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              customer.status,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: statusColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      Text(
                        customer.businessName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1549),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(Icons.shopping_cart_outlined, color: AppColors.textTertiary, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            "Total Orders: ${customer.totalOrders}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: tierBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          customer.tier,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: tierColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer.desc,
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

                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primaryPurple,
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

