import 'package:flutter/material.dart';
import 'cattle_direction_screen.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Exact colors from PNG mockup
    const Color peachHeader = Color(0xFFE8C29D); // Soft peach top app bar
    const Color searchBg = Color(0xFFF2D1AC); // Darker orange-beige search background
    const Color textTeal = Color(0xFF0C7A70); // Deep teal text

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cattle Tracking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textTeal, // Exact teal font
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: peachHeader,
        foregroundColor: textTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: textTeal, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // 1. Beautiful gradient canvas backdrop representing pastoral pasture map matching PNG 1
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8C29D), // Matches peach header
                  Color(0xFFE9964D), // Transitions to warm orange
                ],
              ),
            ),
          ),

          // 2. Custom Painter drawing the geofence map grid and markings
          Positioned.fill(
            child: CustomPaint(
              painter: GeofenceGridPainter(),
            ),
          ),

          // 3. Circular Geofence boundary card representing "10 KM Geo-Fence"
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: textTeal,
                  width: 2.0,
                  style: BorderStyle.none, // We will paint the dots inside CustomPainter for perfect replica!
                ),
              ),
            ),
          ),

          // 4. Interactive cow markers plotted matching PNG mockup
          // Marker 1: Lakshmi (Breached Outside Geo-Fence at the top right)
          Positioned(
            top: 250,
            right: 100,
            child: Column(
              children: [
                // Floating label tag matching PNG 1 exactly!
                GestureDetector(
                  onTap: () => _navigateToDirections(context, "Lakshmi", "KP-204"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBE6CD), // Beige color tag
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.circle, color: Colors.red, size: 8),
                        const SizedBox(width: 6),
                        const Text(
                          "Lakshmi • KP-204",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => _navigateToDirections(context, "Lakshmi", "KP-204"),
                  child: const Icon(
                    Icons.pets_rounded,
                    color: Color(0xFFC0392B), // Dark Red paw representing breached location!
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // Marker 2: inside cow 1
          Positioned(
            top: 360,
            left: 175,
            child: GestureDetector(
              onTap: () => _navigateToDirections(context, "Gauri", "CTL-101"),
              child: const Icon(
                Icons.pets_rounded,
                color: textTeal, // Teal paw
                size: 28,
              ),
            ),
          ),

          // Marker 3: inside cow 2 (Active target ring)
          Positioned(
            top: 430,
            left: 190,
            child: GestureDetector(
              onTap: () => _navigateToDirections(context, "Ganga", "CTL-102"),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      color: Colors.transparent,
                    ),
                  ),
                  const Icon(
                    Icons.pets_rounded,
                    color: textTeal, // Teal paw
                    size: 26,
                  ),
                ],
              ),
            ),
          ),

          // Marker 4: inside cow 3
          Positioned(
            top: 480,
            right: 155,
            child: GestureDetector(
              onTap: () => _navigateToDirections(context, "Kalu", "CTL-103"),
              child: const Icon(
                Icons.pets_rounded,
                color: textTeal, // Teal paw
                size: 28,
              ),
            ),
          ),

          // 5. Search Bar Input Textfield Overlay at the top matching PNG 1 exactly!
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: searchBg,
                borderRadius: BorderRadius.circular(26.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: textTeal, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Search cattle by name or ID",
                        hintStyle: TextStyle(color: textTeal, fontSize: 15, fontWeight: FontWeight.w500),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: textTeal, fontWeight: FontWeight.bold),
                      onSubmitted: (query) {
                        if (query.trim().isNotEmpty) {
                          _navigateToDirections(context, query.trim(), "KP-204");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 6. Label at the bottom center of the fence: "10 KM Geo-Fence"
          Positioned(
            top: 560,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9), // Light mint green pill background
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Text(
                  "10 KM Geo-Fence",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: textTeal,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDirections(BuildContext context, String cowName, String cowId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CattleDirectionScreen(
          cowName: cowName,
          cowId: cowId,
        ),
      ),
    );
  }
}

// Paints the 10 KM fence dotted border and aesthetic circles matching PNG 1
class GeofenceGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 30);
    const Color textTeal = Color(0xFF0C7A70);

    // 1. Draw subtle aesthetic outer contour waves
    final Paint wavePaint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, 180, wavePaint);

    // 2. Draw dotted "10 KM Geo-Fence" circle
    final Paint dottedPaint = Paint()
      ..color = textTeal.withAlpha((0.6 * 255).round())
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const double radius = 125.0;
    const double dashWidth = 5.0;
    const double dashSpace = 5.0;
    double startAngle = 0.0;

    final double totalCircumference = 2 * 3.1415926535 * radius;
    final int dashCount = (totalCircumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final double angle = startAngle + (i * (dashWidth + dashSpace) / radius);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        angle,
        dashWidth / radius,
        false,
        dottedPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
