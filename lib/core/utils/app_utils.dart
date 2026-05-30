import 'package:flutter/material.dart';

/// General-purpose utility helpers for KisanPro.
/// These are pure functions — no Flutter context dependency (except where noted).
class AppUtils {
  AppUtils._();

  // ─── Validation ────────────────────────────────────

  /// Returns true if [email] is a well-formed email address.
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim());
  }

  /// Returns true if [password] meets minimum length requirements.
  static bool isValidPassword(String password, {int minLength = 6}) {
    return password.length >= minLength;
  }

  /// Returns true if [phone] has at least 10 digits.
  static bool isValidPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10;
  }

  // ─── String Helpers ────────────────────────────────

  /// Capitalizes the first letter of [text].
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Returns initials from a full name (e.g. "Rohith YB" → "RY").
  static String getInitials(String fullName) {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  // ─── Date Helpers ──────────────────────────────────

  /// Formats a [DateTime] as "DD MMM YYYY" (e.g. "29 May 2026").
  static String formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  /// Returns a human-readable time-ago string (e.g. "2 hours ago").
  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 30) return formatDate(date);
    if (diff.inDays > 0)  return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  // ─── UI Helpers ────────────────────────────────────

  /// Shows a floating [SnackBar] with [message].
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Shows a success SnackBar in green.
  static void showSuccess(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: const Color(0xFF0C7A70));
  }

  /// Shows an error SnackBar in red.
  static void showError(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: Colors.redAccent);
  }

  // ─── Number Helpers ────────────────────────────────

  /// Formats a number as Indian currency (e.g. 12500 → "₹12,500").
  static String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    )}';
  }

  /// Returns a percentage string (e.g. 0.75 → "75%").
  static String toPercent(double value, {int decimals = 0}) {
    return '${(value * 100).toStringAsFixed(decimals)}%';
  }
}
