import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/services/settings_service.dart';

class ConfiguracionController extends GetxController {
  final RxBool isDarkMode = false.obs;
  final RxString alarmSoundUri = ''.obs;
  final RxString currentLocale = 'es_MX'.obs;

  RxBool get isTimeFormat24h => SettingsService.to.isTimeFormat24hObs;

  @override
  void onInit() {
    super.onInit();
    _loadPrefs();
  }

  void _loadPrefs() {
    alarmSoundUri.value = SettingsService.to.alarmSoundUri ?? '';
    currentLocale.value = SettingsService.to.locale;
  }

  void toggleTheme(bool dark, BuildContext context) {
    isDarkMode.value = dark;
    if (dark) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }

  void onThemeChanged(AdaptiveThemeMode mode) {
    isDarkMode.value = mode == AdaptiveThemeMode.dark;
  }

  Future<void> toggleTimeFormat(bool use24h) async {
    await SettingsService.to.setTimeFormat24h(use24h);
  }

  Future<void> changeLocale(String localeKey) async {
    currentLocale.value = localeKey;
    await SettingsService.to.setLocale(localeKey);
    final parts = localeKey.split('_');
    Get.updateLocale(Locale(parts[0], parts[1]));
  }

  Future<void> pickAlarmSound() async {
    const intent = AndroidIntent(
      action: 'android.intent.action.RINGTONE_PICKER',
      arguments: {
        'android.intent.extra.ringtone.TYPE': 4,
        'android.intent.extra.ringtone.SHOW_SILENT': false,
        'android.intent.extra.ringtone.SHOW_DEFAULT': true,
      },
    );
    try {
      await intent.launch();
    } catch (_) {}
  }

  Future<void> saveAlarmSoundUri(String uri) async {
    alarmSoundUri.value = uri;
    await SettingsService.to.setAlarmSoundUri(uri);
  }
}
