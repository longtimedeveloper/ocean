import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('BooleanRequiredValidator', () {
    test('validates bool required', () {
      void testRunner(
        String propertyName,
        String businessObjectActiveRuleSet,
        dynamic value,
        String expectedMessage,
        bool expectedIsValid, {
        String ruleSet = OceanStringCharacterConstants.stringEmpty,
        String friendlyName = OceanStringCharacterConstants.stringEmpty,
        String additionalMessage = OceanStringCharacterConstants.stringEmpty,
        String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
      }) {
        // arrange
        final sut = BooleanRequiredValidator(propertyName,
            ruleSet: ruleSet,
            friendlyName: friendlyName,
            additionalMessage: additionalMessage,
            overrideErrorMessage: overrideErrorMessage);

        // act
        final result = sut.validate(value, businessObjectActiveRuleSet);

        // assert
        if (result.isNotValid) {
          expect(result.brokenRule!.errorMessage, expectedMessage);
          expect(result.brokenRule!.propertyName, propertyName);
          expect(result.brokenRule!.ruleTypeName, 'BooleanRequiredValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('iagree', OceanValidationConstants.insert, true, '', true);
      testRunner('iagree', OceanValidationConstants.insert, false, 'Iagree is required to be checked.', false);

      testRunner('iagree', OceanValidationConstants.insert, null, '', true, ruleSet: OceanValidationConstants.update);
      testRunner('iagree', OceanValidationConstants.insert, null, 'Iagree null value is not allowed.', false);
    });

    test('exception thrown when property name is empty', () {
      expect(() => BooleanRequiredValidator(''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not a bool', () {
      // arrange
      final sut = BooleanRequiredValidator('propertyName');
      // act
      // assert
      expect(() => sut.validate(909661, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      // arrange
      final sut = BooleanRequiredValidator('propertyName');
      // act
      // assert
      expect(() => sut.validate(true, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
