import 'package:flutter/material.dart';

class StockHistoryScreen extends StatefulWidget {
  const StockHistoryScreen({super.key});

  @override
  State<StockHistoryScreen> createState() => _StockHistoryScreenState();
}

class _StockHistoryScreenState extends State<StockHistoryScreen> {
  final Color navyColor = const Color(0xFF1F3E5A);
  final Color bgBeige = const Color(0xFFFFFCE4);
  final Color tealAccent = const Color(0xFF0C7A70);

  String _selectedPeriod = '7 Days';

  final List<Map<String, dynamic>> _deliveries = [
    {
      "id": "ORD-20412",
      "time": "Yesterday • 11:30 AM",
      "customer": "FreshMart Veg",
      "product": "Fresh Tomatoes",
      "quantity": "650 KG",
      "destination": "KR Market, BLR",
      "vehicle": "KA-05-TR-4589",
      "driver": "Suresh K."
    },
    {
      "id": "ORD-20413",
      "time": "Yesterday • 2:15 PM",
      "customer": "City Grocers",
      "product": "Red Onions",
      "quantity": "400 KG",
      "destination": "Madiwala, BLR",
      "vehicle": "KA-01-ME-8821",
      "driver": "Ramesh M."
    },
    {
      "id": "ORD-20414",
      "time": "2 Days Ago • 10:45 AM",
      "customer": "Kisan Retailers",
      "product": "Washed Carrots",
      "quantity": "250 KG",
      "destination": "Yeshwanthpur, BLR",
      "vehicle": "KA-04-AB-5678",
      "driver": "Nagaraj P."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Time Period Filter Row
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildFilterCapsule('7 Days'),
                _buildFilterCapsule('1 Day'),
                _buildFilterCapsule('30 Days'),
                _buildFilterCapsule('6 Months'),
              ],
            ),
          ),
        ),

        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Completed Deliveries',
                style: TextStyle(
                  color: navyColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Orders delivered successfully',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Deliveries Card List
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _deliveries.length,
            itemBuilder: (context, index) {
              final delivery = _deliveries[index];
              return _buildDeliveryCard(delivery as Map<String, String>);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterCapsule(String label) {
    bool isSelected = _selectedPeriod == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? navyColor : Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: isSelected ? navyColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, String> d) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d["id"]!,
                    style: TextStyle(
                      color: navyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    d["time"]!,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Delivered Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F3F0),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: tealAccent, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Delivered Successfully',
                      style: TextStyle(
                        color: tealAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 16),

          // Detail Grid (2-column layout)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGridCell('Customer', d["customer"]!),
                    const SizedBox(height: 12),
                    _buildGridCell('Quantity', d["quantity"]!),
                    const SizedBox(height: 12),
                    _buildGridCell('Vehicle', d["vehicle"]!),
                  ],
                ),
              ),
              // Column 2
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGridCell('Product', d["product"]!),
                    const SizedBox(height: 12),
                    _buildGridCell('Destination', d["destination"]!),
                    const SizedBox(height: 12),
                    _buildGridCell('Driver', d["driver"]!),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridCell(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: navyColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
