import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class AdminFarmerProfileViewScreen extends StatelessWidget {
  final Map<String, dynamic> farmer;

  const AdminFarmerProfileViewScreen({
    super.key,
    required this.farmer,
  });

  final Color primaryColor = AppColors.secondaryPurple;
  final Color bgBeige = AppColors.bgSlate;

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
          'Farmer Profile',
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
                        image: DecorationImage(
                          image: NetworkImage(farmer['avatarUrl'] ?? ''),
                          fit: BoxFit.cover,
                          onError: (_, __) => const Icon(Icons.person, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(farmer['name'] ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 4),
                    Text("Farmer ID: ${farmer['id']} • Registered on ${farmer['joined']}", style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Personal Info Card
              _buildInfoCard(
                title: 'Personal Info',
                icon: Icons.person_outline,
                children: [
                  _buildDisplayField(label: 'Full Name', value: farmer['name'] ?? '', icon: Icons.badge_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Mobile Number', value: "+91 98765 43210", icon: Icons.phone_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Location', value: farmer['location'] ?? '', icon: Icons.location_on_outlined),
                ],
              ),
              const SizedBox(height: 24),

              // Farm Info Card
              _buildInfoCard(
                title: 'Farm Info',
                icon: Icons.agriculture_outlined,
                children: [
                  _buildDisplayField(label: 'Total Cattle', value: farmer['totalCattle'].toString(), icon: Icons.pets_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Inventory Items', value: farmer['inventoryItems'].toString(), icon: Icons.inventory_2_outlined),
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

