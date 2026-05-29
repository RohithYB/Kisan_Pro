import 'package:firebase_core/firebase_core.dart'; // ✅ ADDED
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisan_pro_jrf/core/splash/splash_screen.dart';
import 'package:kisan_pro_jrf/routes/app_routes.dart';

import 'firebase_options.dart'; // ✅ ADDED

void main() async {
  // Ensure widget bindings are initialized before configuring system services
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ INITIALIZE FIREBASE (CRITICAL)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enforce fullscreen immersive mode to hide bottom navigation bar of the phone
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const KisanProApp());
}

class KisanProApp extends StatelessWidget {
  const KisanProApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1A6C24);
    const Color bgBeige = Color(0xFFF3EED9);

    return MaterialApp(
      title: 'Kisan Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryGreen,
        scaffoldBackgroundColor: bgBeige,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          primary: primaryGreen,
          surface: bgBeige,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Roboto'),
      ),
      routes: AppRoutes.getRoutes(),
      home: const SplashScreen(),
    );
  }
}
