import 'package:flutter/material.dart';

class WeightMonitoringScreen extends StatefulWidget {
  const WeightMonitoringScreen({super.key});

  @override
  State<WeightMonitoringScreen> createState() => _WeightMonitoringScreenState();
}

class _WeightMonitoringScreenState extends State<WeightMonitoringScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();

  // List representing our calculated cattle weights history matching PNG 4
  final List<Map<String, dynamic>> _weightHistory = [
    {
      'name': 'Lakshmi',
      'id': 'KP-204',
      'weight': '420',
      'imageUrl': 'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?auto=format&fit=crop&q=80&w=350',
    },
    {
      'name': 'Gauri',
      'id': 'CTL-101',
      'weight': '395',
      'imageUrl': 'https://images.unsplash.com/photo-1543882048-2598350202DF?auto=format&fit=crop&q=80&w=350',
    }
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  // Opens the high-fidelity 4-view image upload overlay matching PNG 5
  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            // Track dynamic upload states inside the dialog
            final Map<String, bool> uploadedViews = {
              'Front': false,
              'Back': false,
              'Left': false,
              'Right': false,
            };

            const Color tealAccent = Color(0xFF0C7A70);

            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFD9), // Beige matching mockup dialog
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header row holding close trigger
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.close_rounded, color: Colors.black54),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      // Green camera badge at the top
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: tealAccent.withAlpha((0.15 * 255).round()),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.photo_camera_rounded,
                            color: tealAccent,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Heading & Subtitle exactly matching PNG 5
                      const Text(
                        "Upload Cattle Images",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Upload all 4 sides of the cattle for\naccurate AI weight analysis",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 2x2 grid of dashed border square cards
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.0,
                        children: [
                          _buildDashedUploadBox(
                            title: "Front View",
                            isUploaded: uploadedViews['Front']!,
                            onTap: () {
                              setModalState(() {
                                uploadedViews['Front'] = true;
                              });
                            },
                          ),
                          _buildDashedUploadBox(
                            title: "Back View",
                            isUploaded: uploadedViews['Back']!,
                            onTap: () {
                              setModalState(() {
                                uploadedViews['Back'] = true;
                              });
                            },
                          ),
                          _buildDashedUploadBox(
                            title: "Left View",
                            isUploaded: uploadedViews['Left']!,
                            onTap: () {
                              setModalState(() {
                                uploadedViews['Left'] = true;
                              });
                            },
                          ),
                          _buildDashedUploadBox(
                            title: "Right View",
                            isUploaded: uploadedViews['Right']!,
                            onTap: () {
                              setModalState(() {
                                uploadedViews['Right'] = true;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Submit Photos action button at bottom matching PNG 5
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tealAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.0),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            // Close modal and calculate weight dynamically
                            Navigator.pop(context);
                            _calculateWeight();
                          },
                          icon: const Icon(Icons.cloud_upload_outlined, size: 20),
                          label: const Text(
                            "Submit Photos",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Generates dashed visual cards for the dialog box grid
  Widget _buildDashedUploadBox({
    required String title,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    const Color tealAccent = Color(0xFF0C7A70);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isUploaded ? tealAccent : Colors.black12,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUploaded ? Icons.check_circle_rounded : Icons.add_photo_alternate_outlined,
              size: 36,
              color: isUploaded ? tealAccent : Colors.black38,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isUploaded ? tealAccent : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper calculating dynamic weights and appending them to the results list
  void _calculateWeight() {
    final name = _nameController.text.trim();
    final id = _idController.text.trim();

    final String finalName = name.isEmpty ? "Lakshmi" : name;
    final String finalId = id.isEmpty ? "KP-204" : id;

    // Simulate model calculation delay
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("AI Model analyzing cattle pictures..."),
        backgroundColor: Color(0xFF0C7A70),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _weightHistory.insert(0, {
            'name': finalName,
            'id': finalId,
            'weight': '420', // Pre-calculated weight matching PNG 4
            'imageUrl': 'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?auto=format&fit=crop&q=80&w=350',
          });

          _nameController.clear();
          _idController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Weight calculated for '$finalName': 420 KG! Added below."),
            backgroundColor: const Color(0xFF0C7A70),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color tealAccent = Color(0xFF0C7A70);
    const Color bgBeige = Color(0xFFFFFCE4);
    const Color inputBg = Color(0xFFDDE6D5);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Cattle Weight Monitoring',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Identify Cattle Container Form Card matching PNG 4
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFD9), // Container bg matching PNG
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).round()),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Identify Cattle",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: tealAccent, // Bold header matches PNG
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Cattle Name
                    const Text(
                      "Cattle Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "e.g. Lakshmi",
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: inputBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Cattle ID
                    const Text(
                      "Cattle ID",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                        hintText: "e.g. KP-204",
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: inputBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Upload Cattle Images button matching PNG 4
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26.0),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => _showUploadDialog(context),
                        icon: const Icon(Icons.photo_camera_rounded, size: 20),
                        label: const Text(
                          "Upload Cattle Images",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Estimated cattle weights list history scroll matching PNG 4
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _weightHistory.length,
                itemBuilder: (context, index) {
                  final item = _weightHistory[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFD9), // Rounded card light bg
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.05 * 255).round()),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Widescreen spotted cow image matching PNG 4
                        AspectRatio(
                          aspectRatio: 1.8,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            child: Image.network(
                              item['imageUrl']!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.black12,
                                  child: const Center(
                                    child: CircularProgressIndicator(color: tealAccent),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.pets, size: 50, color: Colors.black26);
                              },
                            ),
                          ),
                        ),

                        // Lower detail row holding labels and Recheck button matching PNG 4
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left info labels
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "ID: ${item['id']}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),

                              // Center Estimated Weight display
                              Column(
                                children: [
                                  const Text(
                                    "Estimated Weight",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        "${item['weight']}",
                                        style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: tealAccent,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      const Text(
                                        "KG",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: tealAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Recheck button
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: tealAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Simulating recheck weight estimation logic for '${item['name']}'..."),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Recheck weight",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
