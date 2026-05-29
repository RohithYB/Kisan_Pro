import 'dart:ui';
import 'package:flutter/material.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  // Roster representation matching PNG 3 active members
  final List<Map<String, dynamic>> _membersList = [
    {
      'name': 'Ravi Kumar',
      'role': 'Cattle Supervisor',
      'status': 'Authorized',
      'isExpired': false,
      'avatarUrl': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=100',
    },
    {
      'name': 'Sunil Patel',
      'role': 'Tractor Operator',
      'status': 'Authorized',
      'isExpired': false,
      'avatarUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100',
    },
    {
      'name': 'Guest Access',
      'role': 'Temporary Worker',
      'status': 'Expired',
      'isExpired': true,
      'avatarUrl': '',
    }
  ];

  void _addNewMemberToList(String name, String role, String avatarPath) {
    setState(() {
      _membersList.insert(0, {
        'name': name,
        'role': role,
        'status': 'Authorized',
        'isExpired': false,
        'avatarUrl': avatarPath.isNotEmpty
            ? avatarPath
            : 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=100',
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Member '$name' successfully registered!"),
        backgroundColor: const Color(0xFF0C7A70),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _removeMember(int index) {
    final String name = _membersList[index]['name'];
    setState(() {
      _membersList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Removed '$name' from security access logs."),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Triggers backdrop blur general modal matching PNG 4
  void _openAddMemberModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Add Member Dialog',
      barrierColor: Colors.black45, // Soft darken overlay
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
                child: AddMemberPopupDialog(
                  onRegister: (name, role, avatar) {
                    _addNewMemberToList(name, role, avatar);
                  },
                ),
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

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Member Monitoring',
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
              // 1. Unauthorized Warning Card with Red Left Edge matching PNG 3
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7EF), // Light pale cream background
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.black12, width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.04 * 255).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Row(
                    children: [
                      // Red left vertical accent line
                      Container(
                        width: 5,
                        height: 90,
                        color: const Color(0xFFC0392B), // Threat red
                      ),
                      const SizedBox(width: 14),

                      // Warning Circle Icon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFADBD8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFC0392B),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Warn messages column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Unauthorized Person\nDetected",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC0392B),
                                height: 1.25,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Zone B - Cattle Shed • 2 mins ago",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Threat Capture Picture Thumbnail
                      Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: 54,
                            height: 54,
                            color: Colors.black12,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1543882048-2598350202DF?auto=format&fit=crop&q=80&w=150',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 2. Add Farm Member action button matching PNG 3
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealHeader, // Teal button
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () => _openAddMemberModal(context),
                  icon: const Icon(Icons.person_add_alt_1_rounded, size: 20),
                  label: const Text(
                    "Add Farm Member",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.2),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 3. Farm Access Monitoring description Card matching PNG 3
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF5),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.03 * 255).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sub Header Icon and Security Tag
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.videocam_rounded, color: tealHeader, size: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.circle, color: Color(0xFF27AE60), size: 8),
                              SizedBox(width: 5),
                              Text(
                                "Security Active",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF27AE60),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Card description text
                    const Text(
                      "Farm Access Monitoring",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "AI cameras monitor authorized farm members and alert on unrecognized personnel.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // 4. Active Members header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Active Members",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "${_membersList.length} Registered",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 5. Active Members registry list scroll matching PNG 3
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _membersList.length,
                itemBuilder: (context, index) {
                  final member = _membersList[index];
                  final String avatar = member['avatarUrl'];
                  final bool expired = member['isExpired'];

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
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                    child: Row(
                      children: [
                        // Dynamic Face Image Avatar matching PNG 3
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withAlpha((0.05 * 255).round()),
                          ),
                          child: ClipOval(
                            child: avatar.isNotEmpty
                                ? Image.network(
                                    avatar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, st) => const Icon(Icons.person, color: Colors.black38),
                                  )
                                : const Icon(Icons.person, color: Colors.black38, size: 28),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Member details labels
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                member['role'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Auth / Expired tag pill
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: expired 
                                      ? const Color(0xFFFFF2E3) // Expired tag bg
                                      : const Color(0xFFE8F5E9), // Authorized tag bg
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      expired ? Icons.schedule_rounded : Icons.check_circle_rounded,
                                      color: expired ? const Color(0xFFD35400) : const Color(0xFF27AE60),
                                      size: 10,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      expired ? "Expired" : "Authorized",
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        color: expired ? const Color(0xFFD35400) : const Color(0xFF27AE60),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Trash delete option matching PNG 3
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 26),
                          onPressed: () => _removeMember(index),
                        ),
                      ],
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

// Custom Add Member Modal Popup Dialog matching PNG 4
class AddMemberPopupDialog extends StatefulWidget {
  final Function(String name, String role, String avatar) onRegister;

  const AddMemberPopupDialog({super.key, required this.onRegister});

  @override
  State<AddMemberPopupDialog> createState() => _AddMemberPopupDialogState();
}

class _AddMemberPopupDialogState extends State<AddMemberPopupDialog> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isFaceUploaded = false;
  String _simulatedAvatarUrl = '';

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _simulatedImageUpload() {
    if (_isFaceUploaded) {
      setState(() {
        _isFaceUploaded = false;
        _simulatedAvatarUrl = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Biometric face registration cleared."),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    const Color tealHeader = Color(0xFF0C7A70);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: const Color(0xFFFFFCE4),
        title: Row(
          children: const [
            Icon(Icons.camera_alt_rounded, color: tealHeader),
            SizedBox(width: 10),
            Text("Camera Permission", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          "Kisan Pro requires access to your physical phone camera to scan and register 180-degree biometric facial identifiers.",
          style: TextStyle(color: Colors.black87, height: 1.35),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Camera permission denied. Facial biometric enrollment suspended."),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Deny", style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: tealHeader,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isFaceUploaded = true;
                _simulatedAvatarUrl = 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=100';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Biometric face registration complete!"),
                  backgroundColor: tealHeader,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Allow Access"),
          ),
        ],
      ),
    );
  }

  void _submitRegistry() {
    if (_formKey.currentState!.validate()) {
      if (!_isFaceUploaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Face scan is mandatory for access AI logs!"),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      widget.onRegister(
        _nameController.text.trim(),
        _roleController.text.trim(),
        _simulatedAvatarUrl,
      );

      // Close the modal dialog cleanly
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color tealHeader = Color(0xFF0C7A70);
    const Color inputBg = Color(0xFFFFFBE4); // Pale yellow-cream matching inputs

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCE4), // Rounded beige card
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.all(22.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header line holding close trigger X
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded, color: Colors.black54, size: 28),
                ),
              ),

              // Title & Subtitle exactly matching PNG 4
              const Text(
                "Add Farm Member",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: tealHeader,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Register authorized farm members for\nAI access monitoring",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 20),

              // MEMBER NAME
              const Text(
                "MEMBER NAME",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                validator: (v) => v == null || v.trim().isEmpty ? 'Enter name' : null,
                decoration: InputDecoration(
                  hintText: "Enter member name",
                  hintStyle: const TextStyle(color: Colors.black26, fontSize: 13, fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: inputBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 14),

              // MEMBER ROLE
              const Text(
                "MEMBER ROLE",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _roleController,
                validator: (v) => v == null || v.trim().isEmpty ? 'Enter role' : null,
                decoration: InputDecoration(
                  hintText: "Enter member role",
                  hintStyle: const TextStyle(color: Colors.black26, fontSize: 13, fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: inputBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 18),

              // Face images header
              const Text(
                "Upload Face Images",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const Text(
                "Upload clear 180-degree face images",
                style: TextStyle(fontSize: 11, color: Colors.black38, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Large face container scan placeholder
              GestureDetector(
                onTap: _simulatedImageUpload,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha((0.05 * 255).round()),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: _isFaceUploaded ? tealHeader : Colors.black12,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: _isFaceUploaded
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  _simulatedAvatarUrl,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  color: Colors.black38,
                                  child: const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.white,
                                    size: 44,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_rounded, size: 68, color: Colors.black26),
                              SizedBox(height: 4),
                              Text(
                                "Tap to upload face photo",
                                style: TextStyle(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Register Member button
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
                  onPressed: _submitRegistry,
                  icon: const Icon(Icons.person_add_alt_1_rounded, size: 20),
                  label: const Text(
                    "Register Member",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
