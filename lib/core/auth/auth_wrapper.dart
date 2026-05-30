import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

// 🔁 Role-based screen imports
import '../../features/admin/presentation/screens/admin_shell_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/fleet/presentation/screens/fleet_dashboard_screen.dart';
import '../../features/farmer/presentation/screens/farms_list_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final firestoreService = FirestoreService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // 🔄 Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ Not logged in
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // ✅ Logged in → check role in Firestore
        final user = snapshot.data!;

        return FutureBuilder<DocumentSnapshot>(
          future: firestoreService.getData(
            collection: 'users',
            docId: user.uid,
          ),
          builder: (context, roleSnapshot) {
            // 🔄 Loading role
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            // ❌ No user document found
            if (!roleSnapshot.hasData || !roleSnapshot.data!.exists) {
              return const LoginScreen();
            }

            final data = roleSnapshot.data!.data() as Map<String, dynamic>;
            final role = data['role'] as String?;

            // 🎯 ROLE-BASED ROUTING — same email can have multiple roles
            switch (role) {
              case 'admin':
                return const AdminShellScreen();

              case 'fleet':
                return const FleetDashboardScreen();

              case 'farmer':
                // Farmer entry point: select/create farm first
                return const FarmsListScreen();

              case 'customer':
                return const Scaffold(
                  body: Center(child: Text('Customer Dashboard')),
                );

              default:
                return const LoginScreen();
            }
          },
        );
      },
    );
  }
}
