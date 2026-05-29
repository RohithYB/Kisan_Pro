import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/features/auth/presentation/controller/auth_controller.dart';
import 'package:kisan_pro_jrf/features/dashboard/presentation/screens/role_selection_screen.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final role = await AuthController.instance.login(
        email: _usernameController.text.trim(), // must be EMAIL
        password: _passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (role == "Farmer" && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid credentials or not a Farmer account"),
          ),
        );
      }
    }
  }

  Future<void> _handleGoogleLogin() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Google login coming soon")));
  }

  Future<void> _handleAppleLogin() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Apple login coming soon")));
  }

  @override
  Widget build(BuildContext context) {
    const Color orangeAccent = Color(0xFFEF9741);
    const Color inputBg = Color(
      0xFFEFEFD9,
    ); // Premium light-tint background from mockup
    const Color darkGreen = Color(
      0xFF3E5C1D,
    ); // Classic button color from mockup

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: orangeAccent),
              )
            : Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 10.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top Illustration matching PNG
                        Center(
                          child: Container(
                            height: 190,
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Circular decorative background
                                Container(
                                  width: 170,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withAlpha(
                                      (0.15 * 255).round(),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                // Custom painted vector illustration representing the tablet mockup
                                CustomPaint(
                                  size: const Size(190, 190),
                                  painter: LoginIllustrationPainter(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Welcome Heading
                        const Text(
                          "Welcome back! Glad to see you, Again!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                            height: 1.3,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Username Input Field
                        TextFormField(
                          controller: _usernameController,
                          validator: (v) => v == null || !v.contains('@')
                              ? 'Enter your Email'
                              : null,
                          decoration: InputDecoration(
                            hintText: "Enter your Email",
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: inputBg,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 18.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                color: orangeAccent,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Password Input Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Enter your password'
                              : null,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: inputBg,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 18.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                color: orangeAccent,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Simulating forgot password recovery...",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Login Button
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  orangeAccent, // Premium orange requested
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: _handleLogin,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Divider text
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Text(
                                "Or Login with",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withAlpha(
                                    (0.4 * 255).round(),
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Google & Apple Outline Icons side-by-side
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google outline button
                            GestureDetector(
                              onTap: _handleGoogleLogin,
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg',
                                    width: 24,
                                    height: 24,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text(
                                        "G",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: darkGreen,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),

                            // Apple outline button
                            GestureDetector(
                              onTap: _handleAppleLogin,
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.apple,
                                    size: 28,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),

                        // Redirect Link to SignUp
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an account? ",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Register now",
                                style: TextStyle(
                                  color: Color(0xFF3E5C1D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

// Vector illustration matching the PNG mockup
class LoginIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Draw Guy / Green leaf patterns on background
    paint.color = Colors.green.withAlpha((0.3 * 255).round());
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.4), 10, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.65), 8, paint);

    // Draw Tablet Frame
    paint.color = const Color(0xFF1D1D1F);
    final RRect tabletFrame = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: 95,
        height: 130,
      ),
      const Radius.circular(8.0),
    );
    canvas.drawRRect(tabletFrame, paint);

    // Draw Screen in Mint Green
    paint.color = const Color(0xFF0C7A70);
    final RRect tabletScreen = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: 85,
        height: 115,
      ),
      const Radius.circular(4.0),
    );
    canvas.drawRRect(tabletScreen, paint);

    // Draw white layout boxes inside the screen
    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.44),
        width: 50,
        height: 7,
      ),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.54),
        width: 50,
        height: 7,
      ),
      paint,
    );

    // Draw user avatar inside the screen
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.32), 8, paint);

    // Draw black sign-in button
    paint.color = Colors.black87;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.65),
          width: 35,
          height: 8,
        ),
        const Radius.circular(1.0),
      ),
      paint,
    );

    // Draw security lock outline
    paint.color = Colors.black26;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.28), 12, paint);
    canvas.drawLine(
      Offset(size.width * 0.82, size.height * 0.16),
      Offset(size.width * 0.82, size.height * 0.24),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
