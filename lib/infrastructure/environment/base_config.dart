abstract class BaseConfig {
  String get baseUrl;
  String get prefsName;
}

class StagingConfig implements BaseConfig {
  @override String get baseUrl => '';

  @override String get prefsName => 'nutrenaissance_dev_prefs';

}

class ProductionConfig implements BaseConfig {
  @override String get baseUrl => '';

  @override String get prefsName => '';

}