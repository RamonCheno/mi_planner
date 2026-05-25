import 'package:miplanner_v2/app/core/config/app_config.dart';

class PersonalConfig implements AppConfig {
  @override
  String get appName => 'MiPlanner';

  @override
  String get dbName => 'personal.db';

  @override
  int get primaryColor => 0xFF1976D2;

  @override
  int get secondaryColor => 0xFF03A9F4;

  @override
  Flavor get flavor => Flavor.personal;
}
