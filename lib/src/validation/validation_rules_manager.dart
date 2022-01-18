import '../infrastructure/infrastructure.dart';
import '../extensions/extensions.dart';
import '../ocean_constants.dart';
import 'validation.dart';

class ValidationRulesManager {
  ValidationRulesManager();

  final Map<String, ValidationRulesList> _rules = <String, ValidationRulesList>{};

  bool get hasRules {
    return _rules.isNotEmpty;
  }

  void addRule(ValidatorBase rule) {
    var list = getRulesForProperty(rule.propertyName).rulesList;
    if (rule.allowMultiple == AllowMultiple.no) {
      var found = list.where(
        (element) => element.propertyName == rule.propertyName && element.runtimeType == rule.runtimeType,
      );
      if (found.isNotEmpty) {
        throw OceanArgumentException(
          rule.runtimeType.toString(),
          MessageConstants.multipleValidationRulesNotAllowedFormat
              .formatString(rule.runtimeType.toString(), rule.propertyName),
        );
      }
    }

    list.add(rule);
  }

  Map<String, ValidationRulesList> getRulesForEntity() {
    return _rules;
  }

  ValidationRulesList getRulesForProperty(String propertyName) {
    if (_rules.containsKey(propertyName)) {
      return _rules[propertyName]!;
    }
    var validationRulesList = ValidationRulesList();
    _rules[propertyName] = validationRulesList;
    return validationRulesList;
  }

  bool hasRulesForProperty(String propertyName) {
    if (!_rules.containsKey(propertyName)) {
      return false;
    }
    return _rules[propertyName]!.rulesList.isNotEmpty;
  }
}
