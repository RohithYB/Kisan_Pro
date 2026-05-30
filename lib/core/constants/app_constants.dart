/// App-wide numeric, duration, and structural constants for KisanPro.
class AppConstants {
  AppConstants._();

  // ─── Splash ────────────────────────────────────────
  /// Duration (in seconds) the splash screen stays before navigating.
  static const int splashDurationSeconds = 2;

  // ─── Border Radius ─────────────────────────────────
  static const double radiusSmall    = 8.0;
  static const double radiusMedium   = 12.0;
  static const double radiusLarge    = 16.0;
  static const double radiusXLarge   = 24.0;
  static const double radiusCard     = 20.0;
  static const double radiusCircle   = 100.0;

  // ─── Padding / Spacing ─────────────────────────────
  static const double paddingXS      = 4.0;
  static const double paddingS       = 8.0;
  static const double paddingM       = 16.0;
  static const double paddingL       = 24.0;
  static const double paddingXL      = 32.0;

  // ─── Icon Sizes ────────────────────────────────────
  static const double iconSizeSmall  = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge  = 32.0;
  static const double iconSizeXL     = 48.0;

  // ─── Button Height ─────────────────────────────────
  static const double buttonHeightSmall  = 40.0;
  static const double buttonHeightMedium = 50.0;
  static const double buttonHeightLarge  = 56.0;

  // ─── Input Field ───────────────────────────────────
  static const double inputHeight    = 48.0;
  static const double inputBorderWidth = 1.5;
  static const double inputFocusBorderWidth = 2.0;

  // ─── Animation Duration ────────────────────────────
  static const Duration animFast     = Duration(milliseconds: 200);
  static const Duration animMedium   = Duration(milliseconds: 350);
  static const Duration animSlow     = Duration(milliseconds: 600);

  // ─── Validation ────────────────────────────────────
  static const int passwordMinLength = 6;
  static const int phoneMinLength    = 10;

  // ─── Grid ──────────────────────────────────────────
  static const int dashboardGridColumns = 2;
  static const double dashboardCardAspectRatio = 0.76;

  // ─── Fleet Sizes ───────────────────────────────────
  static const List<String> fleetSizeOptions = [
    '1-10 Vehicles',
    '11-50 Vehicles',
    '50+ Vehicles',
  ];
}
