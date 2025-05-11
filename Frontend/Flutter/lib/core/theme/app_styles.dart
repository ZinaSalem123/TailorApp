// lib/core/constants/app_styles.dart
import 'package:flutter/material.dart';

class AppStyles {
  static const String nameApp = "Tailor App";
  static const Color primaryColor =
      Color(0xFF673AB7); // fromARGB(255, 135, 70, 84)
  static const Color secondaryColor =
      Color(0xFF673AB7); // fromARGB(255, 175, 106, 117)

  static const TextStyle headlineStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle headlineStyle2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );
  static const TextStyle headlineStyle3 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  static const TextStyle bodyTextStyle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle secondaryTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // --- Other Constants ---
  static const double borderRadiusValue = 15.0;
  static const Radius borderRadiusCircular = Radius.circular(borderRadiusValue);
  static BorderRadius cardBorderRadius =
      BorderRadius.circular(borderRadiusValue);

  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(10.0);
}
