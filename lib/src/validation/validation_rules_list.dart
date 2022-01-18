import 'validation.dart';

class ValidationRulesList {
  ValidationRulesList();

  final List<ValidatorBase> _rulesList = <ValidatorBase>[];

  List<ValidatorBase> get rulesList {
    return _rulesList;
  }
}
