import 'dart:ui';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AdminCustomerProfileDialog extends StatelessWidget {
  final String customerName;
  final String customerId;

  const AdminCustomerProfileDialog({
    super.key,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = AppColors.secondaryPurple;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: Colors.black.withValues(alpha: 0.3)),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20)
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Business Profile",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textSecondary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 2),
                          image: const DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=200"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        customerName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor, height: 1.2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Center(
                      child: Text('Wholesale Vegetable Retailer', style: TextStyle(fontSize: 14, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                          SizedBox(width: 4),
                          Text('KR Market, Bengaluru', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBadge('Member Since 2021', AppColors.borderLight, primaryColor),
                        const SizedBox(width: 8),
                        _buildBadge('ID: $customerId', AppColors.borderLight, primaryColor),
                      ],
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Business Information',
                      style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('PRIMARY CONTACT', 'Ramesh Gowda', Icons.person_outline, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('MOBILE NUMBER', '+91 9876543210', Icons.phone_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('EMAIL ADDRESS', 'orders@domain.com', Icons.email_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('BUSINESS CATEGORY', 'Vegetables & Farm Produce', Icons.category_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('WAREHOUSE CAPACITY', '12 Tons', Icons.warehouse_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('REGISTRATION NUMBER', 'REG-456721', Icons.assignment_outlined, primaryColor),
                    const SizedBox(height: 24),

                    const Text(
                      'GST & Billing Information',
                      style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('GST IDENTIFICATION NUMBER', '29ABCDE1234F1Z5', Icons.receipt_long_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('BILLING STATUS', 'GST Billing Enabled', Icons.account_balance_wallet_outlined, primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, color: Colors.black45, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

