import 'dart:collection';
import 'validation.dart';

class BrokenValidationRules {
  BrokenValidationRules();

  final Map<String, List<BrokenRule>> _brokenRules = <String, List<BrokenRule>>{};

  bool get hasErrors {
    return _brokenRules.isNotEmpty;
  }

  bool get hasNoErrors {
    return !hasErrors;
  }

  void add(String ruleTypeName, String propertyName, String errorMessage, {manuallyAdded = false}) {
    if (_brokenRules[propertyName] != null) {
      _brokenRules[propertyName]!.add(BrokenRule(ruleTypeName, propertyName, errorMessage));
    } else {
      var brokenRulesList = <BrokenRule>[];
      brokenRulesList.add(BrokenRule(ruleTypeName, propertyName, errorMessage, manuallyAdded: manuallyAdded));
      _brokenRules[propertyName] = brokenRulesList;
    }
  }

  void addFromValidationResult(ValidationResult validationResult) {
    if (validationResult.isValid) {
      return;
    }
    for (var item in validationResult.validationErrors) {
      for (var brokenRule in item.values) {
        add(brokenRule.ruleTypeName, brokenRule.propertyName, brokenRule.errorMessage);
      }
    }
  }

  void clear() {
    _brokenRules.clear();
  }

  UnmodifiableListView<BrokenRule> getBrokenRules() {
    var brokenRules = <BrokenRule>[];
    if (hasErrors) {
      var brokenRulesList = _brokenRules.entries.toList();
      brokenRulesList.sort((a, b) => a.key.compareTo(b.key));
      for (var entry in brokenRulesList) {
        brokenRules.addAll(entry.value);
      }
    }

    return UnmodifiableListView(brokenRules);
  }

  UnmodifiableListView<BrokenRule> getBrokenRulesForProperty(String propertyName) {
    var brokenRules = <BrokenRule>[];
    if (hasErrors) {
      var brokenRulesList = _brokenRules.entries.where((element) => element.key == propertyName).toList();
      brokenRulesList.sort((a, b) => a.key.compareTo(b.key));
      for (var entry in brokenRulesList) {
        brokenRules.addAll(entry.value);
      }
    }

    return UnmodifiableListView(brokenRules);
  }

  bool remove(String propertyName) {
    if (_brokenRules.isNotEmpty && _brokenRules.containsKey(propertyName)) {
      if (_brokenRules[propertyName]!.where((element) => element.manuallyAdded).isNotEmpty) {
        _brokenRules[propertyName]!.removeWhere((element) => element.manuallyAdded == false);
      } else {
        if (_brokenRules.remove(propertyName) != null) {
          return true;
        }
      }
    }
    return false;
  }

  bool removeByRuleTypeName(String ruleTypeName, String propertyName) {
    if (_brokenRules.isNotEmpty && _brokenRules.containsKey(propertyName)) {
      if (_brokenRules[propertyName]!.any((element) => element.ruleTypeName == ruleTypeName)) {
        _brokenRules[propertyName]!.removeWhere((element) => element.ruleTypeName == ruleTypeName);
        if (_brokenRules[propertyName]!.isEmpty) {
          _brokenRules.removeWhere((key, value) => key == propertyName);
        }
        return true;
      }
    }
    return false;
  }
}
