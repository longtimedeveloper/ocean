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
        String ruleSet = StringCharacterConstants.stringEmpty,
        String friendlyName = StringCharacterConstants.stringEmpty,
        String additionalMessage = StringCharacterConstants.stringEmpty,
        String overrideErrorMessage = StringCharacterConstants.stringEmpty,
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

      testRunner('iagree', ValidationConstants.insert, true, '', true);
      testRunner('iagree', ValidationConstants.insert, false, 'Iagree is required to be checked.', false);

      testRunner('iagree', ValidationConstants.insert, null, '', true, ruleSet: ValidationConstants.update);
      testRunner('iagree', ValidationConstants.insert, null, 'Iagree null value is not allowed.', false);
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
