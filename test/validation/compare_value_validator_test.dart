import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('CompareValueValidator', () {
    test('validates comparing value', () {
      void testRunner(String propertyName, dynamic compareToValue, ComparisionType comparisionType,
          String businessObjectActiveRuleSet, dynamic value, String expectedMessage, bool expectedIsValid,
          {RequiredEntry requiredEntry = RequiredEntry.yes,
          String ruleSet = StringCharacterConstants.stringEmpty,
          String friendlyName = StringCharacterConstants.stringEmpty,
          String additionalMessage = StringCharacterConstants.stringEmpty,
          String overrideErrorMessage = StringCharacterConstants.stringEmpty,
          AllowNullValue allowNullValue = AllowNullValue.no,
          bool causesException = false}) {
        // arrange
        final sut = CompareValueValidator(propertyName, compareToValue, comparisionType,
            requiredEntry: requiredEntry,
            ruleSet: ruleSet,
            friendlyName: friendlyName,
            additionalMessage: additionalMessage,
            overrideErrorMessage: overrideErrorMessage,
            allowNullValue: allowNullValue);

        if (causesException) {
          expect(() => sut.validate(value, businessObjectActiveRuleSet), throwsA(const TypeMatcher<OceanException>()));
          return;
        }

        // act
        final result = sut.validate(value, businessObjectActiveRuleSet);

        // assert
        if (result.isNotValid) {
          expect(result.brokenRule!.errorMessage, expectedMessage);
          expect(result.brokenRule!.propertyName, propertyName);
          expect(result.brokenRule!.ruleTypeName, 'CompareValueValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('propertyName', 7, ComparisionType.equal, ValidationConstants.insert, 7, '', true);
      testRunner('propertyName', 7, ComparisionType.equal, ValidationConstants.insert, null,
          'Property Name null value is not allowed.', false);
      testRunner('propertyName', 7, ComparisionType.equal, ValidationConstants.insert, null, '', true,
          allowNullValue: AllowNullValue.yes, requiredEntry: RequiredEntry.no);
      testRunner('propertyName', 7, ComparisionType.equal, ValidationConstants.insert, 'abc',
          'Property Name, type String, must be the same type as the compare value type int.', false);
      testRunner('propertyName', 7, ComparisionType.equal, ValidationConstants.insert, 9,
          'Property Name must be greater than to 7.', true,
          ruleSet: ValidationConstants.delete);

      // mixin tests
      testRunner('propertyName', 7, ComparisionType.equal, ValidationConstants.insert, 9,
          'Property Name must be equal to 7.', false);
      testRunner('propertyName', 7, ComparisionType.greaterThan, ValidationConstants.insert, 9, '', true);
      testRunner('propertyName', 7, ComparisionType.greaterThan, ValidationConstants.insert, 7,
          'Property Name must be greater than to 7.', false);
      testRunner('propertyName', 7, ComparisionType.greaterThanEqual, ValidationConstants.insert, 9, '', true);
      testRunner('propertyName', 7, ComparisionType.greaterThanEqual, ValidationConstants.insert, 6,
          'Property Name must be greater than or equal to 7.', false);
      testRunner('propertyName', 7, ComparisionType.lessThan, ValidationConstants.insert, 6, '', true);
      testRunner('propertyName', 7, ComparisionType.lessThan, ValidationConstants.insert, 7,
          'Property Name must be less than to 7.', false);
      testRunner('propertyName', 7, ComparisionType.lessThanEqual, ValidationConstants.insert, 7, '', true);
      testRunner('propertyName', 7, ComparisionType.lessThanEqual, ValidationConstants.insert, 8,
          'Property Name must be less than or equal to 7.', false);
    });

    test('exception thrown when property name is empty', () {
      expect(() => CompareValueValidator('', 'abc', ComparisionType.equal),
          throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      // arrange
      final sut = CompareValueValidator('propertyName', 'abc', ComparisionType.equal);
      // act
      // assert
      expect(() => sut.validate('abc', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
