import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/features/auth/presentation/controller/auth_controller.dart';

import '../../../dashboard/presentation/screens/role_selection_screen.dart';
import 'customer_signup_screen.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final role = await AuthController.instance.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      if (role != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login Successful")));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
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
    const Color customerColor = Color(0xFFAD521B);
    const Color inputBg = Color(0xFFFFFDF0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: customerColor),
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
                        // ⚠️ UI NOT TOUCHED (everything below same)
                        Center(
                          child: Container(
                            height: 190,
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    color: customerColor.withAlpha(
                                      (0.15 * 255).round(),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Icon(
                                  Icons.store_rounded,
                                  size: 100,
                                  color: customerColor,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Text(
                          "Welcome back! Glad to see you, Partner!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 28),

                        TextFormField(
                          controller: _emailController,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Enter your Email'
                              : null,
                          decoration: InputDecoration(
                            hintText: "Enter your Username",
                            filled: true,
                            fillColor: inputBg,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Enter your password'
                              : null,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            filled: true,
                            fillColor: inputBg,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            child: const Text("Login"),
                          ),
                        ),

                        const SizedBox(height: 48),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have a business account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerSignupScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Register Now",
                                style: TextStyle(
                                  color: customerColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // ✅ FIXED DISPOSE (inside class)
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
