import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('USStateAbbreviationValidator', () {
    test('validates state abbreviations', () {
      void testRunner(String propertyName, String businessObjectActiveRuleSet, dynamic value, String expectedMessage,
          bool expectedIsValid,
          {RequiredEntry requiredEntry = RequiredEntry.yes,
          String ruleSet = StringCharacterConstants.stringEmpty,
          String friendlyName = StringCharacterConstants.stringEmpty,
          String additionalMessage = StringCharacterConstants.stringEmpty,
          String overrideErrorMessage = StringCharacterConstants.stringEmpty,
          AllowNullValue allowNullValue = AllowNullValue.no,
          AllowMultiple allowMultiple = AllowMultiple.no}) {
        // arrange
        final sut = USStateAbbreviationValidator(propertyName,
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
          expect(result.brokenRule!.ruleTypeName, 'USStateAbbreviationValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('customerkind', ValidationConstants.insert, 'IN', '', true);
      testRunner(
          'customerkind', ValidationConstants.insert, 'in', 'Customerkind state abbreviation (in) is not valid.', false);
      testRunner('customerkind', ValidationConstants.insert, 'in', '', true, ruleSet: ValidationConstants.delete);
      testRunner('customerkind', ValidationConstants.insert, null, 'Customerkind null value is not allowed.', false);
      testRunner('customerkind', ValidationConstants.insert, null, '', true, allowNullValue: AllowNullValue.yes);
      testRunner('customerkind', ValidationConstants.insert, '', '', true, requiredEntry: RequiredEntry.no);
      testRunner('customerkind', ValidationConstants.insert, '', 'Customerkind is required.', false);
    });

    test('exception thrown when property name is empty', () {
      expect(() => USStateAbbreviationValidator(''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not a string', () {
      final sut = USStateAbbreviationValidator('propertyName');
      expect(() => sut.validate(2.8, ValidationConstants.insert), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      final sut = USStateAbbreviationValidator('propertyName');
      expect(() => sut.validate('us', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
