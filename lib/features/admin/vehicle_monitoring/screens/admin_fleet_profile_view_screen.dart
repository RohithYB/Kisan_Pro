import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class AdminFleetProfileViewScreen extends StatelessWidget {
  final String ownerName;
  final String ownerId;

  const AdminFleetProfileViewScreen({
    super.key,
    required this.ownerName,
    required this.ownerId,
  });

  final Color primaryColor = AppColors.secondaryPurple;
  final Color bgBeige = AppColors.bgSlate; // Admin theme background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Fleet Owner Profile',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar Section
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10)],
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(ownerName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 4),
                    Text("Fleet ID: $ownerId • Premium Member", style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Personal Info Card
              _buildInfoCard(
                title: 'Personal Info',
                icon: Icons.person_outline,
                children: [
                  _buildDisplayField(label: 'Full Name', value: ownerName, icon: Icons.badge_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Email Address', value: "contact@${ownerName.replaceAll(' ', '').toLowerCase()}.com", icon: Icons.email_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Mobile Number', value: "+91 98765 43210", icon: Icons.phone_outlined),
                ],
              ),
              const SizedBox(height: 24),

              // Fleet Info Card
              _buildInfoCard(
                title: 'Fleet Info',
                icon: Icons.business_outlined,
                children: [
                  _buildDisplayField(label: 'Company Name', value: ownerName, icon: Icons.domain),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Base City / Location', value: "Bangalore, Karnataka", icon: Icons.location_on_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Fleet Size', value: "11-50 Vehicles", icon: Icons.local_shipping_outlined),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDisplayField({required String label, required String value, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8.0),
            color: AppColors.bgSlate,
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(icon, color: AppColors.textSecondary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

