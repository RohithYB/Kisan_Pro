import 'package:flutter/material.dart';
import '../../../../features/farmer/data/stock_inventory_state.dart';
import 'truck_monitoring_screen.dart';

class FleetRequestsScreen extends StatefulWidget {
  const FleetRequestsScreen({super.key});

  @override
  State<FleetRequestsScreen> createState() => _FleetRequestsScreenState();
}

class _FleetRequestsScreenState extends State<FleetRequestsScreen> {
  final Color fleetBlue = const Color(0xFF2B5B9A);
  final Color bgBeige = const Color(0xFFFFFCE4);
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: fleetBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Farmer Requests', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(Icons.search, color: Colors.black54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search farmer or product',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  _buildFilterChip('Pending'),
                  _buildFilterChip('Assigned'),
                  _buildFilterChip('Completed'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Request Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  if (_selectedFilter == 'All' || _selectedFilter == 'Pending') ...[
                    ..._buildDynamicPendingCards(),
                    _buildPendingCard(),
                  ],
                  if (_selectedFilter == 'All' || _selectedFilter == 'Assigned') _buildAssignedCard(),
                  if (_selectedFilter == 'All' || _selectedFilter == 'Completed') _buildCompletedCard(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? fleetBlue : const Color(0xFFE9EEF5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildPendingCard() {
    return _buildBaseCard(
      name: 'Ramesh Gowda',
      location: 'Green Valley Farm',
      tagText: 'PENDING',
      tagColor: const Color(0xFFF9E9D5),
      tagTextColor: const Color(0xFFD05C13),
      avatarUrl: 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=100',
      children: [
        _buildInfoRow(Icons.inventory_2_outlined, 'Product', 'Fresh Tomatoes (2 Tons)'),
        _buildInfoRow(Icons.route_outlined, 'Route', 'Kolar Farm -> KR Market, Bengaluru'),
        _buildInfoRow(Icons.access_time_outlined, 'Time & Distance', '10:30 AM • 68 KM'),
        _buildInfoRow(Icons.phone_outlined, 'Contact', '+91 98765 43210', isBoldValue: true, valueColor: fleetBlue),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F8),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fleetBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: const Text('ASSIGN VEHICLE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: const Text('REJECT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssignedCard() {
    return _buildBaseCard(
      name: 'Mallesh K.',
      location: 'Golden Fields',
      tagText: 'ASSIGNED',
      tagColor: fleetBlue,
      tagTextColor: Colors.white,
      avatarUrl: 'https://images.unsplash.com/photo-1620574387735-3624d75b2dbc?w=100',
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.local_shipping_outlined, color: Color(0xFF2B5B9A), size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('KA-05-TR-4589', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    Text('Driver: Suresh', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.circle, color: Color(0xFF388E3C), size: 6),
                    SizedBox(width: 4),
                    Text('Monitoring Active', style: TextStyle(color: Color(0xFF388E3C), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildInfoRow(Icons.inventory_2_outlined, 'Product', 'Potatoes (1.5 Tons)'),
        _buildInfoRow(Icons.route_outlined, 'Route', 'Mandya -> Mysore APMC'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F8),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: fleetBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TruckMonitoringScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.map_outlined, size: 18),
                  SizedBox(width: 8),
                  Text('OPEN TRACKING', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedCard() {
    return _buildBaseCard(
      name: 'Laxmi Bai',
      location: 'Sunrise Orchards',
      tagText: 'COMPLETED',
      tagColor: const Color(0xFFD6ECC1),
      tagTextColor: const Color(0xFF3E5C1D),
      avatarUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=100',
      isCompleted: true,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8ED),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: const [
              Icon(Icons.check_circle_outline, color: Color(0xFF3E5C1D), size: 18),
              SizedBox(width: 8),
              Text('Delivered at 5:42 PM', style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        _buildInfoRow(Icons.inventory_2_outlined, 'Product', 'Mangoes (500 KG)'),
        _buildInfoRow(Icons.route_outlined, 'Route', 'Chintamani -> Shivajinagar'),
      ],
    );
  }

  Widget _buildBaseCard({
    required String name,
    required String location,
    required String tagText,
    required Color tagColor,
    required Color tagTextColor,
    required String avatarUrl,
    required List<Widget> children,
    bool isCompleted = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 10, offset: const Offset(0, 4)),
        ],
        border: isCompleted
            ? const Border(left: BorderSide(color: Color(0xFF3E5C1D), width: 4))
            : const Border(left: BorderSide(color: Color(0xFF2B5B9A), width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 12, color: Colors.black54),
                          const SizedBox(width: 4),
                          Text(location, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(tagText, style: TextStyle(color: tagTextColor, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.grey.shade200, height: 1),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: isCompleted ? 16.0 : 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDynamicPendingCards() {
    final list = <Widget>[];
    for (var order in StockInventoryState.farmerOrders) {
      if (order["vehicleRequested"] == true) {
        list.add(
          _buildBaseCard(
            name: 'Suresh Gowda',
            location: 'Suresh Gowda Farms',
            tagText: 'PENDING',
            tagColor: const Color(0xFFF9E9D5),
            tagTextColor: const Color(0xFFD05C13),
            avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=100',
            children: [
              _buildInfoRow(Icons.inventory_2_outlined, 'Product', '${order["item"]} (${order["quantity"]})'),
              _buildInfoRow(Icons.route_outlined, 'Route', 'Devanahalli -> ${order["buyer"]}'),
              _buildInfoRow(Icons.access_time_outlined, 'Time & Distance', '${order["time"]} • ${order["distance"]}'),
              _buildInfoRow(Icons.phone_outlined, 'Contact', '+91 94480 12345', isBoldValue: true, valueColor: fleetBlue),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F3F8),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: fleetBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          setState(() {
                            order["vehicleRequested"] = false;
                            order["status"] = "Assigned";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Vehicle assigned for Suresh Gowda's delivery!"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: const Text('ASSIGN VEHICLE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 4,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          setState(() {
                            order["vehicleRequested"] = false;
                          });
                        },
                        child: const Text('REJECT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
    return list;
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isBoldValue = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: fleetBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: valueColor ?? Colors.black87,
                    fontWeight: isBoldValue ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
