import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('RangeValidator', () {
    test('validates routing number', () {
      void testRunner(
        String propertyName,
        RangeBoundaryType lowerBoundary,
        dynamic lowerValue,
        RangeBoundaryType upperBoundary,
        dynamic upperValue,
        String businessObjectActiveRuleSet,
        dynamic value,
        String expectedMessage,
        bool expectedIsValid, {
        RequiredEntry requiredEntry = RequiredEntry.yes,
        String ruleSet = StringCharacterConstants.stringEmpty,
        String friendlyName = StringCharacterConstants.stringEmpty,
        String additionalMessage = StringCharacterConstants.stringEmpty,
        String overrideErrorMessage = StringCharacterConstants.stringEmpty,
        AllowNullValue allowNullValue = AllowNullValue.no,
      }) {
        // arrange
        final sut = RangeValidator(propertyName, lowerBoundary, lowerValue, upperBoundary, upperValue,
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
          expect(result.brokenRule!.ruleTypeName, 'RangeValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner(
          'age', RangeBoundaryType.inclusive, 10, RangeBoundaryType.inclusive, 50, ValidationConstants.insert, 10, '', true);
      testRunner(
          'age', RangeBoundaryType.inclusive, 10, RangeBoundaryType.inclusive, 50, ValidationConstants.insert, 50, '', true);
      testRunner(
          'age', RangeBoundaryType.exclusive, 10, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, 11, '', true);
      testRunner(
          'age', RangeBoundaryType.exclusive, 10, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, 49, '', true);

      testRunner(
          'age', RangeBoundaryType.inclusive, 10, RangeBoundaryType.inclusive, 50, ValidationConstants.insert, 9, '', true,
          ruleSet: ValidationConstants.delete);
      testRunner('age', RangeBoundaryType.inclusive, 10, RangeBoundaryType.inclusive, 50, ValidationConstants.insert, 9,
          'Age must be greater than or equal to 10.', false);
      testRunner('age', RangeBoundaryType.inclusive, 10, RangeBoundaryType.inclusive, 50, ValidationConstants.insert, 51,
          'Age must be less than or equal to 50.', false);
      testRunner('age', RangeBoundaryType.exclusive, 10, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, 10,
          'Age must be greater than to 10.', false);
      testRunner('age', RangeBoundaryType.exclusive, 10, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, 50,
          'Age must be less than to 50.', false);

      testRunner('age', RangeBoundaryType.exclusive, 10, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, null,
          'Age null value is not allowed.', false);
      testRunner('age', RangeBoundaryType.exclusive, 10, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, null,
          '', true,
          allowNullValue: AllowNullValue.yes, requiredEntry: RequiredEntry.no);

      testRunner('age', RangeBoundaryType.exclusive, 10, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, 2.6,
          'Age, type double, must be the same type as the compare value type int.', false);
      testRunner('age', RangeBoundaryType.exclusive, 10.1, RangeBoundaryType.exclusive, 50, ValidationConstants.insert, 2.6,
          'Age, type double, must be the same type as the compare value type int.', false);
    });

    test('exception thrown when property name is empty', () {
      expect(() => RangeValidator('', RangeBoundaryType.inclusive, 5, RangeBoundaryType.inclusive, 10),
          throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      final sut = RangeValidator('propertyName', RangeBoundaryType.inclusive, 5, RangeBoundaryType.inclusive, 10);
      expect(() => sut.validate(6, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
