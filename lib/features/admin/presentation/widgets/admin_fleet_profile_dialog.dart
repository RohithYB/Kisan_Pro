import 'dart:ui';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AdminFleetProfileDialog extends StatelessWidget {
  final String ownerName;
  final String ownerId;

  const AdminFleetProfileDialog({
    super.key,
    required this.ownerName,
    required this.ownerId,
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
                          "Fleet Owner Profile",
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
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 3),
                          image: const DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(ownerName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text("$ownerId • Premium Member", style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'Personal Info',
                      style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('Full Name', ownerName, Icons.badge_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('Email Address', 'contact@fleet.com', Icons.email_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('Mobile Number', '+91 98765 43210', Icons.phone_outlined, primaryColor),
                    const SizedBox(height: 24),

                    const Text(
                      'Fleet Info',
                      style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('Company Name', ownerName, Icons.domain, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('Base City / Location', 'Bangalore, Karnataka', Icons.location_on_outlined, primaryColor),
                    const SizedBox(height: 8),
                    _buildInfoRow('Fleet Size', '11-50 Vehicles', Icons.local_shipping_outlined, primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
                Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

