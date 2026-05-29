import 'package:flutter/material.dart';
import '../../../../data/repositories/auth_repository.dart';

class FleetAuthController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String?> handleFleetSignup({
    required String name,
    required String company,
    required String phone,
    required String city,
    required String fleetSize,
    required String email,
    required String password,
    required bool agreedToTerms,
  }) async {
    if (!agreedToTerms) {
      return "Please accept Terms & Conditions";
    }

    if (name.isEmpty || company.isEmpty || phone.isEmpty || city.isEmpty || fleetSize.isEmpty) {
      return "Please fill all fields";
    }

    setLoading(true);
    final result = await _authRepository.registerFleet(
      name: name,
      company: company,
      phone: phone,
      city: city,
      fleetSize: fleetSize,
      email: email,
      password: password,
    );
    setLoading(false);
    return result; // null means success, otherwise holds error message
  }

  Future<String?> handleFleetLogin({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return "Please enter email and password";
    }

    setLoading(true);
    final result = await _authRepository.loginFleet(
      email: email,
      password: password,
    );
    setLoading(false);
    return result;
  }
}
