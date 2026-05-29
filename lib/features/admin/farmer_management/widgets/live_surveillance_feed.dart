import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class LiveSurveillanceFeed extends StatelessWidget {
  final String location;
  final AnimationController pulseController;

  const LiveSurveillanceFeed({
    super.key,
    required this.location,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.6,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.green.withAlpha((0.15 * 255).round()),
                  BlendMode.colorBurn,
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?auto=format&fit=crop&q=80&w=650',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.textPrimary,
                      child: const Center(
                        child: Icon(Icons.videocam, color: Colors.white30, size: 48),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((0.6 * 255).round()),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  children: [
                    FadeTransition(
                      opacity: Tween<double>(begin: 0.2, end: 1.0).animate(pulseController),
                      child: const Icon(Icons.circle, color: Colors.redAccent, size: 8),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'REC  CAM_01',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((0.6 * 255).round()),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  '14:02:11',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 80,
              child: Container(
                width: 110,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF00E676),
                    width: 1.8,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    color: const Color(0xFF00E676),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: const Text(
                      "CATTLE ID: 8821\nHEALTH: GOOD",
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 20,
              right: 50,
              child: Icon(
                Icons.filter_center_focus_rounded,
                color: Colors.amberAccent,
                size: 28,
              ),
            ),
            Positioned(
              bottom: 12,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  "PASTURE B • $location",
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

