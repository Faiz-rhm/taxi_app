import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF6D53F4); // Orange/Purple
  static const Color primaryLight = Color(0xFF8A6FF5);
  static const Color primaryDark = Color(0xFF5A3FD1);

  // Secondary colors
  static const Color secondary = Color(0xFF242424); // Black
  static const Color secondaryLight = Color(0xFF3A3A3A);
  static const Color secondaryDark = Color(0xFF1A1A1A);

  // Accent colors
  static const Color accent = Color(0xFF797979); // Medium Grey
  static const Color accentLight = Color(0xFF8F8F8F);
  static const Color accentDark = Color(0xFF636363);

  // Error and warning colors
  static const Color error = Color(0xFFE53935); // Red
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);

  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  // Success and info colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  static const Color info = Color(0xFF6D53F4); // Using primary color
  static const Color infoLight = Color(0xFF8A6FF5);
  static const Color infoDark = Color(0xFF5A3FD1);

  // Neutral colors
  static const Color background = Color(0xFFF6F6F6); // Light Grey
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);

  // Text colors
  static const Color primaryText = Color(0xFF242424); // Black
  static const Color secondaryText = Color(0xFF797979); // Medium Grey
  static const Color disabledText = Color(0xFFBDBDBD);
  static const Color hintText = Color(0xFF9E9E9E);

  // Status colors
  static const Color dark = Color(0xFF424242);
  static const Color light = Color(0xFFF5F5F5);

  // Gradient colors
  static const List<Color> primaryGradientColors = [
    Color(0xFF6D53F4),
    Color(0xFF5A3FD1),
  ];

  static const List<Color> secondaryGradientColors = [
    Color(0xFF242424),
    Color(0xFF1A1A1A),
  ];

  static const List<Color> accentGradientColors = [
    Color(0xFF797979),
    Color(0xFF636363),
  ];

  static const List<Color> errorGradientColors = [
    Color(0xFFE53935),
    Color(0xFFC62828),
  ];

  // Semantic colors
  static const Color online = Color(0xFF4CAF50);
  static const Color offline = Color(0xFF9E9E9E);
  static const Color busy = Color(0xFFFF9800);
  static const Color away = Color(0xFFFFC107);

  // Rating colors
  static const Color rating1 = Color(0xFFE53935); // Poor
  static const Color rating2 = Color(0xFFFF9800); // Fair
  static const Color rating3 = Color(0xFFFFC107); // Good
  static const Color rating4 = Color(0xFF4CAF50); // Very Good
  static const Color rating5 = Color(0xFF2196F3); // Excellent

  // Payment colors
  static const Color cash = Color(0xFF4CAF50);
  static const Color cardPayment = Color(0xFF2196F3);
  static const Color digitalWallet = Color(0xFF9C27B0);

  // Vehicle type colors
  static const Color economy = Color(0xFF4CAF50);
  static const Color comfort = Color(0xFF2196F3);
  static const Color premium = Color(0xFF9C27B0);
  static const Color luxury = Color(0xFFFFD700);

  // Map colors
  static const Color mapBackground = Color(0xFFF5F5F5);
  static const Color mapRoad = Color(0xFFE0E0E0);
  static const Color mapWater = Color(0xFFBBDEFB);
  static const Color mapBuilding = Color(0xFFEEEEEE);

  // Shadow colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x26000000);
  static const Color shadowDark = Color(0x33000000);

  // Overlay colors
  static const Color overlayLight = Color(0x1AFFFFFF);
  static const Color overlayMedium = Color(0x26FFFFFF);
  static const Color overlayDark = Color(0x33000000);

  // Border colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMedium = Color(0xFFBDBDBD);
  static const Color borderDark = Color(0xFF9E9E9E);

  // Background variants
  static const Color backgroundVariant = Color(0xFFF5F5F5);
  static const Color surfaceVariant = Color(0xFFEEEEEE);
  static const Color cardVariant = Color(0xFFFAFAFA);

  // Text variants
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Icon colors
  static const Color iconPrimary = Color(0xFF212121);
  static const Color iconSecondary = Color(0xFF757575);
  static const Color iconDisabled = Color(0xFFBDBDBD);
  static const Color iconInverse = Color(0xFFFFFFFF);

  // Button colors
  static const Color buttonPrimary = Color(0xFF1E88E5);
  static const Color buttonSecondary = Color(0xFFFFC107);
  static const Color buttonSuccess = Color(0xFF4CAF50);
  static const Color buttonWarning = Color(0xFFFF9800);
  static const Color buttonError = Color(0xFFE53935);
  static const Color buttonDisabled = Color(0xFFBDBDBD);

  // Input colors
  static const Color inputBackground = Color(0xFFFAFAFA);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputBorderFocused = Color(0xFF1E88E5);
  static const Color inputBorderError = Color(0xFFE53935);
  static const Color inputLabel = Color(0xFF757575);
  static const Color inputHint = Color(0xFF9E9E9E);

  // Navigation colors
  static const Color navigationBackground = Color(0xFFFFFFFF);
  static const Color navigationSelected = Color(0xFF1E88E5);
  static const Color navigationUnselected = Color(0xFF757575);
  static const Color navigationIndicator = Color(0xFF1E88E5);

  // Tab colors
  static const Color tabBackground = Color(0xFFFFFFFF);
  static const Color tabSelected = Color(0xFF1E88E5);
  static const Color tabUnselected = Color(0xFF757575);
  static const Color tabIndicator = Color(0xFF1E88E5);

  // Bottom sheet colors
  static const Color bottomSheetBackground = Color(0xFFFFFFFF);
  static const Color bottomSheetHandle = Color(0xFFE0E0E0);
  static const Color bottomSheetOverlay = Color(0x80000000);

  // Dialog colors
  static const Color dialogBackground = Color(0xFFFFFFFF);
  static const Color dialogOverlay = Color(0x80000000);
  static const Color dialogBorder = Color(0xFFE0E0E0);

  // Snackbar colors
  static const Color snackbarBackground = Color(0xFF323232);
  static const Color snackbarText = Color(0xFFFFFFFF);
  static const Color snackbarAction = Color(0xFFFFC107);

  // Tooltip colors
  static const Color tooltipBackground = Color(0xFF323232);
  static const Color tooltipText = Color(0xFFFFFFFF);

  // Progress colors
  static const Color progressBackground = Color(0xFFE0E0E0);
  static const Color progressValue = Color(0xFF1E88E5);
  static const Color progressValueSecondary = Color(0xFFFFC107);

  // Switch colors
  static const Color switchTrack = Color(0xFFE0E0E0);
  static const Color switchTrackActive = Color(0xFF1E88E5);
  static const Color switchThumb = Color(0xFFFFFFFF);
  static const Color switchThumbActive = Color(0xFF1E88E5);

  // Checkbox colors
  static const Color checkboxBorder = Color(0xFFE0E0E0);
  static const Color checkboxBorderActive = Color(0xFF1E88E5);
  static const Color checkboxBackground = Color(0xFFFFFFFF);
  static const Color checkboxBackgroundActive = Color(0xFF1E88E5);
  static const Color checkboxCheck = Color(0xFFFFFFFF);

  // Radio colors
  static const Color radioBorder = Color(0xFFE0E0E0);
  static const Color radioBorderActive = Color(0xFF1E88E5);
  static const Color radioBackground = Color(0xFFFFFFFF);
  static const Color radioBackgroundActive = Color(0xFF1E88E5);
  static const Color radioDot = Color(0xFFFFFFFF);

  // Slider colors
  static const Color sliderTrack = Color(0xFFE0E0E0);
  static const Color sliderTrackActive = Color(0xFF1E88E5);
  static const Color sliderThumb = Color(0xFF1E88E5);
  static const Color sliderThumbOverlay = Color(0x1A1E88E5);

  // Chip colors
  static const Color chipBackground = Color(0xFFE0E0E0);
  static const Color chipBackgroundSelected = Color(0xFF1E88E5);
  static const Color chipText = Color(0xFF212121);
  static const Color chipTextSelected = Color(0xFFFFFFFF);
  static const Color chipBorder = Color(0xFFE0E0E0);
  static const Color chipBorderSelected = Color(0xFF1E88E5);

  // Badge colors
  static const Color badgeBackground = Color(0xFFE53935);
  static const Color badgeText = Color(0xFFFFFFFF);

  // Avatar colors
  static const Color avatarBackground = Color(0xFFE0E0E0);
  static const Color avatarText = Color(0xFF757575);

  // Divider colors
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerMedium = Color(0xFFBDBDBD);
  static const Color dividerDark = Color(0xFF9E9E9E);

  // Backdrop colors
  static const Color backdrop = Color(0x80000000);
  static const Color backdropLight = Color(0x40000000);
  static const Color backdropDark = Color(0xCC000000);

  // Surface colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceMedium = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFFF5F5F5);

  // Elevation colors
  static const Color elevation1 = Color(0x1A000000);
  static const Color elevation2 = Color(0x26000000);
  static const Color elevation3 = Color(0x33000000);
  static const Color elevation4 = Color(0x40000000);
  static const Color elevation5 = Color(0x4D000000);
  static const Color elevation6 = Color(0x59000000);
  static const Color elevation7 = Color(0x66000000);
  static const Color elevation8 = Color(0x73000000);
  static const Color elevation9 = Color(0x80000000);
  static const Color elevation10 = Color(0x8C000000);
  static const Color elevation11 = Color(0x99000000);
  static const Color elevation12 = Color(0xA6000000);
  static const Color elevation13 = Color(0xB3000000);
  static const Color elevation14 = Color(0xBF000000);
  static const Color elevation15 = Color(0xCC000000);
  static const Color elevation16 = Color(0xD9000000);
  static const Color elevation17 = Color(0xE6000000);
  static const Color elevation18 = Color(0xF2000000);
  static const Color elevation19 = Color(0xFF000000);
  static const Color elevation20 = Color(0xFF000000);
  static const Color elevation21 = Color(0xFF000000);
  static const Color elevation22 = Color(0xFF000000);
  static const Color elevation23 = Color(0xFF000000);
  static const Color elevation24 = Color(0xFF000000);
}
