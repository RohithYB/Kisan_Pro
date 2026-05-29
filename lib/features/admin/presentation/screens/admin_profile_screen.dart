import 'dart:ui';
import 'package:kisan_pro_jrf/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'admin_login_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  // State variables for Admin Profile details
  String _fullName = "KisanPro Administrator";
  final String _employeeId = "ADM-2024-0891"; // Read-only
  String _emailAddress = "admin@kisanpro.gov.in";
  String _contactNumber = "+91 98765 43210";
  String _assignedRegion = "Maharashtra - Pune Hub";

  String _newPassword = "••••••••";
  String _confirmNewPassword = "••••••••";

  bool _emailAlerts = true;
  bool _systemPushNotifications = true;
  bool _criticalSecurityUpdates = true;
  bool _weeklyReports = false;

  final String _activeSince = "January 12, 2024";
  final String _permissionGroup = "Super Admin Level 1";

  // List of regions for Assigned Region dropdown
  final List<String> _regionsList = [
    "Maharashtra - Pune Hub",
    "Karnataka - Bengaluru Hub",
    "Tamil Nadu - Chennai Hub",
    "Delhi NCR - Noida Hub",
    "Gujarat - Ahmedabad Hub"
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color bgSlate = AppColors.bgSlate;
    const Color cardBorderColor = Color(0xFFEDF2F7);

    return Scaffold(
      backgroundColor: bgSlate,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: primaryPurple),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Admin Profile",
          style: TextStyle(
            color: AppColors.textNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Card (Avatar, Name, Role Badge)
              _buildProfileHeaderCard(),
              const SizedBox(height: 20),

              // 1. Personal Information Section
              _buildPersonalInformationSection(cardBorderColor),
              const SizedBox(height: 16),

              // 2. Security & Password Section
              _buildSecurityPasswordSection(cardBorderColor),
              const SizedBox(height: 16),

              // 3. Notification Preferences Section
              _buildNotificationPreferencesSection(cardBorderColor),
              const SizedBox(height: 16),

              // 4. System Access Level Section (Not editable)
              _buildSystemAccessLevelSection(cardBorderColor),
              const SizedBox(height: 24),

              // Bottom Buttons
              _buildBottomActionButtons(primaryPurple),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI WIDGET BUILDERS ---

  Widget _buildProfileHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryPurple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Admin Name
          const Text(
            "KisanPro Admin",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.textNavy,
            ),
          ),
          const SizedBox(height: 6),

          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFECEBFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Executive Controller",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInformationSection(Color borderColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.01 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.business_center_rounded, color: AppColors.primaryPurple, size: 20),
              SizedBox(width: 10),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildProfileDetailItem("Full Name", _fullName),
          const SizedBox(height: 14),
          _buildProfileDetailItem("Employee ID", _employeeId),
          const SizedBox(height: 14),
          _buildProfileDetailItem("Email Address", _emailAddress),
          const SizedBox(height: 14),
          _buildProfileDetailItem("Contact Number", _contactNumber),
          const SizedBox(height: 14),
          _buildProfileDetailItem("Assigned Region", _assignedRegion),
        ],
      ),
    );
  }

  Widget _buildSecurityPasswordSection(Color borderColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.01 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.history_rounded, color: AppColors.dangerRed, size: 20),
              SizedBox(width: 10),
              Text(
                "Security & Password",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dangerRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildProfileDetailItem("New Password", _newPassword, isObscure: true),
          const SizedBox(height: 14),
          _buildProfileDetailItem("Confirm New Password", _confirmNewPassword, isObscure: true),
          const SizedBox(height: 12),
          const Text(
            "Last changed 24 days ago. Password must be at least 12 characters.",
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationPreferencesSection(Color borderColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.01 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.notifications_active_outlined, color: Color(0xFF0369A1), size: 20),
              SizedBox(width: 10),
              Text(
                "Notification Preferences",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0369A1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildNotificationCheckItem("Email Alerts", _emailAlerts),
          _buildNotificationCheckItem("System Push Notifications", _systemPushNotifications),
          _buildNotificationCheckItem("Critical Security Updates", _criticalSecurityUpdates),
          _buildNotificationCheckItem("Weekly Reports", _weeklyReports),
        ],
      ),
    );
  }

  Widget _buildSystemAccessLevelSection(Color borderColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFECEBFF),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFD9D7FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.verified_user_outlined, color: AppColors.primaryPurple, size: 20),
              SizedBox(width: 10),
              Text(
                "System Access Level",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildProfileDetailItem("Active Since", _activeSince),
          const SizedBox(height: 14),
          _buildProfileDetailItem("Permission Group", _permissionGroup),
        ],
      ),
    );
  }

  Widget _buildProfileDetailItem(String label, String value, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.bgSlate,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCheckItem(String label, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: null, // Read-only on main screen
            activeColor: AppColors.primaryPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons(Color primaryPurple) {
    return Row(
      children: [
        // Log Out Button
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.dangerRed,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              onPressed: () {
                // Log out completely, remove history and head to Login Screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Edit Profile Button
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              onPressed: () => _openEditProfileDialog(),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- EDIT PROFILE DIALOG POPUP WITH BLUR ---

  void _openEditProfileDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "EditProfile",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _EditProfilePopup(
          initialFullName: _fullName,
          initialEmail: _emailAddress,
          initialContact: _contactNumber,
          initialRegion: _assignedRegion,
          initialNewPassword: _newPassword,
          initialConfirmPassword: _confirmNewPassword,
          initialEmailAlerts: _emailAlerts,
          initialPushNotifications: _systemPushNotifications,
          initialCriticalUpdates: _criticalSecurityUpdates,
          initialWeeklyReports: _weeklyReports,
          regionsList: _regionsList,
          employeeId: _employeeId,
          onSave: (updatedData) {
            setState(() {
              _fullName = updatedData['fullName'];
              _emailAddress = updatedData['email'];
              _contactNumber = updatedData['contact'];
              _assignedRegion = updatedData['region'];
              _newPassword = updatedData['newPassword'];
              _confirmNewPassword = updatedData['confirmNewPassword'];
              _emailAlerts = updatedData['emailAlerts'];
              _systemPushNotifications = updatedData['pushNotifications'];
              _criticalSecurityUpdates = updatedData['criticalUpdates'];
              _weeklyReports = updatedData['weeklyReports'];
            });
            ScaffoldMessenger.of(this.context).showSnackBar(
              const SnackBar(
                content: Text('Profile details saved successfully!'),
                backgroundColor: AppColors.successGreen,
              ),
            );
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Blur background animation
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0 * animation.value,
            sigmaY: 5.0 * animation.value,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }
}

// --- STATEFUL EDIT DIALOG WIDGET ---

class _EditProfilePopup extends StatefulWidget {
  final String initialFullName;
  final String employeeId;
  final String initialEmail;
  final String initialContact;
  final String initialRegion;
  final String initialNewPassword;
  final String initialConfirmPassword;
  final bool initialEmailAlerts;
  final bool initialPushNotifications;
  final bool initialCriticalUpdates;
  final bool initialWeeklyReports;
  final List<String> regionsList;
  final Function(Map<String, dynamic>) onSave;

  const _EditProfilePopup({
    required this.initialFullName,
    required this.employeeId,
    required this.initialEmail,
    required this.initialContact,
    required this.initialRegion,
    required this.initialNewPassword,
    required this.initialConfirmPassword,
    required this.initialEmailAlerts,
    required this.initialPushNotifications,
    required this.initialCriticalUpdates,
    required this.initialWeeklyReports,
    required this.regionsList,
    required this.onSave,
  });

  @override
  State<_EditProfilePopup> createState() => _EditProfilePopupState();
}

class _EditProfilePopupState extends State<_EditProfilePopup> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late String _selectedRegion;

  late bool _emailAlerts;
  late bool _pushNotifications;
  late bool _criticalUpdates;
  late bool _weeklyReports;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialFullName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _contactController = TextEditingController(text: widget.initialContact);
    _passwordController = TextEditingController(text: widget.initialNewPassword);
    _confirmPasswordController = TextEditingController(text: widget.initialConfirmPassword);

    _selectedRegion = widget.initialRegion;

    _emailAlerts = widget.initialEmailAlerts;
    _pushNotifications = widget.initialPushNotifications;
    _criticalUpdates = widget.initialCriticalUpdates;
    _weeklyReports = widget.initialWeeklyReports;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = AppColors.primaryPurple;
    const Color lightPurple = Color(0xFF6B58F2);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      elevation: 24,
      backgroundColor: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Popup Title Area
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFEDF2F7))),
              ),
              child: Row(
                children: const [
                  Icon(Icons.edit_rounded, color: primaryPurple, size: 22),
                  SizedBox(width: 10),
                  Text(
                    "Edit Profile Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textNavy,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Form content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PERSONAL INFORMATION
                      Row(
                        children: const [
                          Icon(Icons.person_outline_rounded, color: primaryPurple, size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: primaryPurple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Name Field
                      _buildTextField(
                        controller: _nameController,
                        label: "Full Name",
                        hint: "Enter your full name",
                        icon: Icons.person_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Full Name is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Employee ID Read-only Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Employee ID",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            initialValue: widget.employeeId,
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.assignment_ind_rounded, color: Colors.black26),
                              filled: true,
                              fillColor: AppColors.surfaceLight,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      _buildTextField(
                        controller: _emailController,
                        label: "Email Address",
                        hint: "Enter your email",
                        icon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Contact Number Field
                      _buildTextField(
                        controller: _contactController,
                        label: "Contact Number",
                        hint: "Enter your contact number",
                        icon: Icons.phone_rounded,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Contact Number is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Assigned Region Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Assigned Region",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedRegion,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black45),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.map_rounded, color: AppColors.textTertiary),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: lightPurple, width: 2.0),
                              ),
                            ),
                            items: widget.regionsList.map((String region) {
                              return DropdownMenuItem<String>(
                                value: region,
                                child: Text(
                                  region,
                                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              if (val != null) {
                                setState(() {
                                  _selectedRegion = val;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // SECURITY & PASSWORD
                      Row(
                        children: const [
                          Icon(Icons.lock_outline_rounded, color: AppColors.dangerRed, size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Security & Password",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.dangerRed,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // New Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "New Password",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textTertiary),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: AppColors.textTertiary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              hintText: '••••••••',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: lightPurple, width: 2.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Confirm New Password",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textTertiary),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: AppColors.textTertiary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              hintText: '••••••••',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: lightPurple, width: 2.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // NOTIFICATION PREFERENCES
                      Row(
                        children: const [
                          Icon(Icons.notifications_active_outlined, color: Color(0xFF0369A1), size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Notification Preferences",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0369A1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      _buildCheckboxRow("Email Alerts", _emailAlerts, (val) {
                        setState(() {
                          _emailAlerts = val ?? false;
                        });
                      }),
                      _buildCheckboxRow("System Push Notifications", _pushNotifications, (val) {
                        setState(() {
                          _pushNotifications = val ?? false;
                        });
                      }),
                      _buildCheckboxRow("Critical Security Updates", _criticalUpdates, (val) {
                        setState(() {
                          _criticalUpdates = val ?? false;
                        });
                      }),
                      _buildCheckboxRow("Weekly Reports", _weeklyReports, (val) {
                        setState(() {
                          _weeklyReports = val ?? false;
                        });
                      }),
                    ],
                  ),
                ),
              ),
            ),

            // Pop-up Footer Action Buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFEDF2F7))),
              ),
              child: Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Save Changes Button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryPurple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.onSave({
                              'fullName': _nameController.text.trim(),
                              'email': _emailController.text.trim(),
                              'contact': _contactController.text.trim(),
                              'region': _selectedRegion,
                              'newPassword': _passwordController.text.trim(),
                              'confirmNewPassword': _confirmPasswordController.text.trim(),
                              'emailAlerts': _emailAlerts,
                              'pushNotifications': _pushNotifications,
                              'criticalUpdates': _criticalUpdates,
                              'weeklyReports': _weeklyReports,
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    const Color lightPurple = Color(0xFF6B58F2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textTertiary),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: lightPurple, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxRow(String label, bool value, Function(bool?)? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryPurple,
          ),
        ],
      ),
    );
  }
}

