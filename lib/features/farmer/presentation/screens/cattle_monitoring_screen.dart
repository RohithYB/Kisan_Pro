import 'package:flutter/material.dart';

import '../../../../data/models/cattle_model.dart';
import '../controller/farmer_controller.dart';

class CattleMonitoringScreen extends StatefulWidget {
  const CattleMonitoringScreen({super.key});

  @override
  State<CattleMonitoringScreen> createState() => _CattleMonitoringScreenState();
}

class _CattleMonitoringScreenState extends State<CattleMonitoringScreen> {
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _showAddCattleDialog() {
    showDialog(
      context: context,
      builder: (context) {
        const Color primaryGreen = Color(0xFF1A6C24);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text(
            'Add Cattle Record',
            style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen),
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Enter cattle name'
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Cattle Name',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _breedController,
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Enter breed' : null,
                    decoration: const InputDecoration(
                      labelText: 'Breed',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Enter weight';
                      if (double.tryParse(v) == null)
                        return 'Enter valid weight number';
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newCattle = CattleModel(
                    id: 'CTL-${100 + FarmerController.instance.cattleList.length + 1}',
                    name: _nameController.text.trim(),
                    breed: _breedController.text.trim(),
                    weight: double.parse(_weightController.text.trim()),
                    status: 'Healthy',
                  );

                  FarmerController.instance.addCattle(newCattle);

                  // Clear text fields
                  _nameController.clear();
                  _breedController.clear();
                  _weightController.clear();

                  Navigator.pop(context);
                  setState(() {}); // Refresh list

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${newCattle.name} added successfully!'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: primaryGreen,
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1A6C24);
    const Color bgBeige = Color(0xFFF3EED9);
    final cattleList = FarmerController.instance.cattleList;

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Cattle Monitoring',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Top Add Cattle Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: _showAddCattleDialog,
                  icon: const Icon(Icons.add_circle_outline, size: 24),
                  label: const Text(
                    'Add Cattle',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Below Cattle List Cards
              Expanded(
                child: cattleList.isEmpty
                    ? const Center(
                        child: Text(
                          "No cattle records yet",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cattleList.length,
                        itemBuilder: (context, index) {
                          final cattle = cattleList[index];
                          final isCritical = cattle.status == 'Critical';

                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 14.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  // Colored icon background matching health status
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color:
                                          (isCritical
                                                  ? Colors.red
                                                  : primaryGreen)
                                              .withAlpha((0.15 * 255).round()),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.pets_rounded,
                                      color: isCritical
                                          ? Colors.red
                                          : primaryGreen,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Cattle Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cattle.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "ID: ${cattle.id} • Breed: ${cattle.breed}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Status Indicator Chip
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isCritical
                                          ? Colors.red
                                          : primaryGreen,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      cattle.status,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
