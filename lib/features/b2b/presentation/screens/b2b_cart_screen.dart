import 'package:flutter/material.dart';
import '../../../dashboard/presentation/screens/b2b_dashboard_screen.dart';
import 'b2b_checkout_screen.dart';
import 'b2b_product_details_screen.dart';
import 'b2b_marketplace_screen.dart';

class B2BCartScreen extends StatefulWidget {
  const B2BCartScreen({super.key});

  @override
  State<B2BCartScreen> createState() => _B2BCartScreenState();
}

class _B2BCartScreenState extends State<B2BCartScreen> {
  List<Map<String, dynamic>> _cartItems = [
    {
      "id": "1",
      "title": "Fresh Tomato (Hybrid)",
      "farmer": "Ramesh Gowda Farms",
      "location": "Kolar, Karnataka",
      "moq": "50 KG",
      "pricePerKg": 18,
      "quantity": 60,
      "imageAsset": "assets/images/farmer_card.png",
    },
    {
      "id": "2",
      "title": "Nasik Red Onion",
      "farmer": "Sai Agro Exports",
      "location": "Nasik, Maharashtra",
      "moq": "100 KG",
      "pricePerKg": 32,
      "quantity": 120,
      "imageAsset": "assets/images/logo_illustration.png",
    },
    {
      "id": "3",
      "title": "Organic Potatoes",
      "farmer": "Green Valley Co-op",
      "location": "Hassan, Karnataka",
      "moq": "100 KG",
      "pricePerKg": 24,
      "quantity": 150,
      "imageAsset": "assets/images/fleet_card.png",
    }
  ];

  final int _logistics = 500;

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQty = _cartItems[index]["quantity"] + delta;
      // Extract moq number
      String moqStr = _cartItems[index]["moq"].toString().replaceAll(RegExp(r'[^0-9]'), '');
      int moq = int.tryParse(moqStr) ?? 10;
      if (newQty >= moq) {
        _cartItems[index]["quantity"] = newQty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color rustBrown = Color(0xFFAD521B);
    const Color bgBeige = Color(0xFFFFFCE4);

    final int totalItems = _cartItems.length;
    int totalWeight = 0;
    int itemsTotal = 0;
    for (var item in _cartItems) {
      totalWeight += item["quantity"] as int;
      itemsTotal += (item["quantity"] as int) * (item["pricePerKg"] as int);
    }
    final int grandTotal = itemsTotal + (totalItems > 0 ? _logistics : 0);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: rustBrown,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bulk Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 14,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _cartItems.isEmpty 
        ? const Center(child: Text("Cart is Empty", style: TextStyle(fontSize: 16, color: Colors.black54)))
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EDE0),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFE5D5C5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shopping_bag_outlined, color: rustBrown, size: 18),
                          const SizedBox(width: 8),
                          Text('$totalItems Products Added', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6ECC1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.local_shipping_outlined, color: Color(0xFF3E5C1D), size: 14),
                            SizedBox(width: 4),
                            Text('1-2 Days', style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 11, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Cart Items
                ...List.generate(_cartItems.length, (index) {
                  final item = _cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildCartItem(
                      index: index,
                      item: item,
                      onIncrease: () => _updateQuantity(index, 10),
                      onDecrease: () => _updateQuantity(index, -10),
                      onDelete: () => _removeItem(index),
                    ),
                  );
                }),
                const SizedBox(height: 16),

                // Payment Summary
                if (_cartItems.isNotEmpty) ...[
                  const Text(
                    'PAYMENT SUMMARY',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                      color: Colors.black54,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EDE0),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: const Color(0xFFE5D5C5)),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow('Total Items', '$totalItems Items'),
                        const SizedBox(height: 12),
                        _buildSummaryRow('Total Weight', '$totalWeight KG'),
                        const SizedBox(height: 12),
                        _buildSummaryRow('Est. Logistics', '₹$_logistics', isValueGreen: true),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(height: 1, color: Colors.black26),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Grand Total',
                              style: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'serif'),
                            ),
                            Text(
                              '₹$grandTotal',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: rustBrown, fontFamily: 'serif'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Spacing for bottom actions
                ]
              ],
            ),
          ),
      bottomSheet: _cartItems.isEmpty ? const SizedBox.shrink() : Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: bgBeige,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: rustBrown,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 2,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const B2BCheckoutScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const B2BDashboardScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const B2BMarketplaceScreen()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: rustBrown,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required int index,
    required Map<String, dynamic> item,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
    required VoidCallback onDelete,
  }) {
    const Color rustBrown = Color(0xFFAD521B);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const B2BProductDetailsScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    item["imageAsset"],
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item["title"],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'serif', color: Colors.black87),
                            ),
                          ),
                          GestureDetector(
                            onTap: onDelete,
                            child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(item["farmer"], style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 12, color: Colors.black45),
                          const SizedBox(width: 4),
                          Text(item["location"], style: const TextStyle(fontSize: 10, color: Colors.black45)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('MOQ: ${item["moq"]}', style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w600)),
                          Row(
                            children: const [
                              Icon(Icons.check_circle, color: Color(0xFF3E5C1D), size: 12),
                              SizedBox(width: 4),
                              Text('MOQ MET', style: TextStyle(color: Color(0xFF3E5C1D), fontSize: 9, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(height: 1, color: Colors.black12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: ₹${item["pricePerKg"]}/KG', style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(
                      '₹${(item["pricePerKg"] as int) * (item["quantity"] as int)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: rustBrown, fontFamily: 'serif'),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EDE0),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFE5D5C5)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: rustBrown, size: 16),
                        onPressed: onDecrease,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: EdgeInsets.zero,
                      ),
                      Container(
                        color: Colors.white,
                        width: 40,
                        height: 32,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${item["quantity"]}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                            const Text('KG', style: TextStyle(fontSize: 7, color: Colors.black54, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: rustBrown, size: 16),
                        onPressed: onIncrease,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isValueGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold, fontFamily: 'serif'),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
            color: isValueGreen ? const Color(0xFF3E5C1D) : Colors.black87,
          ),
        ),
      ],
    );
  }
}
