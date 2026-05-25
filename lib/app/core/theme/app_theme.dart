import 'package:flutter/material.dart';
import 'package:miplanner_v2/app/core/config/app_config.dart';

class AppTheme {
  AppTheme._();

  static Color get _primary => Color(AppConfigProvider.instance.primaryColor);
  static Color get _secondary => Color(AppConfigProvider.instance.secondaryColor);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      secondary: _secondary,
    ),
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      secondary: _secondary,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
  );
}
