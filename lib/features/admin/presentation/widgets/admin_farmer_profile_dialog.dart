import 'dart:ui';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AdminFarmerProfileDialog extends StatelessWidget {
  final Map<String, dynamic> farmer;

  const AdminFarmerProfileDialog({super.key, required this.farmer});

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
                          "Farmer Profile",
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.borderLight,
                          backgroundImage: NetworkImage(farmer["avatarUrl"]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        farmer["name"],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${farmer["id"]} • ${farmer["location"]}",
                        style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    const Text(
                      'Personal Information',
                      style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Full Name', farmer["name"], Icons.person_outline, primaryColor),
                    const SizedBox(height: 12),
                    _buildInfoRow('Mobile Number', '+91 9876543210', Icons.phone_outlined, primaryColor),
                    const SizedBox(height: 12),
                    _buildInfoRow('Gender', 'Male', Icons.wc_outlined, primaryColor),
                    const SizedBox(height: 12),
                    _buildInfoRow('Email Address', '${farmer["name"].toString().split(" ").first.toLowerCase()}@gmail.com', Icons.email_outlined, primaryColor),
                    const SizedBox(height: 12),
                    _buildInfoRow('Joined', farmer["joined"], Icons.calendar_today_outlined, primaryColor),
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

