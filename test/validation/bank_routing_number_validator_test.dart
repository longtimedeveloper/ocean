import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('BankRoutingNumberValidator', () {
    test('validates routing number', () {
      void testRunner(String propertyName, String businessObjectActiveRuleSet, dynamic value, String expectedMessage,
          bool expectedIsValid,
          {RequiredEntry requiredEntry = RequiredEntry.yes,
          String ruleSet = StringCharacterConstants.stringEmpty,
          String friendlyName = StringCharacterConstants.stringEmpty,
          String additionalMessage = StringCharacterConstants.stringEmpty,
          String overrideErrorMessage = StringCharacterConstants.stringEmpty,
          AllowNullValue allowNullValue = AllowNullValue.no}) {
        // arrange
        final sut = BankRoutingNumberValidator(propertyName,
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
          expect(result.brokenRule!.ruleTypeName, 'BankRoutingNumberValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('routingNumber', ValidationConstants.insert, '074909661', '', true);
      testRunner('routingNumber', ValidationConstants.insert, '074909669',
          'Routing Number 074909669 is not a valid bank routing number.', false);
      testRunner('routingNumber', ValidationConstants.insert, '974909669',
          'Routing Number 974909669 is not a valid bank routing number. The first digit must be a 0 or a 1.', false);
      testRunner(
          'routingNumber',
          ValidationConstants.insert,
          '0A4909669',
          'Routing Number 0A4909669 is not a valid bank routing number. All bank routing numbers are 9 digits in length.',
          false);

      testRunner('routingNumber', ValidationConstants.insert, '', '', true, requiredEntry: RequiredEntry.no);
      testRunner('routingNumber', ValidationConstants.insert, null, '', true,
          requiredEntry: RequiredEntry.no, allowNullValue: AllowNullValue.yes);
      testRunner('routingNumber', ValidationConstants.insert, null, 'Routing Number null value is not allowed.', false);
      testRunner('routingNumber', ValidationConstants.insert, '', 'Routing Number is required.', false,
          requiredEntry: RequiredEntry.yes);

      testRunner('routingNumber', ValidationConstants.insert, '074909669', '', true,
          ruleSet: ValidationConstants.update); // that would have returned invalid rule is skipped

      testRunner('routingNumber', ValidationConstants.insert, '074909669',
          'Cool Routing Number 074909669 is not a valid bank routing number.', false,
          friendlyName: 'Cool Routing Number');
      testRunner('routingNumber', ValidationConstants.insert, '074909669',
          'Routing Number 074909669 is not a valid bank routing number. Copy from your check!', false,
          additionalMessage: 'Copy from your check!');
      testRunner('routingNumber', ValidationConstants.insert, '074909669', 'How about a valid routing number?', false,
          overrideErrorMessage: 'How about a valid routing number?');
    });

    test('exception thrown when property name is empty', () {
      expect(() => BankRoutingNumberValidator(''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not a string', () {
      // arrange
      final sut = BankRoutingNumberValidator('propertyName');
      // act
      // assert
      expect(() => sut.validate(909661, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      // arrange
      final sut = BankRoutingNumberValidator('propertyName');
      // act
      // assert
      expect(() => sut.validate('074909661', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
