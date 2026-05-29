import 'package:flutter/material.dart';
import 'dart:ui';
import 'fleet_login_screen.dart';

class FleetProfileScreen extends StatefulWidget {
  const FleetProfileScreen({super.key});

  @override
  State<FleetProfileScreen> createState() => _FleetProfileScreenState();
}

class _FleetProfileScreenState extends State<FleetProfileScreen> {
  final Color fleetBlue = const Color(0xFF0C4683); // Darker blue matching the image
  final Color bgBeige = const Color(0xFFFFFCE4);

  // State variables for profile
  String fullName = "Anand Kumar";
  String email = "anand.kumar@transfleet.com";
  String phone = "+91 98765 43210";
  String companyName = "TransFleet Logistics Pvt Ltd";
  String location = "Bangalore, Karnataka";
  String fleetSize = "11-50 Vehicles";

  void _showEditProfileDialog() {
    // Temporary controllers for edit
    final nameCtrl = TextEditingController(text: fullName);
    final emailCtrl = TextEditingController(text: email);
    final phoneCtrl = TextEditingController(text: phone);
    final companyCtrl = TextEditingController(text: companyName);
    final locationCtrl = TextEditingController(text: location);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Blurred Background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(color: Colors.black.withValues(alpha: 0.3)),
              ),
              // Edit Form
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: bgBeige,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        _buildTextField(label: 'Full Name', hint: '', icon: Icons.badge_outlined, controller: nameCtrl),
                        const SizedBox(height: 12),
                        _buildTextField(label: 'Email Address', hint: '', icon: Icons.email_outlined, controller: emailCtrl),
                        const SizedBox(height: 12),
                        _buildTextField(label: 'Mobile Number', hint: '', icon: Icons.phone_outlined, controller: phoneCtrl),
                        const SizedBox(height: 12),
                        _buildTextField(label: 'Company Name', hint: '', icon: Icons.business_outlined, controller: companyCtrl),
                        const SizedBox(height: 12),
                        _buildTextField(label: 'Base City / Location', hint: '', icon: Icons.location_on_outlined, controller: locationCtrl),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: fleetBlue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              setState(() {
                                fullName = nameCtrl.text;
                                email = emailCtrl.text;
                                phone = phoneCtrl.text;
                                companyName = companyCtrl.text;
                                location = locationCtrl.text;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: fleetBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10)],
                            image: const DecorationImage(
                              image: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400'), // professional portrait
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: fleetBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(fullName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: fleetBlue)),
                    const SizedBox(height: 4),
                    const Text("Fleet ID: FL-98234 • Premium Member", style: TextStyle(color: Colors.black54, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Personal Info Card
              _buildInfoCard(
                title: 'Personal Info',
                icon: Icons.person_outline,
                children: [
                  _buildDisplayField(label: 'Full Name', value: fullName, icon: Icons.badge_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Email Address', value: email, icon: Icons.email_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Mobile Number', value: phone, icon: Icons.phone_outlined),
                ],
              ),
              const SizedBox(height: 24),

              // Fleet Info Card
              _buildInfoCard(
                title: 'Fleet Info',
                icon: Icons.business_outlined,
                children: [
                  _buildDisplayField(label: 'Company Name', value: companyName, icon: Icons.domain),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Base City / Location', value: location, icon: Icons.location_on_outlined),
                  const SizedBox(height: 16),
                  _buildDisplayField(label: 'Fleet Size', value: fleetSize, icon: Icons.local_shipping_outlined, showDropdownIcon: true),
                ],
              ),
              const SizedBox(height: 32),

              // Edit Profile Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fleetBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _showEditProfileDialog,
                  child: const Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),

              // Log out Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC72828),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const FleetLoginScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text("Log Out", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
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
              Icon(icon, color: fleetBlue, size: 20),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: fleetBlue, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDisplayField({required String label, required String value, required IconData icon, bool showDropdownIcon = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(icon, color: Colors.black54, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(value, style: const TextStyle(color: Colors.black87, fontSize: 14)),
              ),
              if (showDropdownIcon)
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({required String label, required String hint, required IconData icon, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(icon, color: Colors.black54, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
