import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:miplanner_v2/app/core/constants/app_constants.dart';

class SettingsService extends GetxService {
  static SettingsService get to => Get.find<SettingsService>();

  late SharedPreferences _prefs;

  late final RxBool isTimeFormat24hObs;

  Future<SettingsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    isTimeFormat24hObs = RxBool(_prefs.getBool(AppConstants.timeFormatKey) ?? false);
    return this;
  }

  bool get isTimeFormat24h => isTimeFormat24hObs.value;

  Future<void> setTimeFormat24h(bool value) async {
    isTimeFormat24hObs.value = value;
    await _prefs.setBool(AppConstants.timeFormatKey, value);
  }

  String? get alarmSoundUri => _prefs.getString(AppConstants.alarmSoundKey);

  Future<void> setAlarmSoundUri(String uri) async =>
      await _prefs.setString(AppConstants.alarmSoundKey, uri);

  String get locale => _prefs.getString(AppConstants.localeKey) ?? 'es_MX';

  Future<void> setLocale(String localeKey) async =>
      await _prefs.setString(AppConstants.localeKey, localeKey);

  Object? get(String key) => _prefs.get(key);

  Future<void> set(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else {
      await _prefs.setString(key, value.toString());
    }
  }

  Future<void> remove(String key) async => await _prefs.remove(key);
  bool has(String key) => _prefs.containsKey(key);
}
