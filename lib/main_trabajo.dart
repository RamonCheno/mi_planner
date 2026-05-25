import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:miplanner_v2/app/app.dart';
import 'package:miplanner_v2/app/core/bootstrap.dart';
import 'package:miplanner_v2/app/core/config/app_config.dart';
import 'package:miplanner_v2/app/core/config/trabajo_config.dart';
import 'package:miplanner_v2/app/core/services/settings_service.dart';

// Ejecutar:   fvm flutter run --flavor trabajo -t lib/main_trabajo.dart
// Compilar:   fvm flutter build apk --flavor trabajo -t lib/main_trabajo.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX', null);
  AppConfigProvider.setConfig(TrabajoConfig());
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
