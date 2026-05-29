import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class RecentComplaintsCard extends StatelessWidget {
  const RecentComplaintsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildComplaintCard(
          title: "Damaged Packaging",
          status: "RESOLVED",
          statusBg: AppColors.infoBg,
          statusTextColor: const Color(0xFF0369A1),
          body: "Case #ISS-203: 2 crates of tomatoes arrived with broken lids. Replacement issued within 2 hours.",
          footer: "Oct 24, 2023 • 14:20",
          accentColor: const Color(0xFF0ea5e9),
        ),
        const SizedBox(height: 12),
        _buildComplaintCard(
          title: "Delay in Transit",
          status: "INVESTIGATING",
          statusBg: AppColors.warningBg,
          statusTextColor: AppColors.warningOrange,
          body: "Case #ISS-215: Driver BLR-12 reported engine issues. Rerouting spare vehicle from nearby hub.",
          footer: "Oct 25, 2023 • 09:15",
          accentColor: const Color(0xFFf59e0b),
        ),
      ],
    );
  }

  Widget _buildComplaintCard({
    required String title,
    required String status,
    required Color statusBg,
    required Color statusTextColor,
    required String body,
    required String footer,
    required Color accentColor,
  }) {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: accentColor, width: 4),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textNavy,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: statusTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                footer,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityHistoryCard extends StatelessWidget {
  final Color primaryColor;

  const ActivityHistoryCard({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildActivityTimelineRow(
            title: "Order #PRO-9104 Placed",
            body: "Bulk order for 500kg of Organic Basmati Rice and 200kg assorted vegetables.",
            time: "Today • 08:30 AM",
            dotColor: primaryColor,
            isFirst: true,
          ),
          _buildActivityTimelineRow(
            title: "Payment Confirmed",
            body: "Transaction ID: TXN_8821901 confirmed for ₹84,200 via Corporate Net Banking.",
            time: "Yesterday • 05:45 PM",
            dotColor: const Color(0xFF3B82F6),
          ),
          _buildActivityTimelineRow(
            title: "Inventory Inquiry",
            body: "Client checked availability of Seasonal Produce.",
            time: "2 days ago • 10:15 AM",
            dotColor: const Color(0xFF94A3B8),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTimelineRow({
    required String title,
    required String body,
    required String time,
    required Color dotColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.borderLight,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0.0 : 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
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

