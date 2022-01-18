import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('StringLengthValidator', () {
    test('description', () {
      void testRunner(String propertyName, int minimumLength, int maximumLength, String businessObjectActiveRuleSet,
          dynamic value, String expectedMessage, bool expectedIsValid,
          {String ruleSet = StringCharacterConstants.stringEmpty,
          String friendlyName = StringCharacterConstants.stringEmpty,
          String additionalMessage = StringCharacterConstants.stringEmpty,
          String overrideErrorMessage = StringCharacterConstants.stringEmpty,
          AllowNullValue allowNullValue = AllowNullValue.no,
          AllowMultiple allowMultiple = AllowMultiple.no}) {
        // arrange
        final sut = StringLengthValidator(propertyName, minimumLength, maximumLength,
            ruleSet: ruleSet,
            friendlyName: friendlyName,
            additionalMessage: additionalMessage,
            overrideErrorMessage: overrideErrorMessage,
            allowNullValue: allowNullValue,
            allowMultiple: allowMultiple);

        // act
        final result = sut.validate(value, businessObjectActiveRuleSet);

        // assert
        if (result.isNotValid) {
          expect(result.brokenRule!.errorMessage, expectedMessage);
          expect(result.brokenRule!.propertyName, propertyName);
          expect(result.brokenRule!.ruleTypeName, 'StringLengthValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('firstName', 1, 25, ValidationConstants.insert, 'hi', '', true);
      testRunner('firstName', 1, 25, ValidationConstants.insert, '', 'First Name is shorter than 1.', false);
      testRunner('firstName', 1, 5, ValidationConstants.insert, 'dddddd', 'First Name is longer than 5.', false);

      testRunner('firstName', 1, 5, ValidationConstants.insert, 'dddddd', '', true, ruleSet: ValidationConstants.delete);
      testRunner('firstName', 1, 5, ValidationConstants.insert, null, 'First Name null value is not allowed.', false);
      testRunner('firstName', 1, 5, ValidationConstants.insert, null, '', true, allowNullValue: AllowNullValue.yes);
    });

    test('exception thrown when property name is empty', () {
      expect(() => StringLengthValidator('', 3, 10), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      final sut = StringLengthValidator('propertyName', 3, 10);
      expect(() => sut.validate('ddd', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not a string', () {
      final sut = StringLengthValidator('propertyName', 3, 10);
      expect(() => sut.validate(2.8, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when minimum length is less than zero', () {
      expect(() => StringLengthValidator('propertyName', -1, 25), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when maximum length is less than minimum', () {
      expect(() => StringLengthValidator('propertyName', 10, 9), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when maximum length is less than minimum', () {
      expect(
          () => StringLengthValidator.maximumOnly('propertyName', 0), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
