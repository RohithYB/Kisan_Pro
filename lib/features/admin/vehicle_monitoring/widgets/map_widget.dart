import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMapMetaItem(Icons.location_on_rounded, "Electronic City"),
                _buildMapMetaItem(Icons.schedule_outlined, "45 Min ETA"),
                _buildMapMetaItem(Icons.speed_rounded, "42 KM/H"),
              ],
            ),
          ),
          Container(
            height: 240,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=600",
                ),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withAlpha((0.15 * 255).round()),
                          Colors.indigo.withAlpha((0.3 * 255).round()),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 120,
                    child: CustomPaint(
                      painter: MapRoutePainter(),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 56,
                  child: Column(
                    children: [
                      _buildMapControlBtn(Icons.add),
                      const SizedBox(height: 6),
                      _buildMapControlBtn(Icons.remove),
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: _buildMapControlBtn(Icons.my_location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapMetaItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 12),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControlBtn(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).round()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.textPrimary, size: 18),
    );
  }
}

class MapRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryPurple
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(20, size.height - 20)
      ..cubicTo(size.width * 0.3, size.height * 0.9, size.width * 0.4, size.height * 0.2, size.width * 0.7, size.height * 0.3)
      ..lineTo(size.width - 20, 20);

    canvas.drawPath(path, paint);

    final startPaint = Paint()..color = AppColors.primaryPurple;
    canvas.drawCircle(const Offset(20, 100), 6, startPaint);

    final endPaint = Paint()..color = Colors.redAccent;
    canvas.drawCircle(Offset(size.width - 20, 20), 8, endPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

