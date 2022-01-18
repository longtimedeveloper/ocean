import '../src.dart';

class StringFormatRulesManager {
  StringFormatRulesManager();

  final Map<String, StringFormatRule> _rules = <String, StringFormatRule>{};

  bool get hasRules {
    return _rules.isNotEmpty;
  }

  Map<String, StringFormatRule> get rules {
    return _rules;
  }

  void addRule(String propertyName, StringFormatRule stringFormatRule) {
    if (propertyName.isEmpty) {
      throw OceanArgumentException(
        propertyName,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(propertyName),
      );
    }
    if (_rules.containsKey(propertyName)) {
      throw OceanArgumentException(
        propertyName,
        MessageConstants.multipleStringFormateRulesNotAllowedFormat
            .formatString(_rules[propertyName].runtimeType, propertyName),
      );
    }
    _rules[propertyName] = stringFormatRule;
  }

  StringFormatRule? getRuleForProperty(String propertyName) {
    return _rules[propertyName];
  }

  bool hasRuleForProperty(String propertyName) {
    return _rules[propertyName] != null;
  }
}
