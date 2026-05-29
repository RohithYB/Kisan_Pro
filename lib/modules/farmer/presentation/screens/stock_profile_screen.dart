import 'dart:ui';
import 'package:flutter/material.dart';

class StockProfileScreen extends StatefulWidget {
  const StockProfileScreen({super.key});

  @override
  State<StockProfileScreen> createState() => _StockProfileScreenState();
}

class _StockProfileScreenState extends State<StockProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Colors matching the mockup
  final Color orangeAccent = const Color(0xFFEF9741);
  final Color navyColor = const Color(0xFF1F3E5A);
  final Color bgBeige = const Color(0xFFFFFCE4);
  final Color inputBg = const Color(0xFFFFFDF0);

  // Active (saved) profile credentials
  String _savedName = "Suresh Gowda";
  String _savedPhone = "+91 9876543210";
  String _savedGender = "Male";
  String _savedEmail = "suresh@gmail.com";
  String _savedPassword = "password123";
  String _savedPhotoUrl = "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200";

  // TextEditingControllers for the form
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late String _currentGender;
  late String _currentPhotoUrl;

  @override
  void initState() {
    super.initState();
    _resetFormToSavedState();
  }

  void _resetFormToSavedState() {
    _nameController = TextEditingController(text: _savedName);
    _phoneController = TextEditingController(text: _savedPhone);
    _emailController = TextEditingController(text: _savedEmail);
    _passwordController = TextEditingController(text: _savedPassword);
    _confirmPasswordController = TextEditingController(text: _savedPassword);
    _currentGender = _savedGender;
    _currentPhotoUrl = _savedPhotoUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changeProfilePhoto() {
    setState(() {
      _currentPhotoUrl = "https://images.unsplash.com/photo-1542838132-92c53300491e?w=200"; // New farmer picture
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Simulated profile photo updated!"),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _discardChanges() {
    setState(() {
      _resetFormToSavedState();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Changes discarded"),
        backgroundColor: navyColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Opens a backdrop filter blur dialog for popup confirmation
  void _showSaveConfirmationDialog() {
    if (!_formKey.currentState!.validate()) return;

    final newName = _nameController.text.trim();
    final newPhone = _phoneController.text.trim();
    final newEmail = _emailController.text.trim();
    final newPassword = _passwordController.text;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Save Changes",
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
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                title: Column(
                  children: [
                    Icon(Icons.security_outlined, color: orangeAccent, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      "Save Profile Changes?",
                      style: TextStyle(
                        color: navyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Review your updated details below",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
                content: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgBeige,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: orangeAccent.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryRow("Name", newName),
                      const SizedBox(height: 8),
                      _buildSummaryRow("Mobile", newPhone),
                      const SizedBox(height: 8),
                      _buildSummaryRow("Gender", _currentGender),
                      const SizedBox(height: 8),
                      _buildSummaryRow("Email", newEmail),
                    ],
                  ),
                ),
                actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: orangeAccent,
                            side: BorderSide(color: orangeAccent, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close popup, keep editing
                          },
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
                            backgroundColor: orangeAccent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            // Persist changes
                            setState(() {
                              _savedName = newName;
                              _savedPhone = newPhone;
                              _savedGender = _currentGender;
                              _savedEmail = newEmail;
                              _savedPassword = newPassword;
                              _savedPhotoUrl = _currentPhotoUrl;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text("Profile updated successfully!"),
                                backgroundColor: orangeAccent,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );

                            Navigator.pop(context); // Close dialog
                          },
                          child: const Text(
                            "Save Changes",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String val) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            val,
            style: TextStyle(color: navyColor, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar with camera icon
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(_currentPhotoUrl),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _changeProfilePhoto,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: orangeAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Card Panel containing fields
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information Section
                  Text(
                    'Personal Information',
                    style: TextStyle(color: navyColor, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Update your account details below.',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                  const SizedBox(height: 20),

                  // Full Name
                  _buildLabel('Full Name'),
                  TextFormField(
                    controller: _nameController,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Enter full name' : null,
                    decoration: _inputDecoration('Enter full name'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  // Mobile Number
                  _buildLabel('Mobile Number'),
                  TextFormField(
                    controller: _phoneController,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Enter mobile number' : null,
                    decoration: _inputDecoration('Enter mobile number'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  // Gender select
                  _buildLabel('Gender'),
                  Row(
                    children: [
                      _buildGenderOption('Male'),
                      const SizedBox(width: 8),
                      _buildGenderOption('Female'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildGenderOption('Prefer not to say'),
                  const SizedBox(height: 24),

                  // Email
                  _buildLabel('Email Address'),
                  TextFormField(
                    controller: _emailController,
                    validator: (v) => v == null || !v.contains('@') ? 'Enter valid email' : null,
                    decoration: _inputDecoration('Enter email address'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 20),

                  // Security Section
                  Text(
                    'Security',
                    style: TextStyle(color: navyColor, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  _buildLabel('New Password'),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration('Enter new password'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password
                  _buildLabel('Confirm Password'),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (v) {
                      if (v != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                    decoration: _inputDecoration('Confirm new password'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 32),

                  // Save Changes button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orangeAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _showSaveConfirmationDialog,
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: orangeAccent,
                        side: BorderSide(color: orangeAccent, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                      ),
                      onPressed: _discardChanges,
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
            const SizedBox(height: 32),
          ],
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
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    bool isSelected = _currentGender == gender;
    return ChoiceChip(
      label: Text(
        gender,
        style: TextStyle(
          color: isSelected ? Colors.black87 : Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      selected: isSelected,
      selectedColor: orangeAccent.withValues(alpha: 0.25),
      disabledColor: Colors.white,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: isSelected ? orangeAccent : Colors.grey.shade300,
        width: 1.5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _currentGender = gender;
          });
        }
      },
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.normal),
      filled: true,
      fillColor: inputBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
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
        borderSide: BorderSide(color: orangeAccent, width: 1.5),
      ),
    );
  }
}
