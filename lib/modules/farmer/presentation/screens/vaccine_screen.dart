import 'dart:ui';
import 'package:flutter/material.dart';

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({super.key});

  @override
  State<VaccineScreen> createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  final _cattleNameController = TextEditingController();
  final _cattleIdController = TextEditingController();
  final _vaccineNameController = TextEditingController();
  final _vaccineDateController = TextEditingController();

  final _remVaccineNameController = TextEditingController();
  final _remVaccineDateController = TextEditingController();
  final _remDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _remFormKey = GlobalKey<FormState>();

  // Vaccine logs. Starts empty!
  final List<Map<String, dynamic>> _vaccineLogs = [];

  @override
  void dispose() {
    _cattleNameController.dispose();
    _cattleIdController.dispose();
    _vaccineNameController.dispose();
    _vaccineDateController.dispose();
    _remVaccineNameController.dispose();
    _remVaccineDateController.dispose();
    _remDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0C7A70),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final months = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ];
        controller.text =
            "${picked.day} ${months[picked.month - 1]} ${picked.year}";
      });
    }
  }

  void _saveVaccineEntry() {
    if (_formKey.currentState!.validate()) {
      final name = _cattleNameController.text.trim();
      final id = _cattleIdController.text.trim();
      final vaccine = _vaccineNameController.text.trim();
      final date = _vaccineDateController.text.trim();

      setState(() {
        _vaccineLogs.insert(0, {
          'name': name,
          'id': id,
          'vaccine': vaccine,
          'date': date,
          'nextReminder': '20 June 2026', // Simulated default scheduler
          'isStarred': name.toLowerCase() == 'lakshmi', // Lakshmi has gold star
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Vaccine scheduled: $vaccine for $name successfully!"),
          backgroundColor: const Color(0xFF0C7A70),
          behavior: SnackBarBehavior.floating,
        ),
      );

      _cattleNameController.clear();
      _cattleIdController.clear();
      _vaccineNameController.clear();
      _vaccineDateController.clear();
    }
  }

  void _showCalendarCalendarAccessDialog() {
    if (_remFormKey.currentState!.validate()) {
      const Color tealHeader = Color(0xFF0C7A70);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: const Color(0xFFFFFCE4),
          title: Row(
            children: const [
              Icon(Icons.calendar_month_rounded, color: tealHeader),
              SizedBox(width: 10),
              Text(
                "Calendar Sync",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            "Kisan Pro would like to pair this reminder with Google Calendar / System Alarm channels to trigger push alerts when doses are due.",
            style: TextStyle(color: Colors.black87, height: 1.3),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Deny",
                style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: tealHeader,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Reminder for '${_remVaccineNameController.text.trim()}' paired with Google Calendar!",
                    ),
                    backgroundColor: tealHeader,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                _remVaccineNameController.clear();
                _remVaccineDateController.clear();
                _remDescriptionController.clear();
              },
              child: const Text("Allow Access"),
            ),
          ],
        ),
      );
    }
  }

  // Opens Backdrop blur popup preview report matching PNG 4
  void _openVaccineReportModal(BuildContext context, Map<String, dynamic> log) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Vaccine Report Modal',
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
                child: VaccineReportPopupDialog(log: log),
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
    const Color inputBg = Color(0xFFFFFBE4);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Vaccination Monitoring',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. New Vaccine Entry Form matching PNG 3
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF5),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.04 * 255).round()),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.vaccines_rounded,
                            color: tealHeader,
                            size: 22,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "New Vaccine Entry",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: tealHeader,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Cattle Name
                      const Text(
                        "Cattle Name",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _cattleNameController,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Enter cattle name'
                            : null,
                        decoration: InputDecoration(
                          hintText: "e.g. Lakshmi",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Cattle ID
                      const Text(
                        "Cattle ID",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _cattleIdController,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Enter cattle ID'
                            : null,
                        decoration: InputDecoration(
                          hintText: "e.g. KP-204",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Vaccine Name
                      const Text(
                        "Vaccine Name",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _vaccineNameController,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Enter vaccine name'
                            : null,
                        decoration: InputDecoration(
                          hintText: "Enter Vaccine name",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Vaccine Date
                      const Text(
                        "Vaccine Date",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _vaccineDateController,
                        readOnly: true,
                        onTap: () => _selectDate(_vaccineDateController),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Select date'
                            : null,
                        decoration: InputDecoration(
                          hintText: "mm/dd/yyyy",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: inputBg,
                          prefixIcon: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.black38,
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Save Vaccine Entry Button
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
                          onPressed: _saveVaccineEntry,
                          icon: const Icon(Icons.save_rounded, size: 18),
                          label: const Text(
                            "Save Vaccine Entry",
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

              const SizedBox(height: 20),

              // 2. Vaccination Remainder Forms Card matching PNG 3
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF5),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.04 * 255).round()),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _remFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.alarm_add_rounded,
                            color: tealHeader,
                            size: 22,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Vaccination Remainder(optional)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: tealHeader,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Vaccine Name
                      const Text(
                        "Vaccine Name",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _remVaccineNameController,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Enter reminder vaccine name'
                            : null,
                        decoration: InputDecoration(
                          hintText: "Enter Vaccine name",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Vaccine Date
                      const Text(
                        "Vaccine Date",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _remVaccineDateController,
                        readOnly: true,
                        onTap: () => _selectDate(_remVaccineDateController),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Select date'
                            : null,
                        decoration: InputDecoration(
                          hintText: "mm/dd/yyyy",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: inputBg,
                          prefixIcon: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.black38,
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Description
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _remDescriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Type here",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: inputBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(14.0),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Set Vaccination Remainder Button
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
                          onPressed: _showCalendarCalendarAccessDialog,
                          icon: const Icon(Icons.alarm_rounded, size: 18),
                          label: const Text(
                            "Set Vaccination Remainder",
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

              const SizedBox(height: 26),

              // Recent Logs Grid
              const Text(
                "Recent Logs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Dynamic empty roster lists checks
              _vaccineLogs.isEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 48,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF5),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.black.withAlpha((0.05 * 255).round()),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 54,
                            color: Colors.black26,
                          ),
                          SizedBox(height: 12),
                          Text(
                            "No Vaccinations Logged Yet",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Record vaccine entries above to see logs & immunization history reports.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.05,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: _vaccineLogs.length,
                      itemBuilder: (context, index) {
                        final log = _vaccineLogs[index];

                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFDF5),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Colors.black.withAlpha(
                                (0.02 * 255).round(),
                              ),
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16.0),
                            onTap: () => _openVaccineReportModal(context, log),
                            child: Stack(
                              children: [
                                // Info Layout
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE8F5E9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.pets_rounded,
                                              color: tealHeader,
                                              size: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  log['name'],
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Text(
                                                  log['id'],
                                                  style: const TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      // Syringe & Vaccine name
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.vaccines_rounded,
                                            color: Colors.black38,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              log['vaccine'],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),

                                      // Date
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today_rounded,
                                            color: Colors.black38,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            log['date'],
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Spacer(),

                                      // NEXT REMINDER
                                      const Text(
                                        "NEXT REMINDER:",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        log['nextReminder'],
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF27AE60),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Top Right star badge for Lakshmi matching PNG 3
                                if (log['isStarred'])
                                  const Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFF39C12),
                                      size: 18,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// High-fidelity Vaccine Preview Report Dialog matching PNG 4
// -------------------------------------------------------------
class VaccineReportPopupDialog extends StatefulWidget {
  final Map<String, dynamic> log;

  const VaccineReportPopupDialog({super.key, required this.log});

  @override
  State<VaccineReportPopupDialog> createState() =>
      _VaccineReportPopupDialogState();
}

class _VaccineReportPopupDialogState extends State<VaccineReportPopupDialog> {
  String _activeChip = 'Daily';

  @override
  Widget build(BuildContext context) {
    const Color tealHeader = Color(0xFF0C7A70);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCE4), // Beige card background
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Lakshmi Vaccine Report Header exactly matching PNG 4
          Text(
            "${widget.log['name']} Vaccine\nReport",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: tealHeader,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Vaccination history for ${widget.log['id']}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          // Filters row
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

          // Chart Display box
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF5),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.black.withAlpha((0.03 * 255).round()),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "TOTAL VACCINATIONS",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "08",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: tealHeader,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "LAST DOSE",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.log['vaccine'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          widget.log['date'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: tealHeader,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Vaccine dynamic hist chart custom-painted
                SizedBox(
                  height: 60,
                  child: CustomPaint(painter: HistVaccineChartPainter()),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Lower Grid box
          Row(
            children: [
              Expanded(
                child: _buildGridItem(
                  Icons.local_hospital_outlined,
                  "Vaccine Type",
                  widget.log['vaccine'],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildGridItem(
                  Icons.calendar_today_outlined,
                  "Administered",
                  widget.log['date'],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Download Action button matching PNG 4
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
                    content: Text(
                      "Vaccination history report downloaded successfully!",
                    ),
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

          const SizedBox(height: 10),

          // Red Close Preview button matching PNG 4
          SizedBox(
            height: 52,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF8B0000), // Dark warning red
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.0),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Close Preview",
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
          border: Border.all(
            color: isSelected ? tealHeader : Colors.black26,
            width: 0.8,
          ),
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
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            val,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom bar chart rendering historical doses matching PNG 4
class HistVaccineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Color tealHeader = Color(0xFF0C7A70);
    final Color inactiveColor = tealHeader.withAlpha((0.2 * 255).round());

    final Paint barPaint = Paint()..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    // 7 dose timing bars
    final List<double> barRatios = [0.35, 0.48, 0.22, 0.58, 0.40, 0.32, 0.82];

    final double barWidth = 24.0;
    final double space = (width - (7 * barWidth)) / 6;

    for (int i = 0; i < 7; i++) {
      final double barHeight = height * barRatios[i];
      final double left = i * (barWidth + space);
      final double top = height - barHeight;

      // The last/newest dose (index 6) is active/highlighted in solid green matching PNG 4
      final bool isActive = i == 6;
      barPaint.color = isActive ? tealHeader : inactiveColor;

      final RRect rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barWidth, barHeight),
        const Radius.circular(3.0),
      );
      canvas.drawRRect(rect, barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
