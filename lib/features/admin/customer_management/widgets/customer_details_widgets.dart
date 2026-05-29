import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../data/models/customer_model.dart';
import '../../presentation/widgets/admin_customer_profile_dialog.dart'; // old path for now

class BusinessProfileCard extends StatelessWidget {
  final CustomerModel customer;

  const BusinessProfileCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(customer.avatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Dismiss',
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AdminCustomerProfileDialog(
                      customerName: customer.businessName,
                      customerId: customer.id,
                    );
                  },
                );
              },
              child: Text(
                customer.businessName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textNavy,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                customer.category,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: AppColors.surfaceLight),
            const SizedBox(height: 20),
            _buildContactRow(Icons.location_on_outlined, customer.location),
            const SizedBox(height: 12),
            _buildContactRow(Icons.phone_outlined, "+91 98765 43210"),
            const SizedBox(height: 12),
            _buildContactRow(
              Icons.mail_outline_rounded,
              "ops@${customer.businessName.toLowerCase().replaceAll(' ', '')}.com",
            ),
            const SizedBox(height: 12),
            _buildContactRow(
              Icons.calendar_today_outlined,
              "Partner since 2021",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6366F1), size: 18),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class ActiveDeliveriesCard extends StatelessWidget {
  const ActiveDeliveriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDeliveryItem(
            orderNo: "Order #PRO-9022",
            fleet: "Fleet: BLR-KISA-12",
            status: "Out for Delivery",
            statusBg: AppColors.dangerBg,
            statusTextColor: AppColors.dangerRed,
            eta: "ETA: 11:45 AM",
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(height: 1, color: AppColors.surfaceLight),
          ),
          _buildDeliveryItem(
            orderNo: "Order #PRO-9104",
            fleet: "Fleet: BLR-KISA-08",
            status: "Processing",
            statusBg: AppColors.surfaceLight,
            statusTextColor: const Color(0xFF64748B),
            eta: "ETA: 02:30 PM",
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem({
    required String orderNo,
    required String fleet,
    required String status,
    required Color statusBg,
    required Color statusTextColor,
    required String eta,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.store_rounded,
              color: Color(0xFF3B82F6),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderNo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  fleet,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: statusTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                eta,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PreferredFarmersCard extends StatelessWidget {
  const PreferredFarmersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFarmerItem(
            name: "Suresh Gowda",
            supply: "Supplied: 1,240kg (This Month)",
            imageUrl:
                "https://images.unsplash.com/photo-1595273670150-bd0c3c392e46?auto=format&fit=crop&q=80&w=150",
          ),
          const SizedBox(height: 12),
          _buildFarmerItem(
            name: "Ramesh Kumar",
            supply: "Supplied: 890kg (This Month)",
            imageUrl:
                "https://images.unsplash.com/photo-1592949837753-4e66c90c74cf?auto=format&fit=crop&q=80&w=150",
          ),
          const SizedBox(height: 12),
          _buildFarmerItem(
            name: "Meena Devi",
            supply: "Supplied: 450kg (This Month)",
            imageUrl:
                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=150",
          ),
        ],
      ),
    );
  }

  Widget _buildFarmerItem({
    required String name,
    required String supply,
    required String imageUrl,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.borderLight,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textNavy,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                supply,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.star_border_rounded,
          color: Color(0xFF6366F1),
          size: 22,
        ),
      ],
    );
  }
}
