import '../../../../data/repositories/auth_repository.dart';

class AuthController {
  static final AuthController instance = AuthController._internal();
  AuthController._internal();

  final AuthRepository _authRepository = AuthRepository();

  // ================= SIGNUP =================
  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    Map<String, dynamic>? extraData,
  }) async {
    return await _authRepository.signup(
      name: name,
      email: email,
      password: password,
      role: role,
      extraData: extraData,
    );
  }

  // ================= LOGIN =================
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    return await _authRepository.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }

  // =========================
  // ADMIN SIGNUP
  // =========================
  Future<String?> registerAdmin({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    return await _authRepository.registerAdmin(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }

  // =========================
  // ADMIN LOGIN
  // =========================
  Future<String?> loginAdmin({
    required String email,
    required String password,
  }) async {
    return await _authRepository.loginAdmin(
      email: email,
      password: password,
    );
  }

  // =========================
  // FLEET SIGNUP
  // =========================
  Future<String?> registerFleet({
    required String name,
    required String company,
    required String phone,
    required String city,
    required String fleetSize,
    required String email,
    required String password,
  }) async {
    return await _authRepository.registerFleet(
      name: name,
      company: company,
      phone: phone,
      city: city,
      fleetSize: fleetSize,
      email: email,
      password: password,
    );
  }

  // =========================
  // FLEET LOGIN
  // =========================
  Future<String?> loginFleet({
    required String email,
    required String password,
  }) async {
    return await _authRepository.loginFleet(
      email: email,
      password: password,
    );
  }
}
