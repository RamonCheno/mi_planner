import 'package:miplanner_v2/app/core/config/app_config.dart';

class TrabajoConfig implements AppConfig {
  @override
  String get appName => 'MiPlanner Trabajo';

  @override
  String get dbName => 'trabajo.db';

  @override
  int get primaryColor => 0xFF2E7D32;

  @override
  int get secondaryColor => 0xFF66BB6A;

  @override
  Flavor get flavor => Flavor.trabajo;
}
