/// App-wide string constants for KisanPro.
/// Centralizing strings avoids hardcoding and makes i18n easier later.
class AppStrings {
  AppStrings._();

  // ─── App Info ──────────────────────────────────────
  static const String appName        = 'KisanPro';
  static const String appTagline     = 'The future of farming is smart, and the farmer is its backbone';

  // ─── Splash ────────────────────────────────────────
  static const String getStarted     = 'Get Started';
  static const String letsGetStarted = "LET'S GET STARTED";

  // ─── Auth ──────────────────────────────────────────
  static const String login          = 'Login';
  static const String signup         = 'Sign Up';
  static const String logout         = 'Logout';
  static const String email          = 'Email';
  static const String password       = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String noAccount      = "Don't have an account? ";
  static const String registerNow    = 'Register now';
  static const String alreadyHaveAccount = 'Already have an account? ';

  // ─── Validation Messages ───────────────────────────
  static const String fieldRequired  = 'This field is required';
  static const String invalidEmail   = 'Enter a valid email address';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordMismatch = 'Passwords do not match';
  static const String fillAllFields  = 'Please fill all fields';
  static const String acceptTerms    = 'Please accept Terms & Conditions';

  // ─── Roles ─────────────────────────────────────────
  static const String roleAdmin      = 'admin';
  static const String roleFarmer     = 'farmer';
  static const String roleFleet      = 'fleet';
  static const String roleCustomer   = 'customer';

  // ─── Firestore Collections ─────────────────────────
  static const String colUsers       = 'users';
  static const String colAdmins      = 'admins';
  static const String colFleets      = 'fleets';
  static const String colFarmers     = 'farmers';

  // ─── Shared Prefs Keys ────────────────────────────
  static const String keyLanguageSelected = 'language_selected';
  static const String keySelectedLanguage = 'selected_language';

  // ─── Error Messages ────────────────────────────────
  static const String loginFailed    = 'Login Failed. Please check your credentials.';
  static const String signupFailed   = 'Signup Failed. Please try again.';
  static const String networkError   = 'Network error. Please check your connection.';
  static const String unknownError   = 'Something went wrong. Please try again.';
}
