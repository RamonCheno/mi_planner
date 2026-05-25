enum Flavor { personal, trabajo }

abstract class AppConfig {
  String get appName;
  String get dbName;
  int    get primaryColor;
  int    get secondaryColor;
  Flavor get flavor;
}

class AppConfigProvider {
  AppConfigProvider._();

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static void setConfig(AppConfig config) => _instance = config;
}
