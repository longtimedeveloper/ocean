import 'string_input.dart';

class StringFormatRulesManagerWrapper {
  StringFormatRulesManagerWrapper(StringFormatRulesManager stringFormatRulesManager) {
    _stringFormatRulesManager = stringFormatRulesManager;
  }

  late final StringFormatRulesManager _stringFormatRulesManager;

  void addRule(String propertyName, StringFormatRule stringFormatRule) {
    _stringFormatRulesManager.addRule(propertyName, stringFormatRule);
  }
}
