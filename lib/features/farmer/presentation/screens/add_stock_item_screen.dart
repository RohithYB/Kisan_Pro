import 'package:flutter/material.dart';
import '../../data/stock_inventory_state.dart';
import 'stock_inventory_dashboard.dart';

class AddStockItemScreen extends StatefulWidget {
  final StockItem? itemToEdit;

  const AddStockItemScreen({super.key, this.itemToEdit});

  @override
  State<AddStockItemScreen> createState() => _AddStockItemScreenState();
}

class _AddStockItemScreenState extends State<AddStockItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _addedDateController;
  late TextEditingController _quantityController;
  late TextEditingController _expiryDateController;
  late TextEditingController _priceController;
  late TextEditingController _locationController;

  String _selectedUnit = "KG";
  String _selectedPestResult = "Healthy";
  String? _uploadedImagePath;

  final Color navyColor = const Color(0xFF1F3E5A);
  final Color bgBeige = const Color(0xFFFFFCE4);
  final Color inputBg = const Color(0xFFFFFDF0);

  @override
  void initState() {
    super.initState();
    final item = widget.itemToEdit;
    _nameController = TextEditingController(text: item?.name ?? "");
    _addedDateController = TextEditingController(text: item?.addedDate ?? "");
    _quantityController = TextEditingController(text: item != null ? item.quantity.toString() : "");
    _expiryDateController = TextEditingController(text: item?.expiryDate ?? "");
    _priceController = TextEditingController(text: item != null ? item.price.toString() : "");
    _locationController = TextEditingController(text: item?.storageLocation ?? "");
    
    if (item != null) {
      _selectedUnit = item.unit;
      _selectedPestResult = item.pestResult == "Healthy Crop" ? "Healthy" : "Pest Detected";
      _uploadedImagePath = item.imagePath;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addedDateController.dispose();
    _quantityController.dispose();
    _expiryDateController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return "${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}";
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: navyColor,
              onPrimary: Colors.white,
              onSurface: navyColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = _formatDate(picked);
      });
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final addedDate = _addedDateController.text.trim();
      final quantity = double.tryParse(_quantityController.text.trim()) ?? 0.0;
      final expiryDate = _expiryDateController.text.trim();
      final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
      final location = _locationController.text.trim();

      // Determine pest display and status
      final pestDisplay = _selectedPestResult == "Healthy" ? "Healthy Crop" : "Pest Detected";
      final status = quantity < 1000 ? "Low Stock" : "In Stock";
      
      // Determine placeholder image depending on item name
      String defaultImg = "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400"; // Tomato default
      if (name.toLowerCase().contains("potato")) {
        defaultImg = "https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400";
      } else if (name.toLowerCase().contains("onion")) {
        defaultImg = "https://images.unsplash.com/photo-1620574387735-3624d75b2dbc?w=400";
      } else if (name.toLowerCase().contains("carrot")) {
        defaultImg = "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=400";
      }

      final imagePath = _uploadedImagePath ?? defaultImg;

      if (widget.itemToEdit != null) {
        // Edit existing
        final updated = StockItem(
          id: widget.itemToEdit!.id,
          name: name,
          imagePath: imagePath,
          addedDate: addedDate,
          quantity: quantity,
          expiryDate: expiryDate,
          price: price,
          storageLocation: location,
          pestResult: pestDisplay,
          status: status,
          unit: _selectedUnit,
        );
        StockInventoryState.updateStockItem(updated);
      } else {
        // Create new
        final newItem = StockItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          imagePath: imagePath,
          addedDate: addedDate,
          quantity: quantity,
          expiryDate: expiryDate,
          price: price,
          storageLocation: location,
          pestResult: pestDisplay,
          status: status,
          unit: _selectedUnit,
        );
        StockInventoryState.addStockItem(newItem);
      }

      // Automatically sync or make available for marketplace if quantity update or add
      // We can let them view it in B2B
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.itemToEdit != null ? "Item updated successfully!" : "Item added to Inventory!"),
          backgroundColor: navyColor,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StockInventoryDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: bgBeige,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: navyColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.itemToEdit != null ? 'Edit Stock Item' : 'Add Stock Item',
          style: TextStyle(
            color: navyColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.04 * 255).round()),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Item Name Field
                  _buildLabel('Item Name'),
                  TextFormField(
                    controller: _nameController,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Enter item name' : null,
                    decoration: _inputDecoration('Enter item name'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  // Upload crop photo Container
                  _buildLabel('Upload Item Photo'),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Simulate camera upload
                        _uploadedImagePath = "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400"; // Simulation
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Crop photo simulated successfully!"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: inputBg,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: navyColor.withAlpha((0.3 * 255).round()),
                          width: 1.5,
                          style: BorderStyle.solid, // solid representation for clean dashed-like borders
                        ),
                      ),
                      child: _uploadedImagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(_uploadedImagePath!, fit: BoxFit.cover),
                                  Container(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.check_circle, color: Colors.white, size: 40),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.cloud_upload_outlined, color: navyColor, size: 28),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Upload crop/product image',
                                  style: TextStyle(
                                    color: navyColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'JPG, PNG up to 5MB',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Added Date
                  _buildLabel('Added Date'),
                  TextFormField(
                    controller: _addedDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, _addedDateController),
                    validator: (v) => v == null || v.isEmpty ? 'Select added date' : null,
                    decoration: _inputDecoration('mm/dd/yyyy').copyWith(
                      suffixIcon: Icon(Icons.calendar_today_outlined, color: navyColor),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quantity (with Unit selector side-by-side)
                  _buildLabel('Quantity'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _quantityController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (v) => v == null || double.tryParse(v) == null ? 'Enter valid number' : null,
                          decoration: _inputDecoration('0.00'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: inputBg,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedUnit,
                              icon: Icon(Icons.keyboard_arrow_down_rounded, color: navyColor),
                              items: ["KG", "Tons", "Boxes"].map((unit) {
                                return DropdownMenuItem<String>(
                                  value: unit,
                                  child: Text(
                                    unit,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedUnit = val;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Expiry Date
                  _buildLabel('Expiry Date'),
                  TextFormField(
                    controller: _expiryDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, _expiryDateController),
                    validator: (v) => v == null || v.isEmpty ? 'Select expiry date' : null,
                    decoration: _inputDecoration('mm/dd/yyyy').copyWith(
                      suffixIcon: Icon(Icons.calendar_today_outlined, color: navyColor),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Price
                  _buildLabel('Price'),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) => v == null || double.tryParse(v) == null ? 'Enter valid price' : null,
                    decoration: _inputDecoration('Enter price').copyWith(
                      prefixIcon: Icon(Icons.currency_rupee_rounded, color: navyColor, size: 20),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Storage Location (with auto-fill location button beside it)
                  _buildLabel('Storage Location'),
                  TextFormField(
                    controller: _locationController,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Enter storage location' : null,
                    decoration: _inputDecoration('e.g. Cold Storage A').copyWith(
                      prefixIcon: Icon(Icons.warehouse_outlined, color: navyColor),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.my_location_rounded, color: navyColor),
                        onPressed: () {
                          setState(() {
                            _locationController.text = "Cold Storage A, Devanahalli";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Auto-filled storage location!"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Pest Result Dropdown
                  _buildLabel('Pest Result'),
                  Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: inputBg,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPestResult,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: navyColor),
                        items: ["Healthy", "Pest Detected"].map((result) {
                          return DropdownMenuItem<String>(
                            value: result,
                            child: Text(
                              result,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedPestResult = val;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Add Inventory Action Button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navyColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _saveItem,
                      icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
                      label: Text(
                        widget.itemToEdit != null ? 'Update Inventory' : 'Add Inventory',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cancel Button
                  SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: navyColor,
                        side: BorderSide(color: navyColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                      ),
                      onPressed: () {
                        // Go back or to dashboard
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const StockInventoryDashboard()),
                        );
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: navyColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.normal),
      filled: true,
      fillColor: inputBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: navyColor, width: 1.5),
      ),
    );
  }
}
