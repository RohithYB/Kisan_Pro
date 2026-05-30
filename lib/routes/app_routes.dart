import 'package:flutter/material.dart';

// Auth
import '../core/auth/auth_wrapper.dart';
import '../core/splash/splash_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/language/presentation/screens/language_screen.dart';

// Admin
import '../features/admin/presentation/screens/admin_login_screen.dart';
import '../features/admin/presentation/screens/admin_signup_screen.dart';
import '../features/admin/presentation/screens/admin_shell_screen.dart';

// Fleet
import '../features/fleet/presentation/screens/fleet_login_screen.dart';
import '../features/fleet/presentation/screens/fleet_signup_screen.dart';
import '../features/fleet/presentation/screens/fleet_dashboard_screen.dart';

// Farmer
import '../features/farmer/presentation/screens/farms_list_screen.dart';
import '../features/farmer/presentation/screens/farmer_dashboard.dart';
import '../features/farmer/presentation/screens/farm_setup_screen.dart';

// Dashboard
import '../features/dashboard/presentation/screens/main_dashboard_roles_screen.dart';
import '../features/dashboard/presentation/screens/role_selection_screen.dart';

class AppRoutes {
  // ─── Route Name Constants ────────────────────────────
  static const String splash        = '/';
  static const String language      = '/language';
  static const String authWrapper   = '/auth';

  // Auth (Farmer / Customer)
  static const String login         = '/login';
  static const String signup        = '/signup';

  // Admin
  static const String adminLogin    = '/admin-login';
  static const String adminSignup   = '/admin-signup';
  static const String adminShell    = '/admin-shell';

  // Fleet
  static const String fleetLogin    = '/fleet-login';
  static const String fleetSignup   = '/fleet-signup';
  static const String fleetDashboard = '/fleet-dashboard';

  // Farmer
  static const String farmsList     = '/farms-list';
  static const String farmerDashboard = '/farmer-dashboard';
  static const String farmSetup     = '/farm-setup';

  // Dashboard
  static const String mainDashboard = '/main-dashboard';
  static const String roleSelection = '/role-selection';

  // ─── Route Map ───────────────────────────────────────
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash:          (_) => const SplashScreen(),
      language:        (_) => const LanguageSelectionScreen(),
      authWrapper:     (_) => const AuthWrapper(),

      // Auth
      login:           (_) => const LoginScreen(),
      signup:          (_) => const SignupScreen(),

      // Admin
      adminLogin:      (_) => const AdminLoginScreen(),
      adminSignup:     (_) => const AdminSignupScreen(),
      adminShell:      (_) => const AdminShellScreen(),

      // Fleet
      fleetLogin:      (_) => const FleetLoginScreen(),
      fleetSignup:     (_) => const FleetSignupScreen(),
      fleetDashboard:  (_) => const FleetDashboardScreen(),

      // Farmer
      farmsList:       (_) => const FarmsListScreen(),
      farmerDashboard: (_) => const FarmerDashboard(),
      farmSetup:       (_) => const FarmSetupScreen(),

      // Dashboard
      mainDashboard:   (_) => const MainDashboardRolesScreen(),
      roleSelection:   (_) => const RoleSelectionScreen(),
    };
  }
}
