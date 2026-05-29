import 'package:flutter/material.dart';
import '../../data/stock_inventory_state.dart';

class StockOrdersScreen extends StatefulWidget {
  const StockOrdersScreen({super.key});

  @override
  State<StockOrdersScreen> createState() => _StockOrdersScreenState();
}

class _StockOrdersScreenState extends State<StockOrdersScreen> {
  final Color navyColor = const Color(0xFF1F3E5A);
  final Color tealAccent = const Color(0xFF0C7A70);
  final Color bgBeige = const Color(0xFFFFFCE4);
  final Color orangeWarning = const Color(0xFFD05C13);

  @override
  Widget build(BuildContext context) {
    final orders = StockInventoryState.farmerOrders;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title banner
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Buyer Orders',
                style: TextStyle(
                  color: navyColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: navyColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "${orders.length} Active",
                  style: TextStyle(
                    color: navyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // List of orders
        Expanded(
          child: orders.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return _buildOrderCard(order);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_rounded, size: 64, color: navyColor.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Text(
            'No orders yet',
            style: TextStyle(color: navyColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'When wholesale buyers place orders, they will appear here.',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    bool requested = order["vehicleRequested"] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
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
          // Order Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order["id"] ?? "ORD-XXXXX",
                    style: TextStyle(
                      color: navyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    order["time"] ?? "Just now",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: requested ? const Color(0xFFE2F3F0) : const Color(0xFFFFF0E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  requested ? "Vehicle Requested" : (order["status"] ?? "New Order"),
                  style: TextStyle(
                    color: requested ? tealAccent : orangeWarning,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),

          // Customer and Product details
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgBeige,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.storefront, color: navyColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order["buyer"] ?? "Buyer",
                      style: TextStyle(
                        color: navyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${order["item"]} • ${order["quantity"]}",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Value",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  Text(
                    "₹${order["value"]}",
                    style: TextStyle(
                      color: tealAccent,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Specs (Distance and vehicle type)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.route, color: Colors.grey.shade600, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      "Distance: ${order["distance"]}",
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.local_shipping_outlined, color: Colors.grey.shade600, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      "Need: ${order["truckType"]}",
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action Button for transport request
          if (requested)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hourglass_empty_rounded, color: Colors.grey.shade600, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "Awaiting Vehicle Assignment",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: navyColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() {
                    order["vehicleRequested"] = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Transport requested! Fleet manager has been notified."),
                      backgroundColor: navyColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.local_shipping, size: 18),
                label: const Text(
                  "Request Vehicle",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
