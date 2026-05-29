import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class FleetMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final Color trendColor;
  final bool isStable;

  const FleetMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
    required this.trendColor,
    this.isStable = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: primaryPurple,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isStable ? Icons.check_circle_outline : Icons.trending_up,
                color: trendColor,
                size: 14,
              ),
              const SizedBox(width: 2),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: trendColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

