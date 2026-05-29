import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/firestore_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    Map<String, dynamic>? extraData,
  }) async {
    try {
      final credential = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      await _firestoreService.setData(
        collection: 'users',
        docId: uid,
        data: {
          'uid': uid,
          'name': name,
          'email': email,
          'role': role,
          ...?extraData,
        },
      );
      return true;
    } catch (e) {
      print("AuthRepository SIGNUP ERROR: $e");
      return false;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final doc = await _firestoreService.getData(
        collection: 'users',
        docId: uid,
      );

      if (!doc.exists) return null;
      return doc.data()?['role'];
    } catch (e) {
      print("AuthRepository LOGIN ERROR: $e");
      return null;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
  }

  // =========================
  // ADMIN SIGNUP & LOGIN
  // =========================
  Future<String?> registerAdmin({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final credential = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      await _firestoreService.setData(
        collection: 'admins',
        docId: uid,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'role': 'admin',
          'createdAt': FieldValue.serverTimestamp(),
          'isApproved': false,
        },
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> loginAdmin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final doc = await _firestoreService.getData(
        collection: 'admins',
        docId: uid,
      );

      if (!doc.exists) {
        return "Admin account not found";
      }

      if (doc.data()?['isApproved'] != true) {
        await _authService.signOut();
        return "Your account is not approved yet";
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // =========================
  // FLEET SIGNUP & LOGIN
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
    try {
      final credential = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      await _firestoreService.setData(
        collection: 'fleets',
        docId: uid,
        data: {
          'name': name,
          'company': company,
          'phone': phone,
          'city': city,
          'fleetSize': fleetSize,
          'email': email,
          'role': 'fleet',
          'createdAt': FieldValue.serverTimestamp(),
        },
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> loginFleet({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final doc = await _firestoreService.getData(
        collection: 'fleets',
        docId: uid,
      );

      if (!doc.exists) {
        return "Fleet account not found";
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
