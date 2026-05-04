import 'dart:ui';

/// Centralized color palette for the application.
/// These constants provide a consistent theme and are easy to maintain.
class AppColors {
  // Primary brand color, used for prominent UI elements like the RoundButton
  static const Color primary = Color(0xFFA8D0B4);

  // Soft off-white for the main background to reduce eye strain
  static const Color background = Color(0xFFF9FBFA);

  // Specific color for button labels to ensure legibility against the primary color
  static const Color textButton = Color(0xFF7FB08E);

  // Pure white for card surfaces and elevated containers
  static const Color cardSurface = Color(0xFFFFFFFF);

  // Subtle grey for separators and borders to keep the UI organized but clean
  static const Color borderOrDivider = Color(0xFFE0E6E2);

  // Dark charcoal for high-priority text and headers
  static const Color primaryText = Color(0xFF2D3430);

  // Muted grey for descriptions and sub-headers
  static const Color secondaryText = Color(0xFF6B7770);

  // Specialized color for icons that are not currently in an active state
  static const Color inactiveIcon = Color(0xFF4A554F);
}
