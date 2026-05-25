import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:miplanner_v2/app/app.dart';
import 'package:miplanner_v2/app/core/bootstrap.dart';
import 'package:miplanner_v2/app/core/config/app_config.dart';
import 'package:miplanner_v2/app/core/config/personal_config.dart';
import 'package:miplanner_v2/app/core/services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfigProvider.setConfig(PersonalConfig());
  await initAsyncServices();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final savedLocale    = _parseLocale(SettingsService.to.locale);

  runApp(MyApp(
    savedThemeMode: savedThemeMode ?? AdaptiveThemeMode.system,
    initialLocale: savedLocale,
  ));
}

Locale _parseLocale(String localeKey) {
  final parts = localeKey.split('_');
  return parts.length == 2 ? Locale(parts[0], parts[1]) : const Locale('es', 'MX');
}
