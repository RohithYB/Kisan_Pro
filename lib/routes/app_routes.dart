import 'package:flutter/material.dart';

import '../features/admin/admin_shell/screens/admin_shell_screen.dart';
import '../features/admin/presentation/screens/admin_login_screen.dart';

class AppRoutes {
  static const String adminLogin = '/admin-login';
  static const String adminShell = '/admin-shell';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      adminLogin: (context) => const AdminLoginScreen(),
      adminShell: (context) => const AdminShellScreen(),
    };
  }
}
