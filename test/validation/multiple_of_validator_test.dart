import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('MultipleOfValidator', () {
    test('validates routing number', () {
      void testRunner(
        String propertyName,
        int multipleOf,
        String businessObjectActiveRuleSet,
        dynamic value,
        String expectedMessage,
        bool expectedIsValid, {
        RequiredEntry requiredEntry = RequiredEntry.yes,
        String ruleSet = OceanStringCharacterConstants.stringEmpty,
        String friendlyName = OceanStringCharacterConstants.stringEmpty,
        String additionalMessage = OceanStringCharacterConstants.stringEmpty,
        String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
        AllowNullValue allowNullValue = AllowNullValue.no,
      }) {
        // arrange
        final sut = MultipleOfValidator(propertyName, multipleOf,
            requiredEntry: requiredEntry,
            ruleSet: ruleSet,
            friendlyName: friendlyName,
            additionalMessage: additionalMessage,
            overrideErrorMessage: overrideErrorMessage,
            allowNullValue: allowNullValue);

        // act
        final result = sut.validate(value, businessObjectActiveRuleSet);

        // assert
        if (result.isNotValid) {
          expect(result.brokenRule!.errorMessage, expectedMessage);
          expect(result.brokenRule!.propertyName, propertyName);
          expect(result.brokenRule!.ruleTypeName, 'MultipleOfValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('customerkind', 3, OceanValidationConstants.insert, 6, '', true);
      testRunner('customerkind', 3, OceanValidationConstants.insert, 3, '', true);
      testRunner('customerkind', 3, OceanValidationConstants.insert, 7, '', true, ruleSet: OceanValidationConstants.delete);
      testRunner(
          'customerkind', 3, OceanValidationConstants.insert, 7, 'Customerkind value 7 is not divisible by 3.', false);
      testRunner('customerkind', 3, OceanValidationConstants.insert, null, 'Customerkind null value is not allowed.', false);
      testRunner('customerkind', 3, OceanValidationConstants.insert, null, '', true, allowNullValue: AllowNullValue.yes);
    });

    test('exception thrown when property name is empty', () {
      expect(() => MultipleOfValidator('', 3), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not an int', () {
      final sut = MultipleOfValidator('propertyName', 3);
      expect(() => sut.validate(2.8, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      final sut = MultipleOfValidator('propertyName', 3);
      expect(() => sut.validate(3, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when multiple of not greater than zero.', () {
      expect(() => MultipleOfValidator('Hi', 0), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
