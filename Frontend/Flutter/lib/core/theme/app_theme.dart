import 'package:flutter/material.dart';
import 'app_styles.dart';

ThemeData buildAppTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.deepPurple, // Base color for many components
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.deepPurple, // Use a MaterialColor for swatch
      accentColor: AppStyles.secondaryColor, // Your secondary color
      backgroundColor: Colors.white,
      errorColor: Colors.redAccent,
      brightness: Brightness.light,
    ).copyWith(
      // Override specific scheme colors if needed
      primary: AppStyles.primaryColor, // Your specific primary
      secondary: AppStyles.secondaryColor,
      onPrimary: Colors.white, // Text/icons on primary color
      onSecondary: Colors.white, // Text/icons on secondary color
      surface: Colors.white, // Card/Dialog backgrounds
      onSurface: Colors.black87, // Text/icons on surface
      background: Colors.white, // Screen background
      onBackground: Colors.black87, // Text/icons on background
      error: Colors.red.shade400,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, // Default AppBar Background
      foregroundColor: Colors.black, // Default AppBar text/icons (back arrow)
      elevation: 1.0,
      iconTheme: IconThemeData(color: Colors.black), // Explicit icon theme
      titleTextStyle: AppStyles.headlineStyle, // Use your headline style
    ),
    textTheme: TextTheme(
      headline6:
          AppStyles.headlineStyle.copyWith(fontSize: 18), // Example adjustment
      bodyText1: AppStyles.bodyTextStyle,
      bodyText2: AppStyles.secondaryTextStyle,
      button: AppStyles.buttonTextStyle,
      // Define other styles like subtitle1, caption, etc.
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppStyles.primaryColor, // Use brand primary color
        onPrimary: Colors.white, // Text on button
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: AppStyles.buttonTextStyle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Consistent button shape
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppStyles.primaryColor, // Text color for text buttons
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: AppStyles.cardBorderRadius),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade300,
      space: 20, // Default vertical space
      thickness: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppStyles.primaryColor, width: 2.0),
      ),
      labelStyle: AppStyles.secondaryTextStyle,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppStyles.primaryColor,
      disabledColor: Colors.grey.shade400,
      selectedColor: AppStyles.primaryColor,
      secondarySelectedColor: AppStyles.secondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle:
          AppStyles.buttonTextStyle.copyWith(fontSize: 14), // White text
      secondaryLabelStyle:
          AppStyles.buttonTextStyle.copyWith(fontSize: 12), // Add this line
      brightness: Brightness.light, // Add this line
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppStyles.primaryColor, // Consistent bottom bar color
      elevation: 8.0,
    ),
    // Add other theme customizations (dialogTheme, etc.)
  );
}
