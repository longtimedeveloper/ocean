import 'package:example/lib.dart';
import 'package:ocean/ocean.dart';

class ApplicationSettings extends BusinessObjectBase {
  ApplicationSettings._();

  factory ApplicationSettings.create({String activeRuleSet = OceanValidationConstants.insert}) {
    final applicationSettings = ApplicationSettings._();
    applicationSettings.activeRuleSet = activeRuleSet;
    applicationSettings.checkAllRules();
    return applicationSettings;
  }

  factory ApplicationSettings.fromMap(Map<String, dynamic> map, {String activeRuleSet = OceanValidationConstants.update}) {
    final applicationSettings = ApplicationSettings._()
      .._defaultCategory = map[defaultCategoryPropertyName]
      .._notificationFrequency = map[notificationFrequencyPropertyName]
      .._showFavorites = map[showFavoritesPropertyName]
      .._showHiddenSettings = map[showHiddenSettingsPropertyName]
      .._storageLimit = map[storageLimitPropertyName]
      .._themeName = map[themeNamePropertyName]
      .._trashCanRetention = map[trashCanRetentionPropertyName];

    if (map[BusinessObjectBase.activeRuleSetPropertyName] != null) {
      applicationSettings.activeRuleSet = map[BusinessObjectBase.activeRuleSetPropertyName]!;
    } else {
      applicationSettings.activeRuleSet = activeRuleSet;
    }
    applicationSettings.checkAllRules();
    return applicationSettings;
  }

  /// Provides, defaultCategory
  static const String defaultCategoryPropertyName = 'defaultCategory';

  /// Provides, notificationFrequency
  static const String notificationFrequencyPropertyName = 'notificationFrequency';

  /// Provides, showFavorites
  static const String showFavoritesPropertyName = 'showFavorites';

  /// Provides, showHiddenSettings
  static const String showHiddenSettingsPropertyName = 'showHiddenSettings';

  /// Provides, storageLimit
  static const String storageLimitPropertyName = 'storageLimit';

  /// Provides, themeName
  static const String themeNamePropertyName = 'themeName';

  /// Provides, trashCanRetention
  static const String trashCanRetentionPropertyName = 'trashCanRetention';

  int _defaultCategory = OceanNumericConstants.zero;
  NotificationFrequency _notificationFrequency = NotificationFrequency.none;
  bool _showFavorites = false;
  bool _showHiddenSettings = false;
  double _storageLimit = 0;
  String _themeName = OceanStringCharacterConstants.stringEmpty;
  double _trashCanRetention = 0;

  @override
  Map<String, dynamic> toJson() => {
        BusinessObjectBase.activeRuleSetPropertyName: activeRuleSet,
        defaultCategoryPropertyName: defaultCategory,
        notificationFrequencyPropertyName: notificationFrequency,
        showFavoritesPropertyName: showFavorites,
        showHiddenSettingsPropertyName: showHiddenSettings,
        storageLimitPropertyName: storageLimit,
        themeNamePropertyName: themeName,
        trashCanRetentionPropertyName: trashCanRetention,
      };

  int get defaultCategory {
    return _defaultCategory;
  }

  NotificationFrequency get notificationFrequency {
    return _notificationFrequency;
  }

  bool get showFavorites {
    return _showFavorites;
  }

  bool get showHiddenSettings {
    return _showHiddenSettings;
  }

  double get storageLimit {
    return _storageLimit;
  }

  String get themeName {
    return _themeName;
  }

  double get trashCanRetention {
    return _trashCanRetention;
  }

  set defaultCategory(int value) {
    _defaultCategory = setPropertyValue(defaultCategoryPropertyName, _defaultCategory, value);
  }

  set notificationFrequency(NotificationFrequency value) {
    _notificationFrequency = setPropertyValue(notificationFrequencyPropertyName, _notificationFrequency, value);
  }

  set showFavorites(bool value) {
    _showFavorites = setPropertyValue(showFavoritesPropertyName, _showFavorites, value);
  }

  set showHiddenSettings(bool value) {
    _showHiddenSettings = setPropertyValue(showHiddenSettingsPropertyName, _showHiddenSettings, value);
  }

  set storageLimit(double value) {
    _storageLimit = setPropertyValue(storageLimitPropertyName, _storageLimit, value);
  }

  set themeName(String value) {
    _themeName = setPropertyValue(themeNamePropertyName, _themeName, value);
  }

  set trashCanRetention(double value) {
    _trashCanRetention = setPropertyValue(trashCanRetentionPropertyName, _trashCanRetention, value);
  }
}
