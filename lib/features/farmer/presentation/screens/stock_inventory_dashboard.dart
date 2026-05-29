import 'package:flutter/material.dart';
import '../../data/stock_inventory_state.dart';
import 'add_stock_item_screen.dart';
import 'stock_item_details_screen.dart';
import 'stock_orders_screen.dart';
import 'stock_history_screen.dart';
import 'stock_profile_screen.dart';
import '../../../../features/dashboard/presentation/screens/role_selection_screen.dart';

class StockInventoryDashboard extends StatefulWidget {
  const StockInventoryDashboard({super.key});

  @override
  State<StockInventoryDashboard> createState() => _StockInventoryDashboardState();
}

class _StockInventoryDashboardState extends State<StockInventoryDashboard> {
  int _currentIndex = 0;

  final Color navyColor = const Color(0xFF1F3E5A);
  final Color tealAccent = const Color(0xFF0C7A70);
  final Color bgBeige = const Color(0xFFFFFCE4);
  final Color orangeWarning = const Color(0xFFD05C13);

  @override
  Widget build(BuildContext context) {
    // Determine which page to show based on the bottom navigation index
    Widget bodyWidget;
    if (_currentIndex == 0) {
      bodyWidget = _buildHomeTab();
    } else if (_currentIndex == 1) {
      bodyWidget = const StockOrdersScreen();
    } else if (_currentIndex == 2) {
      bodyWidget = const StockHistoryScreen();
    } else {
      bodyWidget = const StockProfileScreen();
    }

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: _currentIndex == 3 ? const Color(0xFFEF9741) : navyColor,
        elevation: 0,
        automaticallyImplyLeading: _currentIndex != 3,
        leading: _currentIndex == 3
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
                  );
                },
              ),
        title: Text(
          _currentIndex == 0
              ? 'Stock Inventory'
              : _currentIndex == 1
                  ? 'Buyer Orders'
                  : _currentIndex == 2
                      ? 'Delivery Details'
                      : 'Edit Profile',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: _currentIndex == 3
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=100',
                    ),
                    backgroundColor: Colors.grey.shade300,
                  ),
                )
              ],
      ),
      body: SafeArea(child: bodyWidget),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: navyColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddStockItemScreen()),
                );
              },
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16.0),
        height: 68,
        decoration: BoxDecoration(
          color: const Color(0xFFDCD6BD), // Custom beige navbar color from mockup
          borderRadius: BorderRadius.circular(34.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.08 * 255).round()),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home, 'Home'),
              _buildNavItem(1, Icons.shopping_cart, 'Orders'),
              _buildNavItem(2, Icons.history, 'History'),
              _buildNavItem(3, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: isSelected
            ? BoxDecoration(
                color: navyColor,
                borderRadius: BorderRadius.circular(20.0),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : navyColor.withValues(alpha: 0.6),
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    final items = StockInventoryState.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Green Welcome Capsule
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF034A44), Color(0xFF0C7A70)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: tealAccent.withAlpha((0.2 * 255).round()),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hello, Suresh',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Manage your farm inventory\nefficiently',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // List of stock items
        Expanded(
          child: items.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _buildStockItemCard(item);
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
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.03 * 255).round()),
                  blurRadius: 12,
                )
              ],
            ),
            child: Icon(Icons.inventory_2_rounded, size: 72, color: navyColor.withValues(alpha: 0.25)),
          ),
          const SizedBox(height: 20),
          Text(
            'Your inventory is empty!',
            style: TextStyle(
              color: navyColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Add your crops or farm items by pressing the "+" button below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockItemCard(StockItem item) {
    bool isLowStock = item.status == "Low Stock";

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.04 * 255).round()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.network(
                    item.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey.shade200, child: const Icon(Icons.image)),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Title, quantity & price info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            color: navyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        // Stock tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isLowStock ? const Color(0xFFFFF0E6) : const Color(0xFFE2F3F0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            item.status,
                            style: TextStyle(
                              color: isLowStock ? orangeWarning : tealAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '${item.quantity.toStringAsFixed(0)} ',
                          style: TextStyle(
                            color: isLowStock ? orangeWarning : tealAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${item.unit} ',
                          style: TextStyle(
                            color: isLowStock ? orangeWarning : tealAccent,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '|  ₹${item.price.toStringAsFixed(0)}/KG',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Pest Warning Tag
                    if (item.pestResult == "Pest Detected")
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDE8E8),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: const Color(0xFFF8B4B4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Pest Detected',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2F3F0),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: const Color(0xFFA3E2D5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_outline, color: tealAccent, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              'Healthy Crop',
                              style: TextStyle(
                                color: tealAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 16),

          // Date and location info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Added', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(item.addedDate, style: TextStyle(color: navyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Expiry', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(item.expiryDate, style: TextStyle(color: navyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.grey.shade600, size: 16),
              const SizedBox(width: 4),
              Text(
                item.storageLocation,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: navyColor,
                    side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  onPressed: () {
                    // Navigate to Edit Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStockItemScreen(itemToEdit: item),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navyColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Navigate to Details Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockItemDetailsScreen(item: item),
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('View Details', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction_rounded, size: 64, color: navyColor.withValues(alpha: 0.4)),
          const SizedBox(height: 16),
          const Text(
            'Under Construction',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
