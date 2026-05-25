import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/bindings/initial_binding.dart';
import 'package:miplanner_v2/app/core/config/app_config.dart';
import 'package:miplanner_v2/app/core/theme/app_theme.dart';
import 'package:miplanner_v2/app/routes/app_pages.dart';
import 'package:miplanner_v2/app/translations/app_translations.dart';

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;
  final Locale initialLocale;

  const MyApp({
    super.key,
    this.savedThemeMode = AdaptiveThemeMode.system,
    this.initialLocale = const Locale('es', 'MX'),
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initial: savedThemeMode,
      builder: (theme, darkTheme) => GetMaterialApp(
        title: AppConfigProvider.instance.appName,
        debugShowCheckedModeBanner: false,

        theme: theme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,

        initialBinding: InitialBinding(),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,

        translationsKeys: AppTranslations.translationsKeys,
        locale: initialLocale,
        fallbackLocale: const Locale('es', 'MX'),
      ),
    );
  }
}
