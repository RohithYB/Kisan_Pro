import 'dart:ui';
import 'package:flutter/material.dart';

class MilkMonitoringScreen extends StatefulWidget {
  const MilkMonitoringScreen({super.key});

  @override
  State<MilkMonitoringScreen> createState() => _MilkMonitoringScreenState();
}

class _MilkMonitoringScreenState extends State<MilkMonitoringScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedShift = 'Morning'; // Morning or Evening

  // Milking entries data. Starts empty as requested!
  final List<Map<String, dynamic>> _milkEntries = [];

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _saveMilkEntry() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final id = _idController.text.trim();
      final qty = double.parse(_quantityController.text.trim());
      
      final now = DateTime.now();
      final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      final String formattedDate = "${now.day} ${months[now.month - 1]} ${now.year}";
      final String formattedTime = "${now.hour > 12 ? now.hour - 12 : now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

      setState(() {
        _milkEntries.insert(0, {
          'name': name,
          'id': id,
          'qty': qty,
          'shift': _selectedShift,
          'date': "$formattedDate • $formattedTime",
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logged $qty Liters for $name successfully!"),
          backgroundColor: const Color(0xFF0C7A70),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Clear input fields
      _nameController.clear();
      _idController.clear();
      _quantityController.clear();
    }
  }

  // Opens Backdrop blur popup modal report matching PNG 2
  void _openMilkReportModal(BuildContext context, Map<String, dynamic> entry) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Milk Report Modal',
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (ctx, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0 * anim1.value,
            sigmaY: 5.0 * anim1.value,
          ),
          child: FadeTransition(
            opacity: anim1,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(anim1),
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: MilkReportPopupDialog(entry: entry),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color tealHeader = Color(0xFF0C7A70);
    const Color bgBeige = Color(0xFFFFFCE4);
    const Color inputBg = Color(0xFFFFFBE4); // Pale yellow-cream matching input background

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Milk Monitoring',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealHeader,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Milk Entry Forms Card matching PNG 1
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFDF5),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.04 * 255).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CATTLE NAME
                      const Text(
                        "CATTLE NAME",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _nameController,
                        validator: (v) => v == null || v.trim().isEmpty ? 'Enter cattle name' : null,
                        decoration: InputDecoration(
                          hintText: "Enter cattle name",
                          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13, fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: inputBg,
                          prefixIcon: const Icon(Icons.pets_rounded, color: Colors.black38, size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // CATTLE ID
                      const Text(
                        "CATTLE ID",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _idController,
                        validator: (v) => v == null || v.trim().isEmpty ? 'Enter cattle ID' : null,
                        decoration: InputDecoration(
                          hintText: "Enter cattle ID",
                          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13, fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: inputBg,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("#", style: TextStyle(color: Colors.black38, fontSize: 18, fontWeight: FontWeight.w900)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // MILKING TIME select
                      const Text(
                        "MILKING TIME",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Morning Button
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedShift = 'Morning';
                                });
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _selectedShift == 'Morning' ? tealHeader : Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: _selectedShift == 'Morning' ? tealHeader : Colors.black12,
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wb_sunny_outlined,
                                      color: _selectedShift == 'Morning' ? Colors.white : Colors.black87,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Morning",
                                      style: TextStyle(
                                        color: _selectedShift == 'Morning' ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Evening Button
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedShift = 'Evening';
                                });
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _selectedShift == 'Evening' ? tealHeader : Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: _selectedShift == 'Evening' ? tealHeader : Colors.black12,
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.nights_stay_outlined,
                                      color: _selectedShift == 'Evening' ? Colors.white : Colors.black87,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Evening",
                                      style: TextStyle(
                                        color: _selectedShift == 'Evening' ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // QUANTITY (LITERS)
                      const Text(
                        "QUANTITY (LITERS)",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _quantityController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Enter milk quantity';
                          if (double.tryParse(v) == null) return 'Enter a valid number';
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter milk quantity in lit",
                          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13, fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: inputBg,
                          prefixIcon: const Icon(Icons.opacity_rounded, color: Colors.black38, size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Save Milk Entry Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tealHeader,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.0),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _saveMilkEntry,
                          icon: const Icon(Icons.save_rounded, size: 20),
                          label: const Text(
                            "Save Milk Entry",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                // 2. Recent Entries List matching PNG 1
                const Text(
                  "Recent Entries",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Dynamic empty yield template checks
                _milkEntries.isEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFDF5),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Colors.black.withAlpha((0.05 * 255).round())),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.opacity_rounded, size: 54, color: Colors.black26),
                            SizedBox(height: 12),
                            Text(
                              "No Milking Entries Yet",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black45),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Start recording milk yields above to populate reports.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.black26, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _milkEntries.length,
                        itemBuilder: (context, index) {
                          final entry = _milkEntries[index];
                          final bool isMorning = entry['shift'] == 'Morning';

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFDF5),
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha((0.02 * 255).round()),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16.0),
                                onTap: () => _openMilkReportModal(context, entry),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                                  child: Row(
                                    children: [
                                      // Orange circular paw avatar matching PNG 1
                                      Container(
                                        width: 46,
                                        height: 46,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF39C12), // Orange avatar
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.pets_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 14),

                                      // Name & ID
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              entry['name'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "ID: ${entry['id']}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            // Shift & Date row
                                            Row(
                                              children: [
                                                Icon(
                                                  isMorning ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined,
                                                  color: Colors.black38,
                                                  size: 13,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  entry['shift'],
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  entry['date'].split('•')[0].trim(),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Quantity badge tag
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8F5E9), // Light green tag bg
                                          borderRadius: BorderRadius.circular(14.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.opacity_rounded, color: Color(0xFF0C7A70), size: 12),
                                            const SizedBox(width: 2),
                                            Text(
                                              "${entry['qty']} L",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xFF0C7A70),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// High-fidelity Milk Analysis Report Dialog matching PNG 2
// -------------------------------------------------------------
class MilkReportPopupDialog extends StatefulWidget {
  final Map<String, dynamic> entry;

  const MilkReportPopupDialog({super.key, required this.entry});

  @override
  State<MilkReportPopupDialog> createState() => _MilkReportPopupDialogState();
}

class _MilkReportPopupDialogState extends State<MilkReportPopupDialog> {
  String _activeChip = 'Weekly'; // Daily, Weekly, Monthly

  @override
  Widget build(BuildContext context) {
    const Color tealHeader = Color(0xFF0C7A70);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCE4), // Beige card background matching dialog
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with close trigger
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.opacity_rounded, color: tealHeader, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.entry['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        "Milk Report • ${widget.entry['id']}",
                        style: const TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close_rounded, color: Colors.black54, size: 26),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Filters row Daily, Weekly, Monthly matching PNG 2
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFilterChip('Daily'),
              const SizedBox(width: 8),
              _buildFilterChip('Weekly'),
              const SizedBox(width: 8),
              _buildFilterChip('Monthly'),
            ],
          ),

          const SizedBox(height: 20),

          // Total Milk Production Card
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF5),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.black.withAlpha((0.03 * 255).round())),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Total Milk Production",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black45),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: const [
                    Text(
                      "240",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: tealHeader),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Liters",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Avg Daily", style: TextStyle(fontSize: 10, color: Colors.black38, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text("8 L", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("Best Day", style: TextStyle(fontSize: 10, color: Colors.black38, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text("Monday", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87)),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Weekly custom-painted bar chart matching PNG 2
                SizedBox(
                  height: 90,
                  child: CustomPaint(
                    painter: WeeklyBarChartPainter(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Bottom Morning/Evening 4-box grids matching PNG 2
          Row(
            children: [
              Expanded(
                child: _buildGridItem(
                  Icons.wb_sunny_outlined,
                  "Morning Milk",
                  "${widget.entry['qty']} L",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildGridItem(
                  Icons.nights_stay_outlined,
                  "Evening Milk",
                  "10 L", // Default/simulated comparison
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildGridItem(
                  Icons.bar_chart_rounded,
                  "Total Prd.",
                  "${widget.entry['qty'] + 10} L",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildGridItem(
                  Icons.calendar_today_outlined,
                  "Last Recorded",
                  widget.entry['date'].split('•')[0].trim(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // Generate Report Button
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: tealHeader,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.0),
                ),
                elevation: 0,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Milk yield statistics report generated & saved!"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text(
                "Generate Report",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _activeChip == label;
    const Color tealHeader = Color(0xFF0C7A70);

    return InkWell(
      onTap: () {
        setState(() {
          _activeChip = label;
        });
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? tealHeader : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: isSelected ? tealHeader : Colors.black26, width: 0.8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String title, String val) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black.withAlpha((0.02 * 255).round())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black38, size: 14),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 9, color: Colors.black38, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            val,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// Paints the dynamic bar chart inside analysis modal matching PNG 2
class WeeklyBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Color tealHeader = Color(0xFF0C7A70);
    final Color inactiveColor = tealHeader.withAlpha((0.25 * 255).round());

    final Paint barPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final double width = size.width;
    final double height = size.height;

    // 7 days bar metrics (Monday is the active best day!)
    final List<double> barRatios = [0.85, 0.45, 0.55, 0.38, 0.62, 0.78, 0.50];

    final double barWidth = 10.0;
    final double space = (width - (7 * barWidth)) / 6;

    for (int i = 0; i < 7; i++) {
      final double barHeight = height * barRatios[i];
      final double left = i * (barWidth + space);
      final double top = height - barHeight;

      // Monday (index 0) and Friday (index 4) are highlighted best days matching PNG 2
      final bool isActive = i == 0 || i == 4;
      barPaint.color = isActive ? tealHeader : inactiveColor;

      // Draw rounded rectangle bar
      final RRect rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barWidth, barHeight),
        const Radius.circular(5.0),
      );
      canvas.drawRRect(rect, barPaint);

      // Subtle active best day top glowing point
      if (isActive) {
        final Paint dotPaint = Paint()..color = tealHeader;
        canvas.drawCircle(Offset(left + barWidth / 2, top - 4), 2.5, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
