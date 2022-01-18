import 'validation.dart';

class SharedValidationRulesManager {
  SharedValidationRulesManager._();

  static SharedValidationRulesManager? _instance;

  final Map<Type, ValidationRulesManager> _rules = <Type, ValidationRulesManager>{};

  static SharedValidationRulesManager get instance => _instance ??= SharedValidationRulesManager._();

  ValidationRulesManager getManager(Type type) {
    var manager = _rules[type];
    if (manager == null) {
      manager = ValidationRulesManager();
      _rules[type] = manager;
    }
    return manager;
  }
}
