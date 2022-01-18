import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('ValidationRulesManager', () {
    test('Multiple rules can be added to same property, same validation rule, when allowMultiple: AllowMultiple.yes.', () {
      // arrange
      final sut = ValidationRulesManager();

      // act
      sut.addRule(
          ComparePropertyValidator('firstName', 'lastName', ComparisionType.notEqual, allowMultiple: AllowMultiple.yes));
      sut.addRule(
          ComparePropertyValidator('firstName', 'nickName', ComparisionType.notEqual, allowMultiple: AllowMultiple.yes));

      // assert
      expect(sut.hasRules, true);
    });

    test(
        'Multiple rules can not be added to same property, same validation rule, when allowMultiple: AllowMultiple.no which is the default.',
        () {
      // arrange
      final sut = ValidationRulesManager();

      // act
      sut.addRule(StringLengthValidator.maximumOnly('firstName', 5));

      // assert
      final rule = StringLengthValidator.maximumOnly('firstName', 2);

      expect(() => sut.addRule(rule), throwsA(isInstanceOf<OceanArgumentException>()));
    });
  });
}
