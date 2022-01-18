import 'validation.dart';

class ValidationRulesManagerWrapper {
  ValidationRulesManagerWrapper(ValidationRulesManager validationRulesManager) {
    _validationRulesManager = validationRulesManager;
  }

  late final ValidationRulesManager _validationRulesManager;

  void addRule(ValidatorBase rule) {
    _validationRulesManager.addRule(rule);
  }
}
