import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/stock_inventory_state.dart';
import 'stock_inventory_dashboard.dart';

class StockItemDetailsScreen extends StatefulWidget {
  final StockItem item;

  const StockItemDetailsScreen({super.key, required this.item});

  @override
  State<StockItemDetailsScreen> createState() => _StockItemDetailsScreenState();
}

class _StockItemDetailsScreenState extends State<StockItemDetailsScreen> {
  final Color navyColor = const Color(0xFF1F3E5A);
  final Color tealAccent = const Color(0xFF0C7A70);
  final Color bgBeige = const Color(0xFFFFFCE4);
  final Color orangeWarning = const Color(0xFFD05C13);
  final Color errorRed = const Color(0xFFC62828);

  late double _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.item.quantity;
  }

  void _showUpdateQuantityDialog() {
    double tempQuantity = _currentQuantity;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Update Quantity",
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curvedValue = CurvedAnimation(parent: anim1, curve: Curves.easeInOut).value;
        return Transform.scale(
          scale: 0.9 + (curvedValue * 0.1),
          child: Opacity(
            opacity: curvedValue,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    title: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Text(
                          "Update Quantity",
                          style: TextStyle(
                            color: navyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.item.name,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        // Circular increment/decrement tools
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (tempQuantity > 0) {
                                  setDialogState(() {
                                    tempQuantity = tempQuantity > 10 ? tempQuantity - 10 : 0;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: bgBeige,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: navyColor.withValues(alpha: 0.2)),
                                ),
                                child: Icon(Icons.remove, color: navyColor, size: 28),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Column(
                              children: [
                                Text(
                                  tempQuantity.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: navyColor,
                                  ),
                                ),
                                Text(
                                  widget.item.unit,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 24),
                            GestureDetector(
                              onTap: () {
                                setDialogState(() {
                                  tempQuantity += 10;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: bgBeige,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: navyColor.withValues(alpha: 0.2)),
                                ),
                                child: Icon(Icons.add, color: navyColor, size: 28),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Informational box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2F3F0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.flash_on_rounded, color: tealAccent, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Confirming will automatically publish/update this listing in the B2B Wholesale Marketplace.",
                                  style: TextStyle(
                                    color: tealAccent,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: navyColor,
                                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: navyColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                setState(() {
                                  _currentQuantity = tempQuantity;
                                  widget.item.quantity = tempQuantity;
                                  widget.item.status = tempQuantity < 1000 ? "Low Stock" : "In Stock";
                                });
                                // Save inside state
                                StockInventoryState.updateStockItem(widget.item);
                                // Publish to marketplace
                                StockInventoryState.sendToMarketplace(widget.item);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Quantity updated & published to Wholesale Marketplace!"),
                                    backgroundColor: navyColor,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Confirm",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _removeStockItem() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Remove Stock Item",
            style: TextStyle(color: navyColor, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Are you sure you want to completely remove ${widget.item.name} from your inventory?",
            style: TextStyle(color: Colors.grey.shade700),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: errorRed,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                StockInventoryState.removeStockItem(widget.item.id);
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StockInventoryDashboard()),
                ); // Return to dashboard
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${widget.item.name} removed from inventory"),
                    backgroundColor: errorRed,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text("Remove", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLowStock = _currentQuantity < 1000;

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: navyColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Item Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Crop image banner with overlap info
              Stack(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.item.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: widget.item.pestResult == "Pest Detected"
                                    ? const Color(0xFFFDE8E8)
                                    : const Color(0xFFE2F3F0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    widget.item.pestResult == "Pest Detected"
                                        ? Icons.warning_amber_rounded
                                        : Icons.check_circle_outline,
                                    color: widget.item.pestResult == "Pest Detected"
                                        ? Colors.red
                                        : tealAccent,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.item.pestResult,
                                    style: TextStyle(
                                      color: widget.item.pestResult == "Pest Detected"
                                          ? Colors.red
                                          : tealAccent,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.item.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Detail Cards
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Main Quantity and Price highlights card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Quantity Available",
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _currentQuantity.toStringAsFixed(0),
                                    style: TextStyle(
                                      color: isLowStock ? orangeWarning : tealAccent,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text(
                                      widget.item.unit,
                                      style: TextStyle(
                                        color: isLowStock ? orangeWarning : tealAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(width: 1, height: 40, color: Colors.grey.shade200),
                          Column(
                            children: [
                              Text(
                                "Price Tag",
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "₹${widget.item.price.toStringAsFixed(0)}",
                                    style: TextStyle(
                                      color: navyColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text(
                                      "/KG",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Information details block
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildDetailRow(Icons.calendar_today_outlined, "Added Date", widget.item.addedDate),
                          const Divider(height: 24),
                          _buildDetailRow(Icons.event_busy_outlined, "Expiry Date", widget.item.expiryDate),
                          const Divider(height: 24),
                          _buildDetailRow(Icons.warehouse_outlined, "Storage Facility", widget.item.storageLocation),
                          const Divider(height: 24),
                          _buildDetailRow(
                            Icons.info_outline_rounded,
                            "Stock Health Status",
                            widget.item.pestResult == "Pest Detected" ? "Attention Needed" : "Excellent Conditions",
                            valueColor: widget.item.pestResult == "Pest Detected" ? orangeWarning : tealAccent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Actions
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navyColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                        elevation: 0,
                      ),
                      onPressed: _showUpdateQuantityDialog,
                      icon: const Icon(Icons.change_circle_outlined, size: 20),
                      label: const Text(
                        "Update Quantity",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: errorRed,
                        side: BorderSide(color: errorRed.withValues(alpha: 0.5), width: 1.5),
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                      ),
                      onPressed: _removeStockItem,
                      icon: const Icon(Icons.delete_outline, size: 20),
                      label: const Text(
                        "Remove Item",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgBeige,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: navyColor, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? navyColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
