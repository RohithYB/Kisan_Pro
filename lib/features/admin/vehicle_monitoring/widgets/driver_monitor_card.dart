import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class DriverMonitorCard extends StatelessWidget {
  const DriverMonitorCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color greenText = AppColors.successGreen;
    const Color greenBg = AppColors.successBg;

    return Container(
      padding: const EdgeInsets.all(16.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.psychology_outlined, color: AppColors.primaryPurple, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Driver Monitoring",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: greenBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Safe Driving",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: greenText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]),
              ),
            ),
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 180),
                  painter: CameraMeshPainter(),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "CAB CAM 01",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(color: AppColors.textPrimary, blurRadius: 4, offset: Offset(1, 1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSurveillanceMeta("Attention", "Focused")),
              const SizedBox(width: 8),
              Expanded(child: _buildSurveillanceMeta("Eyes", "Normal")),
              const SizedBox(width: 8),
              Expanded(child: _buildSurveillanceMeta("Fatigue", "Low")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSurveillanceMeta(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class CameraMeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = AppColors.successGreen
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final headRect = Rect.fromLTWH(size.width * 0.35, 30, size.width * 0.3, 100);
    canvas.drawRect(headRect, boxPaint);

    final eyesRect = Rect.fromLTWH(size.width * 0.4, 55, size.width * 0.2, 16);
    canvas.drawRect(eyesRect, boxPaint);

    final mouthRect = Rect.fromLTWH(size.width * 0.45, 90, size.width * 0.1, 10);
    canvas.drawRect(mouthRect, boxPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

