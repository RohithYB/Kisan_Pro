import 'package:flutter/material.dart';
import 'fleet_dashboard_screen.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final Color fleetBlue = const Color(0xFF2B5B9A);
  final Color bgBeige = const Color(0xFFFFFCE4);

  String? _driverPhotoUrl;

  Future<void> _pickImage() async {
    setState(() {
      _driverPhotoUrl = "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Driver photo selected successfully!"),
        behavior: SnackBarBehavior.floating,
      ),
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
        title: const Text('Add Vehicle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Vehicle Details Card
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9EEF5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.local_shipping_outlined, color: fleetBlue, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Text('VEHICLE DETAILS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(label: 'Vehicle Name', hint: 'e.g. Eicher Pro 2049', icon: Icons.badge_outlined),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Vehicle Number / Plate', hint: 'e.g. MH 12 AB 1234', icon: Icons.directions_car_outlined),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Device ID', hint: 'e.g. IMAS-JET-001', icon: Icons.settings_input_antenna_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Driver Details Card
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9EEF5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.person_outline, color: fleetBlue, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Text('DRIVER DETAILS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Driver info is stored as vehicle data for this asset.', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    const SizedBox(height: 24),

                    _buildTextField(label: 'Driver Name', hint: 'e.g. Rajesh Kumar', icon: Icons.account_circle_outlined),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Email', hint: 'e.g. rajeshkumar5@gmail.com', icon: Icons.email_outlined),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Driver Phone', hint: 'e.g. +91 9876543210', icon: Icons.phone_outlined),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Driver Location', hint: 'e.g. Nagadenahalli', icon: Icons.location_on_outlined),
                    const SizedBox(height: 24),

                    // Add Photo
                    const Text('Add Photo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid), // Actually dashed in design, but dashed requires custom painter. Using solid for now
                        ),
                        child: _driverPhotoUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(_driverPhotoUrl!, fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(color: fleetBlue, shape: BoxShape.circle),
                                    child: const Icon(Icons.camera_alt, color: Colors.white),
                                  ),
                                  const SizedBox(height: 12),
                                  Text('Upload Photo of driver', style: TextStyle(color: fleetBlue, fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 4),
                                  const Text('PNG, JPG up to 5MB', style: TextStyle(color: Colors.black26, fontSize: 11)),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Register Vehicle Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fleetBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FleetDashboardScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save_outlined, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('Register Vehicle', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, required IconData icon}) {
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
              Icon(icon, color: Colors.black45, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
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
