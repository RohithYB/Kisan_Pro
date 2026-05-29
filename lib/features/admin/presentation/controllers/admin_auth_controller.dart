import 'package:flutter/material.dart';
import '../../../../data/repositories/auth_repository.dart';

class AdminAuthController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String?> handleAdminSignup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      return "Please fill all fields";
    }

    setLoading(true);
    final result = await _authRepository.registerAdmin(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
    setLoading(false);
    return result;
  }

  Future<String?> handleAdminLogin({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return "Please enter your email and password";
    }

    setLoading(true);
    final result = await _authRepository.loginAdmin(
      email: email,
      password: password,
    );
    setLoading(false);
    return result;
  }
}
