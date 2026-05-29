import 'package:flutter/material.dart';

class CattleDirectionScreen extends StatefulWidget {
  final String cowName;
  final String cowId;

  const CattleDirectionScreen({
    super.key,
    required this.cowName,
    required this.cowId,
  });

  @override
  State<CattleDirectionScreen> createState() => _CattleDirectionScreenState();
}

class _CattleDirectionScreenState extends State<CattleDirectionScreen> {
  bool _isNavigating = false;

  void _triggerNavigation() {
    setState(() {
      _isNavigating = !_isNavigating;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isNavigating
              ? "GPS live tracking active! Following route to ${widget.cowName}..."
              : "Navigation stopped.",
        ),
        backgroundColor: const Color(0xFF0C7A70),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color textTeal = Color(0xFF0C7A70);
    const Color bgBeige = Color(0xFFFFFCE4);

    return Scaffold(
      backgroundColor: bgBeige,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Kisan Pro',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: textTeal,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: textTeal, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.gps_fixed_rounded,
              color: textTeal,
              size: 26,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Recalibrating GPS tracking precision..."),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // 1. Blurred pastoral path tracking canvas background matching PNG 2
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8C29D), // Light warm peach
                  Color(0xFFFFF7EB), // Soft beige cream
                  Color(0xFFCBE9CE), // Soft green pasture transition
                ],
              ),
            ),
          ),

          // 2. Custom Painter drawing the winding dotted green path on the map
          Positioned.fill(
            child: CustomPaint(
              painter: WindingPathPainter(isNavigating: _isNavigating),
            ),
          ),

          // 3. Winding Path pin overlays (Starting dot at bottom-center, red target pin labeled "Lakshmi" at top-center)
          // Starting Dot
          Positioned(
            bottom: 300,
            left: 190,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: textTeal, width: 4),
                color: Colors.white,
              ),
            ),
          ),

          // Target Pin labeled "Lakshmi"
          Positioned(
            top: 250,
            left: 170,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.cowName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Icon(
                  Icons.location_on_rounded,
                  color: Color(0xFFC0392B), // Warning red pin
                  size: 38,
                ),
              ],
            ),
          ),

          // 4. Floating metrics overlay card at the top (Distance & ETA) matching PNG 2
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.08 * 255).round()),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  // Distance section
                  const Icon(
                    Icons.directions_walk_rounded,
                    color: Colors.black87,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "DISTANCE",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "2.4 KM",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Line separator
                  Container(width: 1.5, height: 36, color: Colors.black12),

                  const Spacer(),

                  // ETA section
                  const Icon(
                    Icons.access_time_rounded,
                    color: Colors.black87,
                    size: 26,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "ETA",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "8 Min",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 5. Lower White Card panel holding details and navigation controls matching PNG 2
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF5), // Rounded card background
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.08 * 255).round()),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lakshmi & Outside Geofence tag row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cowName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFADBD8), // Soft red background
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: const Color(0xFFE74C3C),
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Color(0xFFC0392B),
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "OUTSIDE GEO-FENCE",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFC0392B),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Cow ID
                  Text(
                    "ID: ${widget.cowId}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Last Location Update bar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFF9F7EF,
                      ), // Creamy background matching card update bar
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.history_toggle_off_rounded,
                          color: Colors.black38,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Last Location Update: 1 Minute Ago",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Start Navigation trigger button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            textTeal, // Custom dark green/teal button
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _triggerNavigation,
                      icon: Icon(
                        _isNavigating
                            ? Icons.stop_rounded
                            : Icons.navigation_rounded,
                        size: 20,
                      ),
                      label: Text(
                        _isNavigating ? "Stop Navigation" : "Start Navigation",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter drawing the winding route path curves on map matching PNG 2
class WindingPathPainter extends CustomPainter {
  final bool isNavigating;

  WindingPathPainter({required this.isNavigating});

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    const Color textTeal = Color(0xFF0C7A70);

    // 1. Draw the actual curved winding route path matching the mockup illustration curve
    path.moveTo(200, size.height - 310);
    path.cubicTo(
      210,
      size.height - 450, // control point 1
      110,
      size.height - 500, // control point 2
      180,
      275, // end point target pin coordinates
    );

    // 2. Draw curved dashed lines for the path representation
    final Paint pathPaint = Paint()
      ..color = textTeal.withAlpha((0.85 * 255).round())
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Custom dash path drawing logic for curves
    for (double i = 0; i < 1.0; i += 0.02) {
      // Draw dynamic glowing pulse along route if actively navigating!
      if (isNavigating &&
          (DateTime.now().millisecondsSinceEpoch % 1000 > i * 1000)) {
        pathPaint.color = Colors.greenAccent;
      } else {
        pathPaint.color = textTeal;
      }

      final double t = i;
      final double nextT = i + 0.01;

      // Calculate bezier coordinate segments
      final double x1 = _getBezierCoord(200, 210, 110, 180, t);
      final double y1 = _getBezierCoord(
        size.height - 310,
        size.height - 450,
        size.height - 500,
        275,
        t,
      );

      final double x2 = _getBezierCoord(200, 210, 110, 180, nextT);
      final double y2 = _getBezierCoord(
        size.height - 310,
        size.height - 450,
        size.height - 500,
        275,
        nextT,
      );

      // Draw segment line
      if (i % 0.04 < 0.02) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), pathPaint);
      }
    }
  }

  // Helper bezier interpolator
  double _getBezierCoord(double p0, double p1, double p2, double p3, double t) {
    return (1 - t) * (1 - t) * (1 - t) * p0 +
        3 * (1 - t) * (1 - t) * t * p1 +
        3 * (1 - t) * t * t * p2 +
        t * t * t * p3;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
