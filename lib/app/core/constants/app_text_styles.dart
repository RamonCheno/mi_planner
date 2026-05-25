import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const body1 = TextStyle(fontSize: 16);
  static const body2 = TextStyle(fontSize: 14);
  static const caption = TextStyle(fontSize: 12, letterSpacing: 0.4);

  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );
}
