import 'package:flutter/material.dart';
import 'b2b_marketplace_screen.dart';

class B2BFilterScreen extends StatefulWidget {
  const B2BFilterScreen({super.key});

  @override
  State<B2BFilterScreen> createState() => _B2BFilterScreenState();
}

class _B2BFilterScreenState extends State<B2BFilterScreen> {
  final List<String> _categories = ["Vegetables", "Fruits", "Dairy", "Grains", "Poultry", "Spices"];
  final Set<String> _selectedCategories = {"Fruits"};

  RangeValues _priceRange = const RangeValues(10, 50);

  final List<String> _locations = ["Kolar", "Mysuru", "Hubballi", "Bengaluru Rural"];
  final Set<String> _selectedLocations = {"Kolar"};

  String _selectedDelivery = "25 KM";
  final List<String> _deliveryOptions = ["Within 10 KM", "25 KM", "50 KM", "Anywhere"];

  int _moq = 50;
  bool _inStockOnly = true;

  @override
  Widget build(BuildContext context) {
    const Color rustBrown = Color(0xFFAD521B);
    const Color bgBeige = Color(0xFFFFFCE4);

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
          'Filter Products',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Reset logic
              setState(() {
                _selectedCategories.clear();
                _priceRange = const RangeValues(10, 50);
                _selectedLocations.clear();
                _selectedDelivery = "Anywhere";
                _moq = 50;
                _inStockOnly = false;
              });
            },
            child: const Text('Reset', style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Category
            _buildSectionCard(
              title: "Product Category",
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategories.contains(cat);
                  return FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        if (val) {
                          _selectedCategories.add(cat);
                        } else {
                          _selectedCategories.remove(cat);
                        }
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: rustBrown,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                        color: isSelected ? rustBrown : Colors.grey.shade300,
                      ),
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Wholesale Price Range
            _buildSectionCard(
              title: "Wholesale Price Range",
              trailing: Text(
                "₹${_priceRange.start.toInt()}/KG - ₹${_priceRange.end.toInt()}/KG",
                style: const TextStyle(color: rustBrown, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              child: RangeSlider(
                values: _priceRange,
                min: 0,
                max: 200,
                activeColor: rustBrown,
                inactiveColor: const Color(0xFFE5D5C5),
                onChanged: (values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            // Farm Location
            _buildSectionCard(
              title: "Farm Location",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EDE0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(Icons.location_on_outlined, color: Colors.black87, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search farm locations...',
                              hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _locations.map((loc) {
                      final isSelected = _selectedLocations.contains(loc);
                      return FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(loc),
                            if (isSelected) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.close, size: 14, color: Colors.black87),
                            ],
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _selectedLocations.add(loc);
                            } else {
                              _selectedLocations.remove(loc);
                            }
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFFD6ECC1),
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                            color: isSelected ? const Color(0xFFD6ECC1) : Colors.grey.shade300,
                          ),
                        ),
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Delivery Range
            _buildSectionCard(
              title: "Delivery Range",
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _deliveryOptions.map((opt) {
                  final isSelected = _selectedDelivery == opt;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDelivery = opt;
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 72) / 2, // 2 columns roughly
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? rustBrown : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: isSelected ? rustBrown : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        opt,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // MOQ Filter
            _buildSectionCard(
              title: "MOQ Filter",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$_moq KG Minimum",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EDE0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: rustBrown, size: 20),
                          onPressed: () {
                            if (_moq > 10) setState(() => _moq -= 10);
                          },
                          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          "$_moq",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white, size: 20),
                          style: IconButton.styleFrom(
                            backgroundColor: rustBrown,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(8.0)),
                            ),
                          ),
                          onPressed: () {
                            setState(() => _moq += 10);
                          },
                          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // In Stock Only
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "In Stock Only",
                    style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  Switch(
                    value: _inStockOnly,
                    activeThumbColor: Colors.white,
                    activeTrackColor: rustBrown,
                    onChanged: (val) {
                      setState(() {
                        _inStockOnly = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // spacing for bottom bar
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDE0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.info_outline, size: 16, color: rustBrown),
                  SizedBox(width: 8),
                  Text(
                    "24 Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                  ),
                  Text(
                    " Match Your Filters",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: rustBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Apply Filters",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Marketplace is index 1
        onTap: (index) {
          if (index == 0) {
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

  Widget _buildSectionCard({required String title, required Widget child, Widget? trailing}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
