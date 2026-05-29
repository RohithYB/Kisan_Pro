import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class CompletionRateCard extends StatelessWidget {
  final Color primaryColor;
  final String rate;

  const CompletionRateCard({
    super.key,
    required this.primaryColor,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    double value = 0.0;
    String cleanRate = rate.replaceAll('%', '');
    if (double.tryParse(cleanRate) != null) {
      value = double.parse(cleanRate) / 100.0;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
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
          const Text(
            "Completion Rate",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            rate,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: AppColors.surfaceLight,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

