import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class AlertsTable extends StatelessWidget {
  const AlertsTable({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;

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
                  Icon(Icons.history, color: AppColors.primaryPurple, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Recent Alerts",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryPurple,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(2.8),
              2: FlexColumnWidth(1.6),
              3: FlexColumnWidth(1.0),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.surfaceLight, width: 1.5)),
                ),
                children: [
                  _buildTableHeader("TIME"),
                  _buildTableHeader("ALERT TYPE"),
                  _buildTableHeader("SEVERITY"),
                  _buildTableHeader("ACTION"),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.bgSlate, width: 1)),
                ),
                children: [
                  _buildTableCell("14:45"),
                  _buildTableCell("Slight Fatigue\nDetected", isMultiline: true),
                  _buildTableCellBadge("Minor", AppColors.dangerBg, AppColors.dangerRed),
                  _buildTableCellAction(),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.bgSlate, width: 1)),
                ),
                children: [
                  _buildTableCell("14:22"),
                  _buildTableCell("Hard Braking\nDetected", isMultiline: true),
                  _buildTableCellBadge("Moderate", AppColors.warningBg, const Color(0xFFF59E0B)),
                  _buildTableCellAction(),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("13:10"),
                  _buildTableCell("Route\nDivergence", isMultiline: true),
                  _buildTableCellBadge("Resolved", AppColors.surfaceLight, const Color(0xFF64748B)),
                  _buildTableCellAction(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.textTertiary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: isMultiline ? 1.3 : 1.0,
        ),
      ),
    );
  }

  Widget _buildTableCellBadge(String text, Color bgColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: UnconstrainedBox(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCellAction() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.primaryPurple,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}

