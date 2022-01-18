import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('BrokenValidationRules', () {
    test('add broken rule, violate it, and then clear the errors.', () {
      // arrange
      final sut = BrokenValidationRules();
      sut.add('StringLength', 'firstName', 'must be 3');
      // act
      final brokenRules = sut.getBrokenRulesForProperty('firstName');
      final brokenRule = brokenRules.first;

      // assert
      expect(sut.hasErrors, true);
      expect(brokenRule.errorMessage, 'must be 3');
      expect(brokenRule.propertyName, 'firstName');
      expect(brokenRule.ruleTypeName, 'StringLength');

      sut.clear();
      expect(sut.hasErrors, false);
    });

    test('add broken rule from ValidationResult, and then clear the errors.', () {
      // arrange
      final sut = BrokenValidationRules();
      final rule = BrokenRule('StringLength', 'firstName', 'must be 3');
      final rule2 = BrokenRule('RegEx', 'firstName', 'must be 3');
      final list = <Map<String, BrokenRule>>[];

      final ruleMap = <String, BrokenRule>{};
      ruleMap['firstName'] = rule;

      final rule2Map = <String, BrokenRule>{};
      rule2Map['firstName'] = rule2;

      list.add(ruleMap);
      list.add(rule2Map);
      final result = ValidationResult(list);
      sut.addFromValidationResult(result);

      // act
      final brokenRules = sut.getBrokenRulesForProperty('firstName');
      final brokenRule = brokenRules.first;
      final brokenRule2 = brokenRules.elementAt(1);

      // assert
      expect(sut.hasErrors, true);
      expect(brokenRule.errorMessage, 'must be 3');
      expect(brokenRule.propertyName, 'firstName');
      expect(brokenRule.ruleTypeName, 'StringLength');
      expect(brokenRule2.errorMessage, 'must be 3');
      expect(brokenRule2.propertyName, 'firstName');
      expect(brokenRule2.ruleTypeName, 'RegEx');

      sut.clear();
      expect(sut.hasErrors, false);
    });
  });
}
