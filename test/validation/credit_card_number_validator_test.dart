import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('CreditCardNumberValidator', () {
    test('validates credit card number', () {
      void testRunner(String propertyName, String businessObjectActiveRuleSet, dynamic value, String expectedMessage,
          bool expectedIsValid,
          {RequiredEntry requiredEntry = RequiredEntry.yes,
          String ruleSet = StringCharacterConstants.stringEmpty,
          String friendlyName = StringCharacterConstants.stringEmpty,
          String additionalMessage = StringCharacterConstants.stringEmpty,
          String overrideErrorMessage = StringCharacterConstants.stringEmpty,
          AllowNullValue allowNullValue = AllowNullValue.no}) {
        // arrange
        final sut = CreditCardNumberValidator(propertyName,
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
          expect(result.brokenRule!.ruleTypeName, 'CreditCardNumberValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('creditcardnumber', ValidationConstants.insert, '5555555555554444', '', true);
      testRunner('creditcardnumber', ValidationConstants.insert, '378282246310005', '', true);
      testRunner('creditcardnumber', ValidationConstants.insert, '371449635398431', '', true);
      testRunner('creditcardnumber', ValidationConstants.insert, '4111111111111111', '', true);
      testRunner('creditcardnumber', ValidationConstants.insert, '6011111111111117', '', true);
      testRunner('creditcardnumber', ValidationConstants.insert, '5555555555554449',
          'Creditcardnumber 5555555555554449 is not a valid credit card number.', false);

      testRunner('creditcardnumber', ValidationConstants.insert, null, 'Creditcardnumber null value is not allowed.', false);
      testRunner('creditcardnumber', ValidationConstants.insert, null, '', true,
          requiredEntry: RequiredEntry.no, allowNullValue: AllowNullValue.yes);
      testRunner('creditcardnumber', ValidationConstants.insert, '', '', true, requiredEntry: RequiredEntry.no);
      testRunner('creditcardnumber', ValidationConstants.insert, '074909669', '', true, ruleSet: ValidationConstants.update);
      testRunner('creditcardnumber', ValidationConstants.insert, '', 'Creditcardnumber is required.', false,
          requiredEntry: RequiredEntry.yes);
      testRunner('creditcardnumber', ValidationConstants.insert, '60A1111111111117',
          'Creditcardnumber 60A1111111111117 is not a valid credit card number.  Only numeric input is allowed.', false);
    });

    test('exception thrown when property name is empty', () {
      expect(() => CreditCardNumberValidator(''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not a string', () {
      // arrange
      final sut = CreditCardNumberValidator('propertyName');
      // act
      // assert
      expect(() => sut.validate(909661, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      // arrange
      final sut = CreditCardNumberValidator('propertyName');
      // act
      // assert
      expect(() => sut.validate('074909661', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}
