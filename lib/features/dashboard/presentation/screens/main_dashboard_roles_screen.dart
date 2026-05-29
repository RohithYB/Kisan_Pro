import 'package:flutter/material.dart';
import '../../../../features/auth/presentation/screens/login_screen.dart';
import '../../../../features/auth/presentation/screens/signup_screen.dart';
import '../../../../features/auth/presentation/screens/customer_login_screen.dart';
import '../../../../features/fleet/presentation/screens/fleet_login_screen.dart';
import '../../../../features/admin/presentation/screens/admin_login_screen.dart';

class MainDashboardRolesScreen extends StatelessWidget {
  const MainDashboardRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color greenHeader = Color(0xFF1E6C2D);
    const Color bgBeige = Color(0xFFFFFCE4);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: const Text(
          'Roles',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: greenHeader,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Choose your Role Title
              const Text(
                'Choose your Role',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 36),

              // 2x2 Grid representing the 4 Roles using custom PNG assets!
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.0,
                  mainAxisSpacing: 18.0,
                  childAspectRatio: 0.95,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // 1. Farmer Card (Orange) -> Navigate to LoginScreen
                    _buildRoleCard(
                      context: context,
                      title: "Farmer",
                      bgColor: const Color(0xFFEF9741),
                      imageAsset: 'assets/images/farmer_icon.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),

                    // 2. Fleet Manager Card (Blue)
                    _buildRoleCard(
                      context: context,
                      title: "Fleet Manager",
                      bgColor: const Color(0xFF3282F6),
                      imageAsset: 'assets/images/fleet_icon.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FleetLoginScreen(),
                          ),
                        );
                      },
                    ),

                    // 3. Admin Card (Purple)
                    _buildRoleCard(
                      context: context,
                      title: "Admin",
                      bgColor: const Color(0xFF6B58F2),
                      imageAsset: 'assets/images/admin_icon.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminLoginScreen(),
                          ),
                        );
                      },
                    ),

                    // 4. Customer Card (Brown)
                    _buildRoleCard(
                      context: context,
                      title: "Customer",
                      bgColor: const Color(0xFFB05C23),
                      imageAsset: 'assets/images/customer_icon.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerLoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Register Button at the Bottom
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenHeader,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required Color bgColor,
    required String imageAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.08 * 255).round()),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Custom asset Image loaded dynamically from assets/images/
              Image.asset(
                imageAsset,
                width: 76,
                height: 76,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported_rounded,
                    color: Colors.white70,
                    size: 64,
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUnavailableDialog(BuildContext context, String moduleName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Row(
          children: [
            const Icon(Icons.lock_outline_rounded, color: Color(0xFFEF9741)),
            const SizedBox(width: 10),
            Text(moduleName),
          ],
        ),
        content: Text(
          "The $moduleName module is currently locked under premium development access. Tap the Orange Farmer module to configure your dashboard pastures!",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "OK",
              style: TextStyle(
                color: Color(0xFF1E6C2D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
