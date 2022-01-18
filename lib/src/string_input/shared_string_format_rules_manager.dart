import 'string_input.dart';

class SharedStringFormatRulesManager {
  SharedStringFormatRulesManager._();

  static SharedStringFormatRulesManager? _instance;

  final Map<Type, StringFormatRulesManager> _rules = <Type, StringFormatRulesManager>{};

  static SharedStringFormatRulesManager get instance => _instance ??= SharedStringFormatRulesManager._();

  StringFormatRulesManager getManager(Type type) {
    var manager = _rules[type];
    if (manager == null) {
      manager = StringFormatRulesManager();
      _rules[type] = manager;
    }
    return manager;
  }
}
