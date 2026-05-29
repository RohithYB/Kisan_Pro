import 'package:flutter/material.dart';

class CamLiveViewScreen extends StatelessWidget {
  final String cameraName;
  final String cameraLocation;
  final int cowCount;

  const CamLiveViewScreen({
    super.key,
    required this.cameraName,
    required this.cameraLocation,
    required this.cowCount,
  });

  @override
  Widget build(BuildContext context) {
    const Color tealAccent = Color(0xFF0C7A70);
    const Color bgBeige = Color(0xFFFFFCE4);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: Text(
          "$cameraName Live View",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Accessing camera settings..."),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // Widescreen Color Camera Video container matching PNG 3
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.15 * 255).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // High quality color farm picture representing live feed
                        AspectRatio(
                          aspectRatio: 1.45,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?auto=format&fit=crop&q=80&w=650',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.black87,
                                child: const Center(
                                  child: CircularProgressIndicator(color: tealAccent),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.black87,
                                child: const Center(
                                  child: Icon(Icons.videocam, color: Colors.white24, size: 60),
                                ),
                              );
                            },
                          ),
                        ),

                        // Flashing REC indicator at top-left
                        Positioned(
                          top: 14,
                          left: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha((0.55 * 255).round()),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.circle, color: Colors.redAccent, size: 8),
                                SizedBox(width: 5),
                                Text(
                                  "REC",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Timestamp indicator at top-right
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha((0.55 * 255).round()),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "10:24:30 AM",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        // Bounding Box Overlays tracking individual cows matching PNG 3 exactly!
                        Positioned(
                          top: 48,
                          left: 80,
                          child: Container(
                            width: 65,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF00E676), width: 1.5)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                color: const Color(0xFF00E676),
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                child: const Text(
                                  "Cow_042",
                                  style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 60,
                          right: 80,
                          child: Container(
                            width: 70,
                            height: 60,
                            decoration: BoxDecoration(border: Border.all(color: const Color(0xFF00E676), width: 1.5)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                color: const Color(0xFF00E676),
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                child: const Text(
                                  "Cow_089",
                                  style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 40,
                          left: 55,
                          child: Container(
                            width: 75,
                            height: 65,
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF00E676), width: 1.5)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                color: const Color(0xFF00E676),
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                child: const Text(
                                  "Cow_112",
                                  style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Zoom control menu overlay matching PNG 3
                        Positioned(
                          bottom: 14,
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha((0.6 * 255).round()),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.zoom_in, color: Colors.white, size: 20),
                                SizedBox(width: 14),
                                Icon(Icons.fullscreen_rounded, color: Colors.white, size: 20),
                                SizedBox(width: 14),
                                Icon(Icons.zoom_out, color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Total count card panel matching PNG 3
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.05 * 255).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      const Text(
                        "TOTAL CATTLE COUNT",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "$cowCount",
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.w900,
                          color: tealAccent, // Bold dark green count
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.history_toggle_off_rounded, color: Colors.black38, size: 18),
                          const SizedBox(width: 6),
                          const Text(
                            "Last Updated: 10:24:30 AM",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
