import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

// 🔁 Import your actual screens
import '../../features/admin/presentation/screens/admin_shell_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/fleet/presentation/screens/fleet_dashboard_screen.dart';

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
          return const LoginScreen(); // 👉 your common login screen
        }

        // ✅ Logged in → check role
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

            // ❌ No user document
            if (!roleSnapshot.hasData || !roleSnapshot.data!.exists) {
              return const LoginScreen();
            }

            final data = roleSnapshot.data!.data() as Map<String, dynamic>;
            final role = data['role'];

            // 🎯 ROLE-BASED ROUTING
            switch (role) {
              case 'admin':
                return const AdminShellScreen();

              case 'fleet':
                return const FleetDashboardScreen();

              case 'farmer':
                return const Scaffold(
                  body: Center(child: Text('Farmer Dashboard')),
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
