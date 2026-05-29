import 'package:flutter/material.dart';

import '../../../../data/models/farm_model.dart';
import '../controller/farmer_controller.dart';

class FarmSetupScreen extends StatefulWidget {
  final FarmModel? farmToEdit;

  const FarmSetupScreen({super.key, this.farmToEdit});

  @override
  State<FarmSetupScreen> createState() => _FarmSetupScreenState();
}

class _FarmSetupScreenState extends State<FarmSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _farmNameController = TextEditingController();
  final _cattleCountController = TextEditingController();
  final _locationController = TextEditingController();

  final _cameraNameController = TextEditingController();
  final _cameraLocationController = TextEditingController();

  final List<Map<String, String>> _addedCameras = [];

  @override
  void initState() {
    super.initState();
    // Pre-populate details if in edit mode
    if (widget.farmToEdit != null) {
      _farmNameController.text = widget.farmToEdit!.name;
      _cattleCountController.text = widget.farmToEdit!.cattleCount.toString();
      _locationController.text = widget.farmToEdit!.location;
      _addedCameras.addAll(widget.farmToEdit!.cameras);
    }
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    _cattleCountController.dispose();
    _locationController.dispose();
    _cameraNameController.dispose();
    _cameraLocationController.dispose();
    super.dispose();
  }

  void _addCamera() {
    final name = _cameraNameController.text.trim();
    final loc = _cameraLocationController.text.trim();

    if (name.isEmpty || loc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in both Camera Name and Camera Location"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _addedCameras.add({'name': name, 'location': loc});
      _cameraNameController.clear();
      _cameraLocationController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Camera '$name' added!"),
        backgroundColor: const Color(0xFF0C7A70),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _finishSetup() {
    if (_formKey.currentState!.validate()) {
      final String name = _farmNameController.text.trim();
      final int cattleCount =
          int.tryParse(_cattleCountController.text.trim()) ?? 0;
      final String location = _locationController.text.trim();

      if (widget.farmToEdit != null) {
        // Edit Mode: Update existing FarmModel
        final updatedFarm = FarmModel(
          id: widget.farmToEdit!.id,
          name: name,
          cattleCount: cattleCount,
          location: location,
          cameras: List.from(_addedCameras),
          imageUrl: widget.farmToEdit!.imageUrl,
        );

        FarmerController.instance.updateFarm(updatedFarm);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Farm '$name' successfully updated!"),
            backgroundColor: const Color(0xFF0C7A70),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        // Create Mode: Add new FarmModel
        final String id = 'Farm110-${DateTime.now().millisecondsSinceEpoch}';
        final newFarm = FarmModel(
          id: id,
          name: name,
          cattleCount: cattleCount,
          location: location,
          cameras: List.from(_addedCameras),
          imageUrl: 'assets/images/logo_illustration.png',
        );

        FarmerController.instance.addFarm(newFarm);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Farm '$name' successfully registered!"),
            backgroundColor: const Color(0xFF0C7A70),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      // Return to Farms list
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color tealHeader = Color(0xFF0C7A70); // Dark teal from PNG header
    const Color bgBeige = Color(0xFFFFFCE4); // Pale beige backdrop
    const Color inputBg = Color(0xFFDDE6D5); // Pale green background

    final bool isEditMode = widget.farmToEdit != null;

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Edit Farm' : 'Sign Up',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: tealHeader,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mockup title: Set up your Farm
                Text(
                  isEditMode ? 'Edit Farm details' : 'Set up your Farm',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),

                // 1. Farm Information Container Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFD9), // Rounded card light bg
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.06 * 255).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Farm Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Farm Name
                      const Text(
                        'Farm Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _farmNameController,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please enter farm name'
                            : null,
                        decoration: InputDecoration(
                          hintText: "Enter your Name",
                          hintStyle: const TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Number of Cattle
                      const Text(
                        'Number of cattle',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _cattleCountController,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty)
                            return 'Please enter cattle count';
                          if (int.tryParse(v.trim()) == null)
                            return 'Enter a valid number';
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Type here",
                          hintStyle: const TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Location
                      const Text(
                        'Enter the farm location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _locationController,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please enter location'
                            : null,
                        decoration: InputDecoration(
                          hintText: "Enter your Name",
                          hintStyle: const TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Camera Setup Card Container
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFD9),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.06 * 255).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Camera Setup',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Camera Name
                      const Text(
                        'Camera name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _cameraNameController,
                        decoration: InputDecoration(
                          hintText: "Type here",
                          hintStyle: const TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Camera Location
                      const Text(
                        'Camera Location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _cameraLocationController,
                        decoration: InputDecoration(
                          hintText: "Type here",
                          hintStyle: const TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Interactive chip lists
                      if (_addedCameras.isNotEmpty) ...[
                        const Text(
                          "Added Cameras:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: tealHeader,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: _addedCameras.map((cam) {
                            return Chip(
                              label: Text(
                                "${cam['name']} (${cam['location']})",
                              ),
                              backgroundColor: Colors.white,
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                color: tealHeader,
                                fontWeight: FontWeight.bold,
                              ),
                              deleteIcon: const Icon(
                                Icons.cancel,
                                size: 16,
                                color: Colors.redAccent,
                              ),
                              onDeleted: () {
                                setState(() {
                                  _addedCameras.remove(cam);
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Add Camera button inside card
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealHeader,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: _addCamera,
                        child: const Text(
                          'Add Camera',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Finish Setup/Save Changes full-width action button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealHeader,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                    ),
                    onPressed: _finishSetup,
                    child: Text(
                      isEditMode ? 'Save Changes' : 'Finish Setup',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
